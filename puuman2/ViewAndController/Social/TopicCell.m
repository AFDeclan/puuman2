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
#import "AllWordsPopViewController.h"
#import "MainTabBarController.h"

@implementation TopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 112)];
        [self.contentView addSubview:headerView];
        contentView = [[UIView alloc] init];
        [self.contentView addSubview:contentView];
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 216, 608, 88)];
        [self.contentView addSubview:footerView];
        [self initWithHeaderView];
        [headerView setBackgroundColor:PMColor5];
        [contentView setBackgroundColor:PMColor5];
        [footerView setBackgroundColor:PMColor5];
    }
    return self;
}

- (void)initWithHeaderView
{
    UIImageView *partLine_first  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 2)];
    [partLine_first setImage:[UIImage imageNamed:@"line4_baby.png"]];
    [footerView addSubview:partLine_first];
    UIImageView *partLine_second  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 216, 2)];
    [partLine_second setImage:[UIImage imageNamed:@"line4_baby.png"]];
    [footerView addSubview:partLine_second];
    infoView = [[BasicInfoView alloc] init];
    [self.contentView addSubview:infoView];
    [infoView setInfoWithName:@"宝宝" andPortrailPath:[[UserInfo sharedUserInfo] portraitUrl] andRelate:@"哥哥" andIsBoy:YES];


    info_time = [[UILabel alloc] initWithFrame:CGRectMake(464, 16, 128, 12)];
    [info_time setTextAlignment:NSTextAlignmentRight];
    [info_time setTextColor:PMColor3];
    [info_time setFont:PMFont3];
    [info_time setText:@"2012.12.12"];
    [info_time setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:info_time];
    
    
    replayBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 304, 40)];
    [replayBtn addTarget:self action:@selector(replayBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [replayBtn setTitle:@"333" andImg:[UIImage imageNamed:@"btn_reply1z_topic.png"] andButtonType:kButtonTypeTwo];
    [replayBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    
    
    likeBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 40)];
    [likeBtn addTarget:self action:@selector(likeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [likeBtn setSelectedImg:[UIImage imageNamed:@"btn_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"btn_like2_topic.png"] andTitle:@"111" andButtonType:kButtonTypeTwo andSelectedType:kNoneClear];
    [likeBtn setIconFrame:CGRectMake(0, 0, 20, 20)];
    [likeBtn unSelected];
    
    [footerView addSubview:replayBtn];
    [footerView addSubview:likeBtn];
    
    relayExample = [[UILabel alloc] initWithFrame:CGRectMake(16, 40, 496, 48)];
    [relayExample setText:@"妞妞：好可爱啊！"];
    [relayExample setFont:PMFont3];
    [relayExample setTextColor:PMColor2];
    [relayExample setBackgroundColor:[UIColor clearColor]];
    [footerView addSubview:relayExample];
    
    scanMoreReplay = [[AFTextImgButton alloc] initWithFrame:CGRectMake(496, 40, 112, 48)];
    [scanMoreReplay setTitle:@"查看更多留言" andImg:nil andButtonType:kButtonTypeOne];
    [scanMoreReplay setTitleLabelColor:PMColor3];
    [scanMoreReplay addTarget:self action:@selector(scanMore) forControlEvents:UIControlEventTouchUpInside];
    [scanMoreReplay setTitleFont:PMFont3];
    [footerView addSubview:scanMoreReplay];

    
}

- (void)replayBtnPressed
{

}

- (void)likeBtnPressed
{
    [likeBtn selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)scanMore
{
    AllWordsPopViewController *moreReplayVC  =[[ AllWordsPopViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:moreReplayVC.view];
    [moreReplayVC setControlBtnType:kOnlyCloseButton];
    [moreReplayVC setTitle:@"所有留言"];
    [moreReplayVC show];
}

+ (CGFloat)heightForReplay:(Reply *)replay
{
    return  312;
}

@end
