//
//  RankTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RankTableViewCell.h"
#import "UserInfo.h"

@implementation RankTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        rank_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 40, 40)];
        [self.contentView addSubview:rank_icon];
        
        portrait=[[AFImageView alloc] initWithFrame:CGRectMake(48, 12, 40, 40)];
        [portrait setBackgroundColor:[UIColor blackColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        [self.contentView addSubview:portrait];
        info_name = [[UILabel alloc] init];
        [info_name setTextAlignment:NSTextAlignmentCenter];
        [info_name setTextColor:PMColor2];
        [info_name setFont:PMFont2];
        [info_name setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:info_name];
        
        icon_sex = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        [self.contentView addSubview:icon_sex];
        icon_reply = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        [icon_reply setImage:[UIImage imageNamed:@"btn_reply2_topic.png"]];
        [self.contentView addSubview:icon_reply];
        icon_like = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        [icon_like setImage:[UIImage imageNamed:@"btn_like3_topic.png"]];
        [self.contentView addSubview:icon_like];
        info_reply = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 0)];
        [info_reply setTextAlignment:NSTextAlignmentCenter];
        [info_reply setTextColor:PMColor2];
        [info_reply setFont:PMFont2];
        [info_reply setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:info_reply];
        info_like = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 0)];
        [info_like setTextAlignment:NSTextAlignmentCenter];
        [info_like setTextColor:PMColor2];
        [info_like setFont:PMFont2];
        [info_like setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:info_like];
        UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 78, 192, 2)];
        [partLine setImage:[UIImage imageNamed:@"line_topic.png"]];
        [self.contentView addSubview:partLine];
    }
    return self;
}


- (void)buildWithRankInfo:(Rank *)rank
{
  //  [portrait getImage:[rank rw] defaultImage:@""];
    
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
