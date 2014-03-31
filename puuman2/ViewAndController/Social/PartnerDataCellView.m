//
//  PartnerDataCellView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataCellView.h"

@implementation PartnerDataCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dataColumnView = [[UIColumnView alloc] init];
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
    
    return 0;
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    

    return nil;
    
}

- (void)setVerticalFrame
{
    
}

- (void)setHorizontalFrame
{

}

- (void)reloadWithGroupInfo:(Group *)group
{
    _group = group;
}


@end
