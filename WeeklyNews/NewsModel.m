//
//  NewsModel.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/11/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel



static NewsModel *newsModel = nil;
static NSString *baseURL = @"http://54.249.239.45/";

+(id)shared
{
    if (!newsModel){
        newsModel = [[NewsModel alloc] init];
        newsModel.items = [[NSMutableArray alloc] init];
        newsModel.bookmarkedArray = [[NSMutableArray alloc] init];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableArray *data = [ud objectForKey:@"bookmarkedArray"];
        if (data) newsModel.bookmarkedArray = data;
        
//        NSLog(@"newsModel.")
        
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
    // like 114.html
    NSString *num = [[NSString alloc] initWithFormat:@"%d",self.currentNumber];
    
//    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:5000/latest/%@",num];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/latest/%@",baseURL,num];
    
    NSLog(@"calle d fetch");
    
    NSURL *url = [[NSURL alloc] initWithString: urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSString  *JSON) {
        
        for (NSDictionary *obj in [JSON valueForKey:@"data"]){
            NSString *content = [ self parse:[obj valueForKey:@"content"]];
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/latest_number",baseURL];
//    NSURL *url = [NSURL URLWithString:@"http://localhost:5000/latest_number"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.currentNumber = [[JSON valueForKey:@"data"] intValue];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"errror: %@",[error localizedDescription]);
    }];
    [operation start];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 新しいニュース番号を取得できたら、ニュースを取得するようにする。
    if ([keyPath isEqualToString:@"currentNumber"]){
        NSLog(@"changed fifififfi");
        [self fetchNews ];
    }
    
}

-(NSString*)parse:(NSString*)str
{
    str  = [str stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
    str  = [str stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    str  = [str stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    str  = [str stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"’"];
    str  = [str stringByReplacingOccurrencesOfString:@"&#8211;" withString:@"-"];
//    NSData *data = [@"<html><p>&#8211 Test</p></html>" dataUsingEncoding:NSUTF8StringEncoding];

    return str;
}








@end
