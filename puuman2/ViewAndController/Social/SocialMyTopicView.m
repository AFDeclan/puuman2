//
//  SocialMyTopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialMyTopicView.h"
#import "UniverseConstant.h"
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"
#import "SinglePhotoTopicVIew.h"

@implementation SocialMyTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[Forum sharedInstance] addDelegateObject:self];
        status = [[NSMutableDictionary alloc] init];
        [self initialization];

    }
    return self;
}

- (void)initialization
{
    myTopicTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 608, 944)];
    [myTopicTable setBackgroundColor:PMColor5];
    [myTopicTable setDelegate:self];
    [myTopicTable setDataSource:self];
    [myTopicTable setSeparatorColor:[UIColor clearColor]];
    [myTopicTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTopicTable setShowsHorizontalScrollIndicator:NO];
    [myTopicTable setShowsVerticalScrollIndicator:NO];
    [self addSubview:myTopicTable];
    if (!_refreshHeader) {
        _refreshHeader = [[MJRefreshHeaderView alloc] init];
        _refreshHeader.scrollView = myTopicTable;
        [myTopicTable addSubview:_refreshHeader];
        [_refreshHeader setDelegate:self];
        _refreshHeader.alpha = 1;
        
        _refreshHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [[Forum sharedInstance] getMoreMyReplies:5 newDirect:YES];
        };
    }

}


- (void)showView
{
    [super showView];
    [self performSelector:@selector(refreshMyTopicTable) withObject:nil afterDelay:0];
}

- (void)refreshMyTopicTable
{
    if ([[[Forum sharedInstance] myReplies] count] == 0) {
        [_refreshHeader beginRefreshing];
    }else{
        [myTopicTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
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
    if ([replay.texts count] != 0) {
        identifier = @"MyTextTopicCell";
        cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell  =[[TextTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
    }else if ([replay.photoUrls count] !=0)
    {
        if ([replay.photoUrls count] == 1) {
            identifier = @"MySinglePhotoTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[SinglePhotoTopicVIew alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        }else{
            identifier = @"MyPhotoTopicCell";
            cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell  =[[PhotoTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
        }
        
    }else{
        if (!cell) {
            cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    [cell setRow:[indexPath row]];
    [cell setIsMyTopic:YES];
    [cell buildWithReply:replay];
    [cell setUnfold:[[status valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]]] boolValue]];
    [cell setDelegate:self];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (void)changedStausWithUnfold:(BOOL)unfold andIndex:(NSInteger)index
{
    [status setValue:[NSNumber numberWithBool:unfold] forKeyPath:[NSString stringWithFormat:@"%d",index]];
    [myTopicTable reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Reply *replay = [[[Forum sharedInstance] myReplies] objectAtIndex:[indexPath row]];
    return  [TopicCell heightForReply:replay andIsMyTopic:YES andTopicType:[[replay photoUrls] count]>0?TopicType_Photo:TopicType_Text andUnfold:[[status valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]]] boolValue]];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (myTopicTable.contentSize.height - myTopicTable.contentOffset.y < myTopicTable.frame.size.height*2 ) {
        if (![[Forum sharedInstance] noMore]) {
            [[Forum sharedInstance] getMoreMyReplies:5 newDirect:NO];
        }
        
    }
}

- (void)myRepliesLoadedMore
{
    if (_refreshHeader.isRefreshing)
    {
        [_refreshHeader endRefreshing];
        [status removeAllObjects];
        [myTopicTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

    }else{
        [myTopicTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void)myRepliesLoadFailed
{
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
}




- (void)setVerticalFrame
{
    [myTopicTable setFrame:CGRectMake(0, 0, 608, 944)];
}

- (void)setHorizontalFrame
{
    [myTopicTable setFrame:CGRectMake(128, 0, 608, 688)];
}

@end
