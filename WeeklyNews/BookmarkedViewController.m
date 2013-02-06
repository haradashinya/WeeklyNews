//
//  BookmarkedViewController.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 2/6/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "BookmarkedViewController.h"

@interface BookmarkedViewController ()

@end

@implementation BookmarkedViewController
{
    NSUserDefaults *ud;
    NSMutableArray *bookmarkedArray;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    ud = [NSUserDefaults standardUserDefaults];
    
//    NSArray* reversedArray = [[startArray reverseObjectEnumerator] allObjects];

    bookmarkedArray = [[[[ud objectForKey:@"bookmarkedArray"] reverseObjectEnumerator] allObjects] mutableCopy];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"callleed");

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [bookmarkedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"%@",bookmarkedArray);
    NSString *titleStr;
    if ([bookmarkedArray objectAtIndex:indexPath.row]){
         titleStr = [[bookmarkedArray objectAtIndex:indexPath.row] valueForKey:@"content"];
    }
    
    
    if (cell == nil) {
        NSDictionary *data = [bookmarkedArray objectAtIndex:indexPath.row];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.numberOfLines = 5;
        
        
        
        cell.textLabel.text = titleStr;
        [cell setSelectionStyle:UITableViewCellStyleValue2];
        [cell setBackgroundColor:[UIColor redColor]];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        int rowNum = [bookmarkedArray indexOfObject:data];
        btn.tag = rowNum;
        [btn addTarget:self action:@selector(onToggle:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
        btn.titleLabel.text = @"minus";
        cell.accessoryView = btn;
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath  *)indexPath{
    return 90.0;
}


-(void)onToggle:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"btn.tag is %i",btn.tag);
    NSDictionary *dic = [bookmarkedArray objectAtIndex:btn.tag];
    [bookmarkedArray removeObject:dic];
    // 一番最初にリバースした奴なので、もう一回リバースしてもとに戻す。
    [ud setObject:bookmarkedArray forKey:@"bookmarkedArray"];
    
    [ud synchronize];
    // delete current row;
    
    [self.tableView reloadData];
    
    
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"dic is %@",[dic objectForKey:@"content"]);
}

@end
