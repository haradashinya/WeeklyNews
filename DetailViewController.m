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


-(void)startObservingSwipeLeftAction
{
    
    UISwipeGestureRecognizer *swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
    
    [swiper setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [[self view] addGestureRecognizer:swiper];
    
}

-(void)startObservingSwipeRightAction
{
    
    
    UISwipeGestureRecognizer *swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
    
    [swiper setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [[self view] addGestureRecognizer:swiper];
    
}
-(void)onSwipeLeft:(id)sender
{
    NSLog(@"left");
//    [self.navigationController pushViewController:mvc animated:NO];
}

// on back
-(void)onSwipeRight:(id)sender
{
    NSLog(@"right");
//
//    MainViewController *mvc = [[MainViewController alloc] init];
//    NSLog(@"left");
//    [self.navigationController pushViewController:mvc animated:NO
    [self.navigationController popViewControllerAnimated:YES];
}

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
    
    NSLog(@"osss");
    [self startObservingSwipeRightAction];
    [self startObservingSwipeLeftAction];
        
 
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
