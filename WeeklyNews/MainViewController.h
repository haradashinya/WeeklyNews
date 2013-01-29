//
//  MainViewController.h
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/10/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "NewsModel.h"
#import "DetailViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end
