//
//  MainViewController.m
//  WeeklyNews
//
//  Created by HARADA SHINYA on 1/10/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    NSMutableArray *newsTitles;
    NSMutableArray *newDataArray;
    NewsModel *newsModel;
    // currentRowofindex;
    int currentRow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", nil];
    newsModel = [[NewsModel alloc] init];
    newsModel.delegate = self;
    [newsModel fetchNews];
    for(int i = 0 ; i < 20;i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    newDataArray = [[NSMutableArray alloc] initWithObjects:@"New One", @"New Two", @"New Three", @"New Four", @"New Five", nil];

}

-(void)receivedNews
{
    [self.tableView reloadData];
}


/*
 To add more cells to table
 */
-(void)loadMoreCell{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < [newDataArray count]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.dataArray count] inSection:0];
        [indexPaths addObject:indexPath];
        [self.dataArray insertObject:[newDataArray objectAtIndex:i] atIndex:[self.dataArray count]];
    }
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)scrollViewDidEndDecelerating:(UITableView *)tableView {
    if (tableView.contentOffset.y > 0) {
        // Fetch data
        [self loadMoreCell];
        NSLog(@"Sroll is End");
    }
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count]+1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    @try {
        if (newsModel.items){
            // タイトルを表示する.
            [cell.textLabel setText:[[newsModel.items  objectAtIndex:indexPath.row] valueForKey:@"content"]];
            NSLog(@"newsModel.items is %i",[newsModel.items count]);
            NSLog(@"indexPath.row is %i",indexPath.row);
        }
    }
    @catch (NSException * e) {
        [cell.textLabel setText:@""];
    }
    [cell setSelectionStyle:UITableViewCellStyleValue2];
    // Configure the cell.
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        NSLog(@"Row selected at indexPath: %@", [self.dataArray objectAtIndex:indexPath.row]);
    }
    // if tapped Load More Btn;
    @catch (NSException * e) {
        NSLog(@"Footer selected");
    }
}



@end
