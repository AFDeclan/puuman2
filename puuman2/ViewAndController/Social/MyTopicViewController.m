//
//  MyTopicViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MyTopicViewController.h"
#import "VotingCell.h"
#import "TopicCell.h"
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"

@interface MyTopicViewController ()

@end

@implementation MyTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[Forum sharedInstance] removeDelegateObject:self];
    [[Forum sharedInstance] addDelegateObject:self];

    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
//	// Do any additional setup after loading the view.
    if (!_refreshFooter) {
        _refreshFooter = [[MJRefreshFooterView alloc] init];
        _refreshFooter.scrollView = self.tableView;
        [self.tableView addSubview:_refreshFooter];
        [_refreshFooter setDelegate:self];
        _refreshFooter.alpha = 1;
        __block MJRefreshFooterView * blockRefreshFooter = _refreshFooter;
        _refreshFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [[Forum sharedInstance] getMoreMyReplies:5 newDirect:NO];
            if (![[Forum sharedInstance] noMore])
            {
                [blockRefreshFooter endRefreshing];
            }
        };
      
    }
    
    if (!_refreshHeader) {
        _refreshHeader = [[MJRefreshHeaderView alloc] init];
        _refreshHeader.scrollView = self.tableView;
        [self.tableView addSubview:_refreshHeader];
        [_refreshHeader setDelegate:self];
        _refreshHeader.alpha = 1;
     //   __block MJRefreshHeaderView * blockRefreshFooter = _refreshHeader;
        _refreshHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [[Forum sharedInstance] getMoreMyReplies:5 newDirect:YES];

        };
        
    }
    [_refreshFooter beginRefreshing];
}

- (void)reloadMyTopic
{
   // [_refreshHeader beginRefreshing];
  //  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVerticalFrame
{
    
}

- (void)setHorizontalFrame
{

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
  
    
    return [[[Forum sharedInstance] myReplies] count];
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    TopicCell *cell;
    Reply *replay = [[[Forum sharedInstance] myReplies] objectAtIndex:[indexPath row]];
    if ([replay.textUrls count] != 0) {
        identifier = @"MyTextTopicCell";
        cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell  =[[TextTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
    }else if ([replay.photoUrls count] !=0)
    {
        identifier = @"MyPhotoTopicCell";
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
    [cell setIsMyTopic:YES];
    [cell buildWithReply:replay];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Reply *replay = [[[Forum sharedInstance] myReplies] objectAtIndex:[indexPath row]];
   return  [TopicCell heightForReply:replay andIsMyTopic:YES andTopicType:[[replay photoUrls] count]>0?TopicType_Photo:TopicType_Text];
  
}


- (void)myRepliesLoadedMore
{
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
    [self.tableView reloadData];
}

- (void)myRepliesLoadFailed
{
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
    [self.tableView reloadData];
}

@end
