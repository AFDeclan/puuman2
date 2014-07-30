//
//  AllTopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllTopicView.h"
#import "MainTabBarController.h"
#import "CustomAlertViewController.h"
@implementation AllTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        address = 0;
        [self setBackgroundColor:[UIColor clearColor]];
        [MyNotiCenter addObserver:self selector:@selector(gotoCurrentTopic) name:Noti_GoToCurrentTopic object:nil];
    }
    return self;
}


- (void)reloadAllTopic
{
    [[Forum sharedInstance] removeDelegateObject:self];
    [[Forum sharedInstance] addDelegateObject:self];
    [[Forum sharedInstance] getActiveTopic];
}



- (void)reloadTopicsTable
{
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
        _showColumnView = nil;
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setColumnViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:NO];
    [self addSubview:_showColumnView];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
   // [(TopicContentCell *)[_showColumnView cellForIndex:address-1] loadInfo];

}
- (void)activeTopicReceived
{
    [[Forum sharedInstance] removeDelegateObject:self];
    [self reloadTopicsTable];
     address = [Forum sharedInstance].onTopic.TNo;
    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
   
}

- (void)activeTopicFailed
{
    [CustomAlertViewController showAlertWithTitle:@"网络不给力哦~" confirmRightHandler:^{
        
    }];
    
//    [[Forum sharedInstance] removeDelegateObject:self];
//    [self reloadTopicsTable];
//    address = [Forum sharedInstance].onTopic.TNo;
//    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
}

- (void)setVerticalFrame
{

    [_showColumnView setContentSize:CGSizeMake( self.frame.size.width*([[Forum sharedInstance] onTopic].TNo +1), self.frame.size.height)];
    [_showColumnView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
}

- (void)setHorizontalFrame
{
  
    [_showColumnView setContentSize:CGSizeMake( self.frame.size.width*([[Forum sharedInstance] onTopic].TNo +1), self.frame.size.height)];
    [_showColumnView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
}

- (void)gotoCurrentTopic
{
    address = [[Forum sharedInstance] onTopic].TNo;
    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address-1), 0)];
}


#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return self.frame.size.width;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    if ([[Forum sharedInstance] onTopic]) {
         return [[Forum sharedInstance] onTopic].TNo+1;
    }else{
        return 0;
    }
    
   
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"TopicContentCell";
    TopicContentCell *cell = (TopicContentCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[TopicContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setDelegate:self];
    }
    [cell setInfoViewWithTopicNum:index+1];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}


- (void)nextTopic
{
    address ++;
    [_showColumnView setContentOffset:CGPointMake(_showColumnView.contentOffset.x + self.frame.size.width, 0) ];
   // [self performSelector:@selector(sendLoadNoti:) withObject:[NSNumber numberWithInt:address] afterDelay:0];
}

- (void)preTopic
{
    address--;
    [_showColumnView setContentOffset:CGPointMake(_showColumnView.contentOffset.x - self.frame.size.width, 0) ];
   // [self performSelector:@selector(sendLoadNoti:) withObject:[NSNumber numberWithInt:address] afterDelay:0];

}

- (void)sendLoadNoti:(NSNumber *)num
{
    PostNotification(Noti_loadTopicCell,num);

}


//回复上传成功
- (void)topicReplyUploaded:(ReplyForUpload *)reply
{
    PostNotification(Noti_AddTopic, nil);
    [[Forum sharedInstance] removeDelegateObject:self];
    
}

//回复上传失败
- (void)topicReplyUploadFailed:(ReplyForUpload *)reply
{
    
}

- (void)removeColumnView
{
    [_showColumnView removeFromSuperview];
    _showColumnView = nil;
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
