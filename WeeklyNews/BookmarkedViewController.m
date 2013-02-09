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
    NewsModel *newsModel;

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
    NSLog(@"viewAppear");
    newsModel = [NewsModel shared];
    [self.tableView setAllowsSelection:YES];
    [self.navigationController.navigationBar setHidden:NO];
    
    [self.tableView reloadData];
    
    newsModel.bookmarkedArray = [[[newsModel.bookmarkedArray reverseObjectEnumerator] allObjects] mutableCopy];
    
    NSLog(@"newsModel.bookMarkedArray is %@",newsModel.bookmarkedArray);

//    [self.tableView setEditing:YES animated:YES];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [newsModel.bookmarkedArray objectAtIndex:indexPath.row];
    NSString *href = [dic objectForKey:@"href"];
    newsModel.currentHref = href;
    DetailViewController *dvc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:dvc animated:NO];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [newsModel.bookmarkedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *titleStr;
    if ([newsModel.bookmarkedArray objectAtIndex:indexPath.row]){
         titleStr = [[newsModel.bookmarkedArray objectAtIndex:indexPath.row] valueForKey:@"content"];
    }
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.numberOfLines = 5;
        
        
        
        cell.textLabel.text = titleStr;
        [cell setSelectionStyle:UITableViewCellStyleValue2];
        [cell setBackgroundColor:[UIColor redColor]];
        
        
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
    NSDictionary *dic = [newsModel.bookmarkedArray objectAtIndex:btn.tag];
    [newsModel.bookmarkedArray removeObject:dic];
    // 一番最初にリバースした奴なので、もう一回リバースしてもとに戻す。
//    [ud setObject:bookmarkedArray forKey:@"bookmarkedArray"];
    
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dic = [newsModel.bookmarkedArray objectAtIndex:indexPath.row];
        [newsModel.bookmarkedArray removeObject:dic];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // 挿入処理
    }
}

#pragma mark - Table view delegate



- (IBAction)onTappedEditButton:(id)sender {
    if ([self.navigationItem.rightBarButtonItem.title isEqual:@"Edit"]){
        [self setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Cancel"];
    }else{
        [self setEditing:NO animated:NO];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    }
}
@end
