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
    NSUserDefaults *ud;
    // bookmarked news data.
    NSMutableArray *bookmarkedArray;
    // currentRowofindex;
    int currentRow;
    // 一回loadMoreCellが呼ばれるたびに、rowのリセットが発生するので、そのたびにcurMulを位置増やして5かける.
}

-(void)setUpUserDefaults
{
    
    ud = [NSUserDefaults standardUserDefaults];
    if (![[ud objectForKey:@"bookmarkedArray"] respondsToSelector:@selector(count)] ){
        bookmarkedArray = [[NSMutableArray alloc ] init];
        [ud setObject:bookmarkedArray  forKey:@"bookmarkedArray"];
    }else{
        bookmarkedArray = [ud objectForKey:@"bookmarkedArray"];
    }
    [ud synchronize];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUserDefaults];
    
    // 最初に表示するCell
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 10;i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    newsModel = [NewsModel shared];
    newsModel.delegate = self;
    [newsModel fetchLatestNumber];
    for(int i = 0 ; i < 20;i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    // newDataArrayの数だけ、Cellを増やす。
    newDataArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < 20;i++){
        [newDataArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self.tableView reloadData];
}

-(void)receivedNews
{
    NSLog(@"received");
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
        // スクロールが一番下に行ったら、currentNumberを一つ減らして、currentNumberを監視しているメソッドが新しいニュースを取得する。
        newsModel.currentNumber -= 1;
    }
}

// cellの高さの設定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath  *)indexPath{
    return 90.0;
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
        cell.textLabel.numberOfLines = 5;
        // もしもインサートされてたら消す。deleteを表示する。
        
        [cell setSelectionStyle:UITableViewCellStyleValue2];
        [cell setBackgroundColor:[UIColor redColor]];

    }
    @try {
        if (newsModel.items){
            NSDictionary *data = [newsModel.items objectAtIndex:indexPath.row];
            cell.textLabel.text = [[newsModel.items objectAtIndex:indexPath.row] objectForKey:@"content"];
            NSLog(@"callflflflflfflflfllfl");
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
            int rowNum = [newsModel.items indexOfObject:data];
            btn.tag = rowNum;
            
            [btn addTarget:self action:@selector(onToggle:) forControlEvents:UIControlEventTouchUpInside];
            if ([self hasContainedDataInBookmarkedArray:data]){
                [btn setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
                btn.titleLabel.text = @"minus";
            }else{
                
                [btn setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
                btn.titleLabel.text = @"plus";
                
            }
            cell.accessoryView = btn;
            
            
        }
    }
    @catch (NSException * e) {
        [cell.textLabel setText:@""];
    }
    // Configure the cell.
    
    return cell;
}
// if news Item already exist in bookmarked data , then return YES.
-(Boolean )hasContainedDataInBookmarkedArray:(NSDictionary *)data
{
    if ([bookmarkedArray count] == 0) return NO;
    
    for(int i = 0; i < [bookmarkedArray count];i++){
        NSDictionary *bData = [bookmarkedArray objectAtIndex:i];
        // check alraedy exist.
        if ([data isEqual:bData]){
            return YES;
        }
    }
    return NO;
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        NSDictionary *dic = [newsModel.items objectAtIndex:indexPath.row];
        NSString *href = [dic objectForKey:@"href"];
        newsModel.currentHref = href;
        DetailViewController *dvc = [[DetailViewController alloc] init];
        [self.navigationController pushViewController:dvc animated:NO];


    }
    // if tapped Load More Btn;
    @catch (NSException * e) {
        NSLog(@"Footer selected");
    }
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tapped");
}

-(void)onToggle:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *t = btn.titleLabel.text;
    NSDictionary *data = [newsModel.items objectAtIndex:btn.tag];
    
    if ([t isEqual:@"plus"]){
        NSLog(@"called insert");
        //insert
        [bookmarkedArray addObject:data];
        NSLog(@"bookmarkdArray is %@",bookmarkedArray);
        [btn setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
        btn.titleLabel.text = @"minus";
    }else{
        //delete
        
        NSLog(@"called delete");
        [bookmarkedArray removeObject:data];
        [btn setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        btn.titleLabel.text = @"plus";
    }
    [ud setObject:bookmarkedArray forKey:@"bookmarkedArray"];
    [ud synchronize];
    
    
}




- (IBAction)onTappedStarButton:(id)sender {
}
@end
