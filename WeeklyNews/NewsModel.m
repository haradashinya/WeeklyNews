//
//  NewsModel.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/11/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
-(id)init
{
    self.items = [[NSMutableArray alloc] init];
    return self;
}
-(void)fetchNews
{
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost:5000/latest"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSString  *JSON) {
        
        for (NSDictionary *obj in [JSON valueForKey:@"data"]){
            NSString *content = [obj valueForKey:@"content"];
            NSString *href = [obj valueForKey:@"href"];
            if (content != NULL || href != NULL){
                [self.items addObject:@{@"content": content,@"href": href}];
            }
        }
        
        
        [self.delegate receivedNews ];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
}

@end
