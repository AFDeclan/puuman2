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

@interface TopicAllTableViewController ()

@end

@implementation TopicAllTableViewController
@synthesize voting = _voting;
@synthesize topic = _topic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _voting = NO;
        [[Forum sharedInstance] addDelegateObject:self];
        replays = [[NSMutableArray alloc] init];

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
    
    if (_voting) {
   
        return [[Forum sharedInstance].votingTopic count];
    }else{
        return [replays count];
    }
    
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_voting) {
        static NSString *identifier = @"VotingCell";
        VotingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[VotingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell buildWithVoteTopic:[[Forum sharedInstance].votingTopic objectAtIndex:[indexPath row]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        
        
        
        
        NSString *identifier;
        TopicCell *cell;
        Reply *replay = [replays objectAtIndex:[indexPath row]];
        if ([replay.textUrls count] != 0) {
            identifier = @"ReplayTextTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[TextTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
        }else if ([replay.photoUrls count] !=0)
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
        [cell buildWithReply:replay];
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
        
        return  [TopicCell heightForReplay:[replays objectAtIndex:[indexPath row]]];
    }
   
    
    
}






- (void)setVoting:(BOOL)voting
{
    _voting = voting;
    if (voting) {
        [self.tableView reloadData];
    }
}

- (void)setTopic:(Topic *)topic
{
    
    
    if (!_refreshFooter) {
        _refreshFooter = [[MJRefreshFooterView alloc] init];
        _refreshFooter.scrollView = self.tableView;
        [self.tableView addSubview:_refreshFooter];
        [_refreshFooter setDelegate:self];
        _refreshFooter.alpha = 1;
        __block MJRefreshFooterView * blockRefreshFooter = _refreshFooter;

        _refreshFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [topic getMoreReplies:5];
            if (![topic noMore])
            {
                [blockRefreshFooter endRefreshing];
            }
        };
        [_refreshFooter beginRefreshing];
    

    }

}

//更多话题回复加载成功。
- (void)topicRepliesLoadedMore:(Topic *)topic
{
    _topic = topic;
    replays = topic.replies;
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



- (void)setVerticalFrame
{
    
}

- (void)setHorizontalFrame
{
  
}





@end
