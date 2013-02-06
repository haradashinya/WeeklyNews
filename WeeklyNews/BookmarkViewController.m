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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath  *)indexPath{
    return 90.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [bookmarkedArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.textLabel.numberOfLines = 5;
        // もしもインサートされてたら消す。deleteを表示する。
        
        [cell setSelectionStyle:UITableViewCellStyleValue2];
        [cell setBackgroundColor:[UIColor redColor]];
        
    }
    @try {
        if (bookmarkedArray){
            NSDictionary *data = [bookmarkedArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [[bookmarkedArray objectAtIndex:indexPath.row] objectForKey:@"content"];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
            int rowNum = [bookmarkedArray indexOfObject:data];
            btn.tag = rowNum;
            [btn addTarget:self action:@selector(onToggle:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
            btn.titleLabel.text = @"minus";
            cell.accessoryView = btn;
            
            
        }
    }
    @catch (NSException * e) {
        [cell.textLabel setText:@""];
    }
    // Configure the cell.
    
    return cell;
}


@end
