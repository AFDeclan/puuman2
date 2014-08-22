//
//  RankTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RankTableViewCell.h"
#import "UserInfo.h"
#import "MemberCache.h"
#import "UniverseConstant.h"
#import "UILabel+AdjustSize.h"
#import "Forum.h"
#import "Member.h"

@implementation RankTableViewCell
@synthesize row = _row;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[Friend sharedInstance] addDelegateObject:self];
        rank_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 40, 40)];
        [self.contentView addSubview:rank_icon];
        portrait=[[AFImageView alloc] initWithFrame:CGRectMake(48, 12, 40, 40)];
        [portrait setBackgroundColor:[UIColor blackColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        [self.contentView addSubview:portrait];
        info_name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [info_name setTextAlignment:NSTextAlignmentCenter];
        [info_name setTextColor:PMColor2];
        [info_name setFont:PMFont2];
        [info_name setBackgroundColor:[UIColor clearColor]];
        info_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(96, 20, 85, 48)];
        info_scroll.showsHorizontalScrollIndicator = NO;
        info_scroll.showsVerticalScrollIndicator = NO;
        info_scroll.userInteractionEnabled = NO;
        [self.contentView addSubview:info_scroll];
        [info_scroll addSubview:info_name];
        icon_sex = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        [info_scroll addSubview:icon_sex];
        icon_reply = [[UIImageView alloc]initWithFrame:CGRectMake(16, 56, 16, 16)];
        [icon_reply setImage:[UIImage imageNamed:@"btn_reply2_topic.png"]];
        [self.contentView addSubview:icon_reply];
        icon_like = [[UIImageView alloc]initWithFrame:CGRectMake(80, 56, 16, 16)];
        [icon_like setImage:[UIImage imageNamed:@"btn_like3_topic.png"]];
        [self.contentView addSubview:icon_like];
        UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(64, 60, 8, 8)];
        [add setTextAlignment:NSTextAlignmentCenter];
        [add setTextColor:PMColor3];
        [add setFont:PMFont3];
        [add setText:@"+"];
        [add setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:add];
        UILabel *equal = [[UILabel alloc] initWithFrame:CGRectMake(128, 60, 40, 8)];
        [equal setTextAlignment:NSTextAlignmentCenter];
        [equal setTextColor:PMColor3];
        [equal setFont:PMFont3];
        [equal setText:@"="];
        [equal setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:equal];
        
        info_reply = [[UILabel alloc] initWithFrame:CGRectMake(32, 60, 40, 10)];
         [info_reply setTextAlignment:NSTextAlignmentCenter];
        [info_reply setTextColor:PMColor3];
        [info_reply setFont:PMFont3];
        [info_reply setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:info_reply];
        info_like = [[UILabel alloc] initWithFrame:CGRectMake(96, 60, 40, 10)];
         [info_like setTextAlignment:NSTextAlignmentCenter];
        [info_like setTextColor:PMColor3];
        [info_like setFont:PMFont3];
        [info_like setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:info_like];
        total = [[UILabel alloc] initWithFrame:CGRectMake(144, 60, 40, 10)];
         [total setTextAlignment:NSTextAlignmentCenter];
        [total setTextColor:PMColor3];
        [total setFont:PMFont3];
        [total setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:total];
        UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 78, 192, 2)];
        [partLine setImage:[UIImage imageNamed:@"line_topic.png"]];
        [self.contentView addSubview:partLine];
    }
    return self;
}

- (void)setRow:(NSInteger)row
{
    Rank *rank =[[[Forum sharedInstance] ranks] objectAtIndex:row];
    [info_reply setText:[NSString stringWithFormat:@"%d",rank.CCnt]];
    [info_like setText:[NSString stringWithFormat:@"%d",rank.VCnt]];
    [total setText:[NSString stringWithFormat:@"%d",rank.VCnt +rank.CCnt]];
    [rank_icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_no%d_topic.png",row+1]]];
    Member *member = [[MemberCache sharedInstance] getMemberWithBID:rank.BID];
    if (member) {
        [self memberDownloaded:member];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//Member数据下载成功
- (void)memberDownloaded:(Member *)member
{
    [portrait getImage:[[member babyInfo] PortraitUrl] defaultImage:@"pic_default_topic.png"];
    [info_name setText: [member babyInfo].Nickname];
    [info_name adjustSize];
    SetViewLeftUp(icon_sex, ViewWidth(info_name)+2, 0);
    [info_scroll setContentSize:CGSizeMake(ViewRightX(icon_sex), ViewHeight(info_scroll))];
    if (info_scroll.contentSize.width > ViewWidth(info_scroll)) {
        [self startAutoScroll];
    }
    if ([[member babyInfo] Gender])
    {
        [icon_sex setImage:[UIImage imageNamed:@"icon_male_topic.png"]];
    }else{
        [icon_sex setImage:[UIImage imageNamed:@"icon_female_topic.png"]];
    }
}

//Member数据下载失败
- (void)memberDownloadFailed
{
    
}

- (void)startAutoScroll
{
    if (timer) {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)autoScroll
{
    CGPoint offset = info_scroll.contentOffset;
    CGFloat w = ViewWidth(info_scroll);
    if (scrollDir) {
        offset.x += 0.5;
        if (offset.x + w >= info_scroll.contentSize.width) {
            scrollDir = NO;
            [timer invalidate];
            [self performSelector:@selector(startAutoScroll) withObject:nil afterDelay:3];
        }
    } else {
        offset.x -= 0.5;
        if (offset.x <= 0) {
            scrollDir = YES;
            offset.x = 0;
            [timer invalidate];
            [self performSelector:@selector(startAutoScroll) withObject:nil afterDelay:3];
        }
    }
    [info_scroll setContentOffset:offset];
}

- (void)dealloc
{
    [timer invalidate];
}

@end