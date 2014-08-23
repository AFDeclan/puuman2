//
//  AllTopicTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllTopicTableViewController.h"
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"
#import "SinglePhotoTopicVIew.h"
#import "ReplyForUpload.h"

@interface AllTopicTableViewController ()

@end

@implementation AllTopicTableViewController

@synthesize replyOrder = _replyOrder;
@synthesize topic = _topic;

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
        // Custom initialization
        status = [[NSMutableDictionary alloc] init];
        [[Forum sharedInstance] addDelegateObject:self];
        [MyNotiCenter addObserver:self selector:@selector(refreshTable:) name:Noti_RefreshTopicTable object:nil];
        [MyNotiCenter addObserver:self selector:@selector(addNewTopic) name:Noti_AddTopic object:nil];
        num = 0;

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setDelegate:self];
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

- (void)addNewTopic
{
    [_refreshHeader beginRefreshing];

}

- (void)setTopic:(Topic *)topic
{
    _topic = topic;
    if (!_refreshHeader) {
        _refreshHeader = [[MJRefreshHeaderView alloc] init];
        _refreshHeader.scrollView = self.tableView;
        [self.tableView addSubview:_refreshHeader];
        [_refreshHeader setDelegate:self];
        _refreshHeader.alpha = 1;
        __block AllTopicTableViewController * this = self;
        __block Topic * topic = _topic;
        _refreshHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [topic getMoreReplies:5 orderBy:this.replyOrder newDirect:YES ];
        };
        
    }
    
}

- (void)setReplyOrder:(TopicReplyOrder)replyOrder
{
    _replyOrder = replyOrder;
    [status removeAllObjects];
    if ([[_topic replies:_replyOrder] count] == 0) {
        num = [[_topic replies:_replyOrder] count];
        [_topic getMoreReplies:5 orderBy:_replyOrder newDirect:NO ];
    }else{

        [self.tableView reloadData];

    //   [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//更多话题回复加载成功。
- (void)topicRepliesLoadedMore:(Topic *)topic
{
  
    if (_refreshHeader.isRefreshing)
    {
        [_refreshHeader endRefreshing];
        [status removeAllObjects];
        [self.tableView reloadData];

      //  [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        if (num != [[_topic replies:_replyOrder] count]) {
            [status removeAllObjects];
            
            [self.tableView reloadData];
        }
        

      //  [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }

}

//更多话题回复加载失败。（可能是网络问题或者全部加载完毕，根据topic.noMore判断）
- (void)topicRepliesLoadFailed:(Topic *)topic
{
    NSLog(@"Replay Failed");
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_topic replies:_replyOrder] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    TopicCell *cell;
    
    NSArray  *replays = [_topic replies:_replyOrder];
    
    if (_topic.TType == TopicType_Text) {
        identifier = @"ReplayTextTopicCell";
        cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell  =[[TextTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
    }else if (_topic.TType == TopicType_Photo)
    {
        if ([[[replays objectAtIndex:[indexPath row]] photoUrls] count] >1) {
            identifier = @"ReplayPhotoTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[PhotoTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
        }else{
            identifier = @"ReplaySinglePhotoTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[SinglePhotoTopicVIew alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
        }
        
    }else{
        if (!cell) {
            cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    [cell setRow:[indexPath row]];
    [cell setIsMyTopic:NO];
    [cell buildWithReply:[replays objectAtIndex:[indexPath row]]];
    [cell setUnfold:[[status valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]]] boolValue]];
    [cell setDelegate:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray  *replays = [_topic replies:_replyOrder];
    return [TopicCell heightForReply:[replays objectAtIndex:[indexPath row]] andIsMyTopic:NO andTopicType:_topic.TType andUnfold:[[status valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]]] boolValue]];
}

- (void)changedStausWithUnfold:(BOOL)unfold andIndex:(NSInteger)index
{
    [status setValue:[NSNumber numberWithBool:unfold] forKeyPath:[NSString stringWithFormat:@"%d",index]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade ];
}

- (void)refreshTable:(NSNotification *)notification
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[notification object] integerValue] inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade ];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentSize.height - self.tableView.contentOffset.y < self.tableView.frame.size.height*2 ) {
        num = [[_topic replies:_replyOrder] count];
        [_topic getMoreReplies:5 orderBy:_replyOrder newDirect:NO];
        
    }
}




@end
