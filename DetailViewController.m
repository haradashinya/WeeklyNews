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
    UIWebView *webView;
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
    self.navigationController.navigationBarHidden = YES;
    webView = [[UIWebView alloc] init];
    CGRect rect = [[UIScreen mainScreen] bounds];
    webView.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    [webView setScalesPageToFit:YES];
    NSString *href = [newsModel currentHref];
    NSString *baseURL = [href substringWithRange:NSMakeRange(1, [href length] -3)];
    


    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:baseURL]];
    [webView loadRequest:req];
    [webView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
