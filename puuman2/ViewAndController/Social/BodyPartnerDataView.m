//
//  HeightPartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BodyPartnerDataView.h"
#import "BodyPartnerDataCell.h"
#import "ColorsAndFonts.h"

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

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [_group.GMember count];
    
}




- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"DataBodyCell";
    BodyPartnerDataCell *cell = (BodyPartnerDataCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[BodyPartnerDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    }
    if (_isHeight) {
        [cell setBodyData:((Member *)[_group.GMember objectAtIndex:index]).BabyHeight andTheDate:nil andHighest:max andLowest:min andIsHeight:_isHeight];
    }else{
        [cell setBodyData:((Member *)[_group.GMember objectAtIndex:index]).BabyWeight andTheDate:nil andHighest:max andLowest:min andIsHeight:_isHeight];
    }
    if (index == 0) {
        [cell setShowLine:NO];
    }else{
        [cell setShowLine:YES];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
 
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

- (void)setIsHeight:(BOOL)isHeight
{
    _isHeight =isHeight;
    [dataColumnView reloadData];
    if (isHeight) {
        [icon setImage:[UIImage imageNamed:@"icon_height_topic.png"]];
        [titleLabel setText:@"身高"];
       // [self setBackgroundColor:PMColor5];
    }else{
        [icon setImage:[UIImage imageNamed:@"icon_weight_topic.png"]];
        [titleLabel setText:@"体重"];
       // [self setBackgroundColor:[UIColor clearColor]];
    }
    
}

- (void)reloadWithGroupInfo:(Group *)group
{
    _group = group;
    min = 0;
    max = 0;
    for (int i = 0; i <[group.GMember count]; i ++) {
        float  value;
        if (_isHeight) {
            value = ((Member *)[group.GMember objectAtIndex:i]).BabyHeight;
        }else{
            value = ((Member *)[group.GMember objectAtIndex:i]).BabyWeight;
        }
    
        if (i== 0) {
            min = value;
            max =  value;
        }else{
        
            if (value > max) {
                max = value;
            }
            
            if (value < min) {
                min = value;
            }
        }
    }
    [super reloadWithGroupInfo:group];
    
}
@end
