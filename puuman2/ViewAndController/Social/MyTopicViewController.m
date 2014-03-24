//
//  MyTopicViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MyTopicViewController.h"
#import "VotingCell.h"

@interface MyTopicViewController ()

@end

@implementation MyTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_like2_topic.png"] andTitle:@"最多投票" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_time2_topic.png"] andTitle:@"最新发起" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
         [self leftSortSelected];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    
    return 5;
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TopicCell";
    VotingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[VotingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 304;
  
    
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


@end
