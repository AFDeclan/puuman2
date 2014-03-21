//
//  SortTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SortTableViewController.h"

@interface SortTableViewController ()

@end

@implementation SortTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        right_sortBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 24)];
        [right_sortBtn addTarget:self action:@selector(rightSortSelected) forControlEvents:UIControlEventTouchUpInside];
      
        left_sortBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 304, 24)];
        [left_sortBtn addTarget:self action:@selector(leftSortSelected) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    leftSelected = YES;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,608, 24)];
    [view addSubview:left_sortBtn];
    [view addSubview:right_sortBtn];
    return view;
}

- (void)leftSortSelected
{

    [left_sortBtn selected];
    [right_sortBtn unSelected];
}

- (void)rightSortSelected
{
    [right_sortBtn selected];
    [left_sortBtn unSelected];
}

@end
