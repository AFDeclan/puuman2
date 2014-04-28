//
//  PartnerDataTitleView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataTitleView.h"
#import "ColorsAndFonts.h"
#import "PartnerPortraitDataViewCell.h"

@implementation PartnerDataTitleView

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
    portraitsView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [portraitsView setBackgroundColor:[UIColor clearColor]];
    [portraitsView setColumnViewDelegate:self];
    [portraitsView setViewDataSource:self];
    [portraitsView setPagingEnabled:YES];
    [portraitsView setScrollEnabled:YES];
    [self addSubview:portraitsView];
    
    bgHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [bgHeadView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_talk_fri.png"]]];
    [self addSubview:bgHeadView];
    
    
    icon_head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [icon_head setImage:[UIImage imageNamed:@"block_name_fri.png"]];
    [self addSubview:icon_head];
    
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setTextColor:[UIColor whiteColor]];
    [info_title setFont:PMFont2];
    [info_title setTextAlignment:NSTextAlignmentCenter];
    [info_title setText:@"三月宝宝妈妈团"];
    [icon_head addSubview:info_title];
    
    noti_label = [[UILabel alloc] initWithFrame:CGRectMake(320, 0, 276, 48)];
    [noti_label setText:@"三天前，天天邀请了w 入团"];
    [noti_label setFont:PMFont2];
    [noti_label setTextColor:PMColor3];
    [noti_label setBackgroundColor:[UIColor clearColor]];
    [self addSubview:noti_label];

}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return self.frame.size.width;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return 2;
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"TopicContentCell";
    PartnerPortraitDataViewCell *cell = (PartnerPortraitDataViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[PartnerPortraitDataViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}



@end
