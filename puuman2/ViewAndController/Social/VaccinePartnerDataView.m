//
//  VaccinePartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VaccinePartnerDataView.h"
#import "VaccinePartnerDataCell.h"

@implementation VaccinePartnerDataView

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
    
    NSString * cellIdentifier = @"DataVaccineCell";
    VaccinePartnerDataCell *cell = (VaccinePartnerDataCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[VaccinePartnerDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (void)setVerticalFrame
{
     [dataColumnView setFrame:CGRectMake(16, 0, 576, 112)];
}

- (void)setHorizontalFrame
{
     [dataColumnView setFrame:CGRectMake(152, 0, 576, 112)];
}
@end
