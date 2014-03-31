//
//  PuumanRankPartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanRankPartnerDataView.h"
#import "PuumanPartnerDataCell.h"

@implementation PuumanRankPartnerDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"DataPuumanRankCell";
    PuumanPartnerDataCell *cell = (PuumanPartnerDataCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[PuumanPartnerDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    [cell setPumanWithNum:200 andRank:1];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (void)reloadWithGroupInfo:(Group *)group
{
    [super reloadWithGroupInfo:group];
}

- (void)setVerticalFrame
{
    [dataColumnView setFrame:CGRectMake(22, 0, 576, 224)];
}

- (void)setHorizontalFrame
{
     [dataColumnView setFrame:CGRectMake(152, 0, 576, 224)];
}

@end
