//
//  BabyInfoBornViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoBornViewCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "Device.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "CustomNotiViewController.h"
#import "UserInfo.h"
#import "BabyData.h"
#import "AddBodyDataViewController.h"
#import "CAKeyframeAnimation+DragAnimation.h"


@implementation BabyInfoBornViewCell
@synthesize delegate= _delegate;

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
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 96, 1024, 672)];
    [contentView setBackgroundColor:RGBColor(7, 117, 202)];
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
    [MyNotiCenter addObserver:self selector:@selector(refresh) name:Noti_BabyDataUpdated object:nil];
  
}


- (void)refresh
{
    [weightBtn setType:kBabyInfoWeight];
    [heightBtn setType:kBabyInfoHeight];
    [vaciBtn setType:kBabyInfoVaci];
    [propBtn setType:kBabyInfoProp];

}

- (void)initClearInfoView
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270,75, 500, 600)];
    [bgImageView setImage:[UIImage imageNamed:@"bg_sleeping_babyInfo.png"]];
    [clearInfoView addSubview:bgImageView];
    
    UIButton *addRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addRecordBtn setFrame:CGRectMake(230, 262, 32, 32)];
    [addRecordBtn setImage:[UIImage imageNamed:@"add_record_babyInfo.png"] forState:UIControlStateNormal];
    [addRecordBtn addTarget:self action:@selector(addRecord) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:addRecordBtn];
    
    heightBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(30, 262, 170, 68)];
    [heightBtn addTarget:self action:@selector(heiBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:heightBtn];
    
    weightBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(30, 332, 170, 68)];
    [weightBtn addTarget:self action:@selector(weiBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:weightBtn];
    
    vaciBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(780, 140, 212, 100)];
    [vaciBtn addTarget:self action:@selector(vaciBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:vaciBtn];
    
    propBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(780, 380, 212, 80)];
    [propBtn addTarget:self action:@selector(propBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:propBtn];
    
    UIImageView *heiLineView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 400, 240, 86)];
    [heiLineView setImage:[UIImage imageNamed:@"line_right_babyInfo.png"]];
    [clearInfoView addSubview:heiLineView];
    
    UIImageView *vaciLineView = [[UIImageView alloc] initWithFrame:CGRectMake(780, 230, 240, 86)];
    [vaciLineView setImage:[UIImage imageNamed:@"line_left_babyinfo.png"]];
    [clearInfoView addSubview:vaciLineView];
    
    UIImageView *propLineView = [[UIImageView alloc] initWithFrame:CGRectMake(780, 456, 240, 86)];
    [propLineView setImage:[UIImage imageNamed:@"line_left_babyinfo.png"]];
    [clearInfoView addSubview:propLineView];
    
    UIImageView *preView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 320, 10, 16)];
    [preView setImage:[UIImage imageNamed:@"back_left_babyInfo.png"]];
    [clearInfoView addSubview:preView];
    
    UIImageView *nextNaciView = [[UIImageView alloc] initWithFrame:CGRectMake(1000,180, 10, 16)];
    [nextNaciView setImage:[UIImage imageNamed:@"back_right_babyInfo.png"]];
    [clearInfoView addSubview:nextNaciView];
    
    UIImageView *nextPropView = [[UIImageView alloc] initWithFrame:CGRectMake(1000,407, 10, 16)];
    [nextPropView setImage:[UIImage imageNamed:@"back_right_babyInfo"]];
    [clearInfoView addSubview:nextPropView];


}
- (void)heiBtn
{
    [_delegate gotoPreCell];
    
}

- (void)weiBtn
{
    [_delegate gotoPreCell];

}

- (void)vaciBtn
{
    [_delegate gotoNextCellWithProp:NO];
    
}

- (void)propBtn
{
    
    [_delegate gotoNextCellWithProp:YES];
    
}

- (void)addRecord
{
    
    AddBodyDataViewController *addVC = [[AddBodyDataViewController alloc] initWithNibName:nil bundle:nil];
    [addVC setControlBtnType:kCloseAndFinishButton];
    [addVC setTitle:@"添加记录" withIcon:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:addVC.view];
    [addVC show];
    
    
    
}

- (void)disAppearInfoView
{
    [[MainTabBarController sharedMainViewController] hiddenBabyView];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setHorizontalFrame
{
  
}

- (void)showLoginView
{
}

@end
