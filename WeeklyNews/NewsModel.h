//
//  NewsModel.h
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/11/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NewsModel : NSObject
@property (nonatomic,strong) id delegate;
@property (nonatomic,strong) NSMutableArray *items;
-(void)fetchNews;
-(void)receivedNewsWith:(NSArray *)data;
-(void)receivedNews;

@end
