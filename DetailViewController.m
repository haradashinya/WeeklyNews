//
//  DetailViewController.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
{
    NewsModel *newsModel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        newsModel = [NewsModel shared];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
// ここにWebViewをロードする。
-(void)viewDidAppear:(BOOL)animated
{
    NSString *href = [newsModel currentHref];
    NSLog(@"view did appear %@",href);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
