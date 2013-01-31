//
//  NewsModel.h
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/11/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <JSONKit.h>
#import "JSONKit.h"



@interface NewsModel : NSObject
@property (nonatomic,strong) id delegate;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSString *currentHref;
@property (nonatomic,assign) int currentNumber;
+(id)shared;
-(void)fetchNews;
-(void)fetchLatestNumber;
-(void)receivedNewsWith:(NSArray *)data;
-(void)receivedNews;

@end
