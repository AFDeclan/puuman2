//
//  WareInfoView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "WareInfoView.h"
#import "UniverseConstant.h"

@implementation WareInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    infoTableView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
    [infoTableView setBackgroundColor:[UIColor clearColor]];
    [infoTableView setColumnViewDelegate:self];
    [infoTableView setViewDataSource:self];
    [infoTableView setPagingEnabled:YES];
    [self addSubview:infoTableView];
    
    

}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 128;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    return 4;
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"WareInfoCell";
    UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *bgView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 80)];
        [cell.contentView addSubview:bgView];
        [bgView setBackgroundColor:PMColor5];
        
        UILabel *infoName= [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 88, 24)];
        [infoName setTextColor:PMColor2];
        [infoName setBackgroundColor:[UIColor clearColor]];
        [infoName setFont:PMFont3];
        [infoName setTag:10];
        [cell.contentView addSubview:infoName];
        
        UILabel *detailInfo= [[UILabel alloc] initWithFrame:CGRectMake(16, 36,88, 44)];
        [detailInfo setTextColor:PMColor1];
        [detailInfo setBackgroundColor:[UIColor clearColor]];
        [detailInfo setFont:PMFont2];
        [detailInfo setTag:11];
        [cell.contentView addSubview:detailInfo];
        
    }
    
    UILabel *infoName = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *detailInfo = (UILabel *)[cell.contentView viewWithTag:11];
    [infoName setText:@"产地"];
    [detailInfo setText:@"黑龙江双城"];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView.layer setMasksToBounds:YES];
    return cell;
    
}


@end
