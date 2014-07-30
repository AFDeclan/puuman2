//
//  VoteTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VoteTableViewController.h"
#import "VotingCell.h"

@interface VoteTableViewController ()

@end

@implementation VoteTableViewController
@synthesize voteOrder = _voteOrder;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[Forum sharedInstance] addDelegateObject:self];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    if (!_refreshHeader) {
        _refreshHeader = [[MJRefreshHeaderView alloc] init];
        _refreshHeader.scrollView = self.tableView;
        [self.tableView addSubview:_refreshHeader];
        [_refreshHeader setDelegate:self];
        _refreshHeader.alpha = 1;
        __block VoteTableViewController * this = self;

        _refreshHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [[Forum sharedInstance] getMoreVotingTopic:5 orderBy:this.voteOrder newDirect:YES];
        };
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVoteOrder:(VotingTopicOrder)voteOrder
{
    _voteOrder = voteOrder;
    if ([[[Forum sharedInstance] votingTopic:_voteOrder] count] == 0) {
        [[Forum sharedInstance] getMoreVotingTopic:5 orderBy:_voteOrder newDirect:NO];
    }else{
        [self.tableView reloadData];
    }
}


//更多投票中话题获取成功
- (void)votingTopicLoadedMore
{
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
    [self.tableView reloadData];
}

//更多投票中话题获取失败
- (void)votingTopicLoadFailed
{
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Forum sharedInstance] votingTopic:_voteOrder] count];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"VotingCell";
    VotingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[VotingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell buildWithVoteTopic:[[[Forum sharedInstance] votingTopic:_voteOrder]  objectAtIndex:[indexPath row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentSize.height - self.tableView.contentOffset.y < self.tableView.frame.size.height*2 ) {
        [[Forum sharedInstance] getMoreVotingTopic:5 orderBy:_voteOrder newDirect:NO];
    
    }
}
@end
