//
//  NewsModel.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/11/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel



static NewsModel *newsModel;

+(id)shared
{
    if (!newsModel){
        newsModel = [[NewsModel alloc] init];
        newsModel.items = [[NSMutableArray alloc] init];
    }
    return newsModel;
}


-(id)init
{
    [self addObserver:self forKeyPath:@"currentNumber" options:NSKeyValueObservingOptionNew context:nil];
    self.items = [[NSMutableArray alloc] init];
    return self;
}
-(void)fetchNews
{
    [self fetchLatestNumber];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost:5000/latest"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSString  *JSON) {
        
        for (NSDictionary *obj in [JSON valueForKey:@"data"]){
            NSString *content = [obj valueForKey:@"content"];
            NSString *href = [obj valueForKey:@"href"];
            if (content != NULL || href != NULL ){
                if (![content isEqualToString:@"None"]){
                    [self.items addObject:@{@"content": content,@"href": href}];
                }
            }
        }
        
        
        [self.delegate receivedNews ];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
}

// fetch latest number from all articles
-(void)fetchLatestNumber
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:5000/latest_number"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.currentNumber = [[JSON valueForKey:@"data"] intValue];
        NSLog(@"called");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        return;
    }];
    [operation start];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentNumber"]){
        NSLog(@"currentNumber is %i",self.currentNumber);
    }
}







@end
