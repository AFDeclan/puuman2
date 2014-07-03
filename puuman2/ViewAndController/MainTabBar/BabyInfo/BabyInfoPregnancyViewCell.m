//
//  BabyInfoPregnancyViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoPregnancyViewCell.h"
#import "ColorsAndFonts.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "BabyInfoChooseButton.h"
#import "CAKeyframeAnimation+DragAnimation.h"

@implementation BabyInfoPregnancyViewCell
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
        [self initClearInfoView];
    }
    return self;
}

- (void)initialization
{
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,1024,96)];
    [iconView setBackgroundColor:PMColor5];
    [self.contentView addSubview:iconView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 96, 1024, 672)];
    [contentView setBackgroundColor:RGBColor(239, 215, 207)];
    [self.contentView addSubview:contentView];
    
    clearInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 672)];
    [clearInfoView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:clearInfoView];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setFrame:CGRectMake(0, 720, 1024, 48)];
    [bottomBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomBtn setAlpha:0.5];
    [bottomBtn setImage:[UIImage imageNamed:@"back_up_babyInfo.png"] forState:UIControlStateNormal];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 480, 8, 480)];
    [bottomBtn addTarget:self action:@selector(disAppearInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bottomBtn];
    
    modifyBtn = [[ColorButton alloc] initWithFrame:CGRectMake(916, 28, 108, 40)];
    [modifyBtn initWithTitle:@"修改" andIcon:[UIImage imageNamed:@"icon_fix_baby.png"] andButtonType:kGrayLeft];
    [modifyBtn addTarget:self action:@selector(changeBabyInfo) forControlEvents:UIControlEventTouchUpInside];
    [iconView addSubview:modifyBtn];
    
    UIImageView *portraitBg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 180, 180)];
    [portraitBg setImage:[UIImage imageNamed:@"circle_photo_babyInfo.png"]];
    [self.contentView addSubview:portraitBg];
    
    portraitView = [[AFImageView alloc] initWithFrame:CGRectMake(24, 24, 150, 150)];
    portraitView .layer.cornerRadius = 75;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius = 0.1;
    portraitView.contentMode = UIViewContentModeScaleAspectFill;
    [portraitBg addSubview:portraitView];
    
    info_sexIcon = [[UIImageView alloc] initWithFrame:CGRectMake(227, 60, 22, 22)];
    [info_sexIcon setBackgroundColor:[UIColor clearColor]];
    [iconView addSubview:info_sexIcon];
    
    info_name = [[UILabel alloc] initWithFrame:CGRectMake(256, 58, 65, 25)];
    [info_name setTextAlignment:NSTextAlignmentLeft];
    [info_name setTextColor:PMColor6];
    [info_name setFont:PMFont1];
    [info_name setText:@"扑满"];
    [info_name setBackgroundColor:[UIColor clearColor]];
    [iconView addSubview:info_name];
    
    info_age= [[UILabel alloc] initWithFrame:CGRectMake(325, 60, 110, 21)];
    [info_age setTextAlignment:NSTextAlignmentLeft];
    [info_age setTextColor:PMColor1];
    [info_age setFont:PMFont2];
    [info_age setText:@"孕期18周"];
    [info_age setBackgroundColor:[UIColor clearColor]];
    [iconView addSubview:info_age];
    
    
}

- (void)initClearInfoView
{
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(265,60, 480, 540)];
    [bgImageView setImage:[UIImage imageNamed:@"bg_pregnancy_image_babyInfo.png"]];
    [clearInfoView addSubview:bgImageView];
    
    BabyInfoChooseButton *BModelBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(24, 118, 160, 24)];
    [BModelBtn setType:kBabyInfoBModle];
    [BModelBtn addTarget:self action:@selector(bModelBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:BModelBtn];
    
    BabyInfoChooseButton *modelBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(780, 84, 220, 85)];
    [modelBtn setType:kBabyInfoModle];
    [modelBtn addTarget:self action:@selector(modelBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:modelBtn];
    
    UIImageView *grayLineRight = [[UIImageView alloc] initWithFrame:CGRectMake(24, 160, 240, 86)];
    [grayLineRight  setImage:[UIImage imageNamed:@"grayline_right_babyInfo.png"]];
    [clearInfoView addSubview:grayLineRight];
    
    UIImageView *grayLineLeft = [[UIImageView alloc] initWithFrame:CGRectMake(780, 158, 240, 86)];
    [grayLineLeft setImage:[UIImage imageNamed:@"grayline_left_babyInfo.png"]];
    [clearInfoView addSubview:grayLineLeft];
    
    UIImageView *nextPropView = [[UIImageView alloc] initWithFrame:CGRectMake(1000,110, 10, 18)];
    [nextPropView setImage:[UIImage imageNamed:@"gray_back_right_babyInfo"]];
    [clearInfoView addSubview:nextPropView];
    
    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [preBtn setFrame:CGRectMake(180, 310, 23, 42)];
    [preBtn setImage:[UIImage imageNamed:@"pre_pic_btn.png"] forState:UIControlStateNormal];
    [preBtn addTarget:self action:@selector(preBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:preBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(790, 310, 23, 42)];
    [nextBtn setImage:[UIImage imageNamed:@"next_pic_btn.png"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:nextBtn];
    
    
    UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(300, 516, 62, 36)];
    [weekView setBackgroundColor:[UIColor redColor]];
    [weekView setAlpha:0.1];
    [weekView.layer setMasksToBounds:YES];
    [weekView.layer setCornerRadius:18.0];
    [clearInfoView addSubview:weekView];
    weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 516, 62, 36)];
    [weekLabel setFont:PMFont(24)];
    [weekLabel setText:@"18周"];
    [weekLabel setTextColor:[UIColor whiteColor]];
    [clearInfoView addSubview:weekLabel];
    
}

- (void)disAppearInfoView
{
    
    [CAKeyframeAnimation dragAnimationWithView:self.contentView andDargPoint:CGPointMake(0, -1024)];
    SetViewLeftUp(self.contentView, 0, -768);
    
}

- (void)bModelBtn
{
    
    
}

- (void)modelBtn
{
    
    [_delegate gotoTheNextPropView];
    
}

- (void)preBtnClick
{
    
    
    
}

- (void)nextBtnClick
{
    
    
    
}

- (void)changeBabyInfo
{
    LoginViewController *modifyInfoVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:modifyInfoVC.view];
    [modifyInfoVC setControlBtnType:kCloseAndFinishButton];
    [modifyInfoVC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [modifyInfoVC loginSetting];
    [modifyInfoVC show];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
