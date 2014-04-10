//
//  PuumanRankPartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanRankPartnerDataView.h"
#import "PuumanPartnerDataCell.h"
#import "ColorsAndFonts.h"
#import "Member.h"

@implementation PuumanRankPartnerDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [icon setImage:[UIImage imageNamed:@"icon_bank_fri.png"]];
        [titleLabel setText:@"金库"];
        // [self setBackgroundColor:PMColor5];
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
    if (index == 0) {
        [cell setShowLine:NO];
    }else{
        [cell setShowLine:YES];
    }
    int rank = 1;
    CGFloat puuman = ((Member *)[_group.GMember objectAtIndex:index]).BabyPuuman;
    for (int i =0 ; i < [_group.GMember count]; i++) {
        if (puuman < ((Member *)[_group.GMember objectAtIndex:i]).BabyPuuman) {
            rank++;
        }
    }
    
    
    [cell setPumanWithNum:((Member *)[_group.GMember objectAtIndex:index]).BabyPuuman andRank:rank];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [_group.GMember count];
    
}

- (void)reloadWithGroupInfo:(Group *)group
{
    [super reloadWithGroupInfo:group];
}

- (void)setVerticalFrame
{
    [bgView setFrame:CGRectMake(0, 0, 608, 224)];
    [dataColumnView setFrame:CGRectMake(22, 0, 576, 224)];
}

- (void)setHorizontalFrame
{
    [bgView setFrame:CGRectMake(0, 0, 864, 224)];
     [dataColumnView setFrame:CGRectMake(152, 0, 576, 224)];
}

@end
