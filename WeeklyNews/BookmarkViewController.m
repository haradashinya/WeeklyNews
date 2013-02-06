//
//  BookmarkViewController.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 2/6/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "BookmarkViewController.h"

@interface BookmarkViewController ()

@end

@implementation BookmarkViewController
{
    NSUserDefaults *ud;
    NSArray *bookmarkedArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"calledddddd");
    NSLog(@"ffofofofofofofofofofofofofoof");
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    ud = [NSUserDefaults standardUserDefaults];
    
    bookmarkedArray = [ud objectForKey:@"bookmarkedArray"];
    
    
    NSLog(@"bookmarkedArray is %@",bookmarkedArray);
    
    
    NSLog(@"animated");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
