//
//  PropWarePartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PropWarePartnerDataView.h"
#import "PropWarePartnerDataCell.h"

@implementation PropWarePartnerDataView

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
    
    NSString * cellIdentifier = @"DataPropCell";
    PropWarePartnerDataCell *cell = (PropWarePartnerDataCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[PropWarePartnerDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    return nil;
    
}

- (void)setVerticalFrame
{
      [dataColumnView setFrame:CGRectMake(16, 0, 576, 136)];
}

- (void)setHorizontalFrame
{
     [dataColumnView setFrame:CGRectMake(152, 0, 576, 136)];
}
@end
