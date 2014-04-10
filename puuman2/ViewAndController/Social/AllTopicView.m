//
//  AllTopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllTopicView.h"


@implementation AllTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[Forum sharedInstance] addDelegateObject:self];
        address = 0;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:YES];
    [_showColumnView setScrollEnabled:YES];
    [self addSubview:_showColumnView];

  
}

- (void)reloadAllTopic
{
    [[Forum sharedInstance] getActiveTopic];
}

- (void)activeTopicReceived
{

    [[Forum sharedInstance] removeDelegateObject:self];
    [_showColumnView reloadData];
     address = [Forum sharedInstance].onTopic.TNo;
    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
   
}

- (void)activeTopicFailed
{
    [[Forum sharedInstance] removeDelegateObject:self];
}

- (void)setVerticalFrame
{
    
    
    [_showColumnView setContentSize:CGSizeMake( self.frame.size.width*2, self.frame.size.height)];
    [_showColumnView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  
   [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
}

- (void)setHorizontalFrame
{
  
    [_showColumnView setContentSize:CGSizeMake( self.frame.size.width*2, self.frame.size.height)];
    [_showColumnView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_showColumnView setContentOffset:CGPointMake(self.frame.size.width*(address -1), 0)];
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
    [_showColumnView setContentOffset:CGPointMake(_showColumnView.contentOffset.x + self.frame.size.width, 0) animated:YES];

}

- (void)preTopic
{
    address--;
    [_showColumnView setContentOffset:CGPointMake(_showColumnView.contentOffset.x - self.frame.size.width, 0) animated:YES];
}


@end
