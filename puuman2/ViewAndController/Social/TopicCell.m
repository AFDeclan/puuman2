//
//  TopicCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicCell.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"

@implementation TopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 668, 112)];
        [self.contentView addSubview:headerView];
        contentView = [[UIView alloc] init];
        [self.contentView addSubview:contentView];
        footerView = [[UIView alloc] init];
        [self.contentView addSubview:footerView];
        [self initWithHeaderView];
    }
    return self;
}

- (void)initWithHeaderView
{
    
    infoView = [[BasicInfoView alloc] init];
    [self.contentView addSubview:infoView];
    [infoView setInfoWithName:@"宝宝" andPortrailPath:[[UserInfo sharedUserInfo] portraitUrl] andRelate:@"哥哥" andIsBoy:YES];
   
    UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 134, 216, 2)];
    [partLine setImage:[UIImage imageNamed:@"line_topic.png"]];
    [partLine setAlpha:0.5];
    [self.contentView addSubview:partLine];

    info_time = [[UILabel alloc] initWithFrame:CGRectMake(464, 16, 128, 12)];
    [info_time setTextAlignment:NSTextAlignmentRight];
    [info_time setTextColor:PMColor3];
    [info_time setFont:PMFont3];
    [info_time setText:@"2012.12.12"];
    [info_time setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:info_time];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
