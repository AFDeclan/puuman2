//
//  HeightPartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BodyPartnerDataView.h"
#import "BodyPartnerDataCell.h"

@implementation BodyPartnerDataView
@synthesize isHeight = _isHeight;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isHeight = YES;
    }
    return self;
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}



- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"DataBodyCell";
    BodyPartnerDataCell *cell = (BodyPartnerDataCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[BodyPartnerDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    }
    [cell setBodyData:100 andTheDate:nil andHighest:160 andLowest:40 andIsHeight:_isHeight];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
 
}

- (void)setVerticalFrame
{
    [dataColumnView setFrame:CGRectMake(22, 0, 576, 224)];
}

- (void)setHorizontalFrame
{
    [dataColumnView setFrame:CGRectMake(152, 0, 576, 224)];
}

- (void)setIsHeight:(BOOL)isHeight
{
    _isHeight =isHeight;
    [dataColumnView reloadData];
}
@end
