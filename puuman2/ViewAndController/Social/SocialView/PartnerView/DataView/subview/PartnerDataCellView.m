//
//  PartnerDataCellView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataCellView.h"
#import "ColorsAndFonts.h"

@implementation PartnerDataCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(6, 8, 24, 24)];
        [self addSubview:icon];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 12, 216, 16)];
        [titleLabel setTextColor:PMColor4];
        [titleLabel setFont:PMFont2];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleLabel];
        
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
    if (dataColumnView) {
        [dataColumnView removeFromSuperview];
        dataColumnView = nil;
    }
    dataColumnView = [[UIColumnView alloc] init];
    [dataColumnView setBackgroundColor:[UIColor clearColor]];
    [dataColumnView setShowsHorizontalScrollIndicator:NO];
    [dataColumnView setShowsVerticalScrollIndicator:NO];
    [dataColumnView setColumnViewDelegate:self];
    [dataColumnView setViewDataSource:self];
    [dataColumnView setPagingEnabled:NO];
    [dataColumnView setScrollEnabled:YES];
    [self addSubview:dataColumnView];
   
}

- (void)setbgViewColor:(UIColor *)color
{
    [bgView setBackgroundColor:color];
}
@end
