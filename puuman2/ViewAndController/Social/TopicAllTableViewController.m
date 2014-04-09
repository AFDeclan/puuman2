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
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"
#import "ReplyForUpload.h"
#import "UniverseConstant.h"

@interface TopicAllTableViewController ()

@end

@implementation TopicAllTableViewController
@synthesize voting = _voting;
@synthesize topic = _topic;
@synthesize replyOrder =_replyOrder;
@synthesize voteOrder = _voteOrder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _voting = NO;
        _voteOrder =  VotingTopicOrder_Vote;
        _replyOrder = TopicReplyOrder_Vote;
        
        [[Forum sharedInstance] addDelegateObject:self];
        replays = [[NSArray alloc] init];
        [MyNotiCenter addObserver:self selector:@selector(refreshTable) name:Noti_RefreshTopicTable object:nil];
        [MyNotiCenter addObserver:self selector:@selector(refreshVoteTable) name:Noti_RefreshVoteTabe object:nil];
        [MyNotiCenter addObserver:self selector:@selector(refreshCellWithRow:) name:Noti_RefreshTextTopicCell object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
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
    
    return [replays count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_voting) {
        static NSString *identifier = @"VotingCell";
        VotingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[VotingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell buildWithVoteTopic:[replays objectAtIndex:[indexPath row]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        
        NSString *identifier;
        TopicCell *cell;
        if (_topic.TType == TopicType_Text) {
            identifier = @"ReplayTextTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[TextTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
        }else if (_topic.TType == TopicType_Photo)
        {
            identifier = @"ReplayPhotoTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[PhotoTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        }else{
            if (!cell) {
                cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        }
         [cell setRow:[indexPath row]];
        [cell setIsMyTopic:NO];
        [cell buildWithReply:[replays objectAtIndex:[indexPath row]]];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
   
    
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_voting) {
        
        return 108;
    }else{
        
        return  [TopicCell heightForReply:[replays objectAtIndex:[indexPath row]] andIsMyTopic:NO andTopicType:_topic.TType];
    }
   
    
    
}






- (void)setVoting:(BOOL)voting
{
    _voting = voting;
    if (voting) {
        [self.tableView reloadData];
        if (!_refreshFooter) {
            _refreshFooter = [[MJRefreshFooterView alloc] init];
            _refreshFooter.scrollView = self.tableView;
            [self.tableView addSubview:_refreshFooter];
            [_refreshFooter setDelegate:self];
            _refreshFooter.alpha = 1;
            __block MJRefreshFooterView * blockRefreshFooter = _refreshFooter;
            _refreshFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
               
                if (![[Forum sharedInstance] getMoreVotingTopic:5 orderBy:_voteOrder newDirect:NO])
                {
                    [blockRefreshFooter endRefreshing];
                }
            };
            
            [_refreshFooter beginRefreshing];
            
        }

        
        if (!_refreshHeader) {
            _refreshHeader = [[MJRefreshHeaderView alloc] init];
            _refreshHeader.scrollView = self.tableView;
            [self.tableView addSubview:_refreshHeader];
            [_refreshHeader setDelegate:self];
            _refreshHeader.alpha = 1;
            __block MJRefreshHeaderView * blockRefreshHeader = _refreshHeader;
            _refreshHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
                 [[Forum sharedInstance] getMoreVotingTopic:5 orderBy:_voteOrder newDirect:YES];
            };
            
            [_refreshHeader beginRefreshing];
            
        }
        

    }
}

- (void)setTopic:(Topic *)topic
{
    _topic = topic;
    if (!_refreshFooter) {
        _refreshFooter = [[MJRefreshFooterView alloc] init];
        _refreshFooter.scrollView = self.tableView;
        [self.tableView addSubview:_refreshFooter];
        [_refreshFooter setDelegate:self];
        _refreshFooter.alpha = 1;
        __block MJRefreshFooterView * blockRefreshFooter = _refreshFooter;
        _refreshFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [_topic getMoreReplies:5 orderBy:_replyOrder];
            if (![_topic noMoreReplies:_replyOrder])
            {
                [blockRefreshFooter endRefreshing];
            }
        };
    
        [_refreshFooter beginRefreshing];

    }
    
    [self.tableView reloadData];
}


- (void)setReplyOrder:(TopicReplyOrder)replyOrder
{
    _replyOrder = replyOrder;
    
    if ([_refreshFooter isRefreshing]) {
        [_refreshFooter endRefreshing];
    }
    replays = [_topic replies:_replyOrder];
    
    if ([replays count] < 5) {
        if (![_topic noMoreReplies:_replyOrder])
        {
            [_refreshFooter beginRefreshing];
        }
    }
   

}

- (void)setVoteOrder:(VotingTopicOrder)voteOrder
{
    _voteOrder = voteOrder;
    if ([_refreshFooter isRefreshing]) {
        [_refreshFooter endRefreshing];
    }
    replays = [[Forum sharedInstance] votingTopic:_voteOrder];
    if ([replays count] <5) {
        if (![[Forum sharedInstance] getMoreVotingTopic:5 orderBy:_voteOrder newDirect:NO])
        {
            [_refreshFooter endRefreshing];
        }
    }
}

//更多投票中话题获取成功
- (void)votingTopicLoadedMore
{
    replays = [[Forum sharedInstance] votingTopic:_voteOrder];
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    [self.tableView reloadData];
}

//更多投票中话题获取失败
- (void)votingTopicLoadFailed
{
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    [self.tableView reloadData];
}


//更多话题回复加载成功。
- (void)topicRepliesLoadedMore:(Topic *)topic
{
    
    replays = [topic replies:_replyOrder];
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    [self.tableView reloadData];

}

//更多话题回复加载失败。（可能是网络问题或者全部加载完毕，根据topic.noMore判断）
- (void)topicRepliesLoadFailed:(Topic *)topic
{
    NSLog(@"Replay Failed");
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    [self.tableView reloadData];
}

- (void)refreshTable
{
    [self.tableView  reloadData];
}





- (void)refreshVoteTable
{
      _voting = YES;
   
}


- (void)setVerticalFrame
{
    
}

- (void)setHorizontalFrame
{
  
}


- (void)refreshCellWithRow:(NSNotification *)notification
{
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:[[notification object] intValue] inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
