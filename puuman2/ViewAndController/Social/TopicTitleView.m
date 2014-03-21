//
//  TopicTitleView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicTitleView.h"

@implementation TopicTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_showColumnView setBackgroundColor:[UIColor clearColor]];
        [_showColumnView setViewDelegate:self];
        [_showColumnView setViewDataSource:self];
        [_showColumnView setPagingEnabled:NO];
        [_showColumnView setScrollEnabled:NO];
        [self addSubview:_showColumnView];
    }
    return self;
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
    
        NSString * cellIdentifier = @"TopicTitleCell";
        TopicTitleCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[TopicTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
  
}



@end
