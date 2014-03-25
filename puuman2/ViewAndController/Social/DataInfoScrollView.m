//
//  DataInfoScrollView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DataInfoScrollView.h"
#import "DataDetailInfoCell.h"

@implementation DataInfoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        dataColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 0, self.frame.size.width-22, 1432)];
        [dataColumnView setBackgroundColor:[UIColor clearColor]];
        [dataColumnView setShowsHorizontalScrollIndicator:NO];
        [dataColumnView setShowsVerticalScrollIndicator:NO];
        [dataColumnView setViewDelegate:self];
        [dataColumnView setViewDataSource:self];
        [dataColumnView setPagingEnabled:NO];
        [dataColumnView setScrollEnabled:YES];
        [self addSubview:dataColumnView];
    }
    return self;
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 96;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return 6;
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"DataCell";
    DataDetailInfoCell *cell = (DataDetailInfoCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[DataDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }

    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}


@end
