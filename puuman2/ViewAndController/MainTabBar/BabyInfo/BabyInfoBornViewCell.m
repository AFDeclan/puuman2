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
        if ([[MainTabBarController sharedMainViewController] isVertical]) {
            
            [self setVerticalFrame];
        } else {
            
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)refresh
{

}

- (void)initialization
{
    
    
     contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:RGBColor(7, 117, 202)];
    [self.contentView addSubview:contentView];
    
    clearInfoView = [[UIView alloc] init];
    [clearInfoView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:clearInfoView];
    
     bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomBtn setAlpha:0.5];
    [bottomBtn setImage:[UIImage imageNamed:@"back_up_babyInfo.png"] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(disAppearInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bottomBtn];
    
    

}

- (void)initClearInfoView
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270,75, 500, 600)];
    [bgImageView setImage:[UIImage imageNamed:@"bg_sleeping_babyInfo.png"]];
    [clearInfoView addSubview:bgImageView];
    
     addRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addRecordBtn setImage:[UIImage imageNamed:@"add_record_babyInfo.png"] forState:UIControlStateNormal];
    [addRecordBtn addTarget:self action:@selector(addRecord) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:addRecordBtn];
    
    heightBtn = [[BabyInfoChooseButton alloc] init];
    [heightBtn setType:kBabyInfoHeight];
    [heightBtn addTarget:self action:@selector(heiBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:heightBtn];
    
    weightBtn = [[BabyInfoChooseButton alloc] init];
    [weightBtn setType:kBabyInfoWeight];
    [weightBtn addTarget:self action:@selector(weiBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:weightBtn];
    
    vaciBtn = [[BabyInfoChooseButton alloc] init];
    [vaciBtn setType:kBabyInfoVaci];
    [vaciBtn addTarget:self action:@selector(vaciBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:vaciBtn];
    
    propBtn = [[BabyInfoChooseButton alloc] init];
    [propBtn setType:kBabyInfoProp];
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
    
     preView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 320, 10, 16)];
    [preView setImage:[UIImage imageNamed:@"back_left_babyInfo.png"]];
    [clearInfoView addSubview:preView];
    
    nextNaciView = [[UIImageView alloc] init];
    [nextNaciView setImage:[UIImage imageNamed:@"back_right_babyInfo.png"]];
    [clearInfoView addSubview:nextNaciView];
    
    nextPropView = [[UIImageView alloc] init];
    [nextPropView setImage:[UIImage imageNamed:@"back_right_babyInfo"]];
    [clearInfoView addSubview:nextPropView];


}

- (void)setVerticalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 768, 928)];
    [clearInfoView setFrame:CGRectMake(0, 0, 768, 928)];
    [bottomBtn setFrame:CGRectMake(0, 976, 768, 48)];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 352, 8, 352)];
    [heightBtn setFrame:CGRectMake(20, 262, 80, 68)];
    [weightBtn setFrame:CGRectMake(20, 332, 80, 68)];
    [vaciBtn setFrame:CGRectMake(640, 140, 100, 100)];
    [propBtn setFrame:CGRectMake(640, 380, 212, 80)];
    [addRecordBtn setFrame:CGRectMake(100, 262, 32, 32)];
    [nextNaciView setFrame:CGRectMake(744,180, 10, 16)];
    [nextPropView setFrame:CGRectMake(744,407, 10, 16)];


}
- (void)setHorizontalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 1024, 672)];
    [clearInfoView setFrame:CGRectMake(0, 0, 1024, 672)];
    [bottomBtn setFrame:CGRectMake(0, 720, 1024, 48)];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 480, 8, 480)];
    [heightBtn setFrame:CGRectMake(30, 262, 170, 68)];
    [weightBtn setFrame:CGRectMake(30, 332, 170, 68)];
    [vaciBtn setFrame:CGRectMake(780, 140, 212, 100)];
    [propBtn setFrame:CGRectMake(780, 380, 212, 80)];
    [addRecordBtn setFrame:CGRectMake(230, 262, 32, 32)];
    [nextNaciView setFrame:CGRectMake(1000,180, 10, 16)];
    [nextPropView setFrame:CGRectMake(1000,407, 10, 16)];


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

@end
