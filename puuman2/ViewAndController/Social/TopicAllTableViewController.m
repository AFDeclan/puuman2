//
//  TopicAllTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicAllTableViewController.h"
#import "TopicCell.h"
#import "VotingCell.h"

@interface TopicAllTableViewController ()

@end

@implementation TopicAllTableViewController
@synthesize voting = _voting;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _voting = NO;
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
    return 10;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_voting) {
        static NSString *identifier = @"VotingCell";
        VotingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[VotingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *identifier = @"TopicCell";
        TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
   
    
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_voting) {
        return 108;
    }else{
        return 304;
    }
   
    
    
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


- (void)setVoting:(BOOL)voting
{
    _voting = voting;
    if (voting) {
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_like2_topic.png"] andTitle:@"最多投票" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_time2_topic.png"] andTitle:@"最新发起" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        

    }else{
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_like2_topic.png"] andTitle:@"最多喜欢" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_time2_topic.png"] andTitle:@"最新参与" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];

    }
    [self leftSortSelected];
    [self.tableView reloadData];
}

- (void)setVerticalFrame
{
    
}

- (void)setHorizontalFrame
{
  
}
@end
