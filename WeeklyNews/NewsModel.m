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
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost:5000/news"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self.items addObject:JSON];
        NSArray *data = [JSON valueForKey:@"data"];
        NSLog(@"data is %@",data);
        [self.delegate receivedNews ];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
}

@end
