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



- (void)setVerticalFrame
{
     //[_showColumnView reloadData];
    [_showColumnView setContentSize:CGSizeMake( self.frame.size.width*2, self.frame.size.height)];
    [_showColumnView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setHorizontalFrame
{
   // [_showColumnView reloadData];
     [_showColumnView setContentSize:CGSizeMake( self.frame.size.width*2, self.frame.size.height)];
    [_showColumnView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
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
    
    return 2;
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"TopicContentCell";
    TopicContentCell *cell = (TopicContentCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[TopicContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}



@end
