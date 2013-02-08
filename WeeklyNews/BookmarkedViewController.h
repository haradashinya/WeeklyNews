//
//  BookmarkedViewController.h
//  WeeklyNews
//
//  Created by HARADA SHINYA on 2/6/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "DetailViewController.h"

@interface BookmarkedViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)onTappedEditButton:(id)sender;

@end
