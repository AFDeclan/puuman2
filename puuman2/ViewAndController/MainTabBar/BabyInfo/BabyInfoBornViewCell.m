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
        hidden = NO;
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
    
    heiAndWeiView = [[UIView alloc] init];
    [heiAndWeiView setBackgroundColor:[UIColor whiteColor]];
    [heiAndWeiView setAlpha:0.3];
    [heiAndWeiView.layer setMasksToBounds:YES];
    [heiAndWeiView.layer setCornerRadius:10];
    [clearInfoView addSubview:heiAndWeiView];
    
    vaciView =[[UIView alloc] init];
    [vaciView setBackgroundColor:[UIColor whiteColor]];
    [vaciView setAlpha:0.3];
    [vaciView.layer setMasksToBounds:YES];
    [vaciView.layer setCornerRadius:10];
    [clearInfoView addSubview:vaciView];
    
     propView = [[UIView alloc] init];
    [propView setBackgroundColor:[UIColor whiteColor]];
    [propView setAlpha:0.3];
    [propView.layer setMasksToBounds:YES];
    [propView.layer setCornerRadius:10];
    [clearInfoView addSubview:propView];
    
     bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomBtn setAlpha:0.5];
    [bottomBtn setImage:[UIImage imageNamed:@"back_up_babyInfo.png"] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(disAppearInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bottomBtn];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchPos = [[touches anyObject] locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [[touches anyObject] locationInView:self];
    if (pos.x - touchPos.x > 50 ||  touchPos.x - pos.x  > 50) {
        touchPos = pos;
        
    }else{
        if (pos.y - touchPos.y >200) {
            [self  disAppearInfoView];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [[touches anyObject] locationInView:self];
    if (pos.x - touchPos.x > 200 ||  touchPos.x - pos.x  > 200) {
        touchPos = pos;

    }else{
        if (touchPos.y - pos.y >200) {
            if (!hidden) {
                [self  disAppearInfoView];
                hidden = YES;

            }
        }
    }
    
}


- (void)initClearInfoView
{
    bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage imageNamed:@"baby_born_background.png"]];
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
    
    heiLineView = [[UIImageView alloc] init];
    [heiLineView setImage:[UIImage imageNamed:@"line_right_babyInfo.png"]];
    [clearInfoView addSubview:heiLineView];
    
     vaciLineView = [[UIImageView alloc] init];
    [vaciLineView setImage:[UIImage imageNamed:@"line_left_babyinfo.png"]];
    [clearInfoView addSubview:vaciLineView];
    
     propLineView = [[UIImageView alloc] init];
    [propLineView setImage:[UIImage imageNamed:@"line_left_babyinfo.png"]];
    [clearInfoView addSubview:propLineView];
    
     preView = [[UIImageView alloc] init];
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
//    [bgImageView setFrame:CGRectMake(134, 140, 500, 600)];
//    [heightBtn setFrame:CGRectMake(20, 300, 80, 68)];
//    [weightBtn setFrame:CGRectMake(20, 370, 80, 68)];
//    [vaciBtn setFrame:CGRectMake(540, 140, 192, 100)];
//    [propBtn setFrame:CGRectMake(600, 380, 192, 80)];
//    [addRecordBtn setFrame:CGRectMake(140, 300, 32, 32)];
//    [nextNaciView setFrame:CGRectMake(744,180, 10, 16)];
//    [nextPropView setFrame:CGRectMake(744,407, 10, 16)];
//    [preView setFrame:CGRectMake(5, 350, 10, 16)];
    [bgImageView setFrame:CGRectMake(72, 248, 500, 800)];
    [heightBtn setFrame:CGRectMake(24, 145, 170, 68)];
    [weightBtn setFrame:CGRectMake(24, 215, 170, 68)];
    [vaciBtn setFrame:CGRectMake(528, 184, 180, 100)];
    [propBtn setFrame:CGRectMake(528, 630, 180, 80)];
    [addRecordBtn setFrame:CGRectMake(230, 150, 32, 32)];
    [nextNaciView setFrame:CGRectMake(744, 224, 10, 16)];
    [nextPropView setFrame:CGRectMake(744, 660, 10, 16)];
    [preView setFrame:CGRectMake(5, 210, 10, 16)];
    [heiLineView setFrame:CGRectMake(24, 288, 240, 86)];
    [vaciLineView setFrame:CGRectMake(528, 289, 240, 86)];
    [propLineView setFrame:CGRectMake(528, 715, 240, 86)];
    
    [heiAndWeiView setFrame:CGRectMake(22, 140, 200, 140)];
    [vaciView setFrame:CGRectMake(523, 180, 212, 100)];
    [propView setFrame:CGRectMake(523, 625, 212, 80)];

}
- (void)setHorizontalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 1024, 672)];
    [clearInfoView setFrame:CGRectMake(0, 0, 1024, 672)];
    [bottomBtn setFrame:CGRectMake(0, 720, 1024, 48)];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 480, 8, 480)];
    [bgImageView setFrame:CGRectMake(270,75, 500, 800)];
    [heightBtn setFrame:CGRectMake(30, 260, 170, 68)];
    [weightBtn setFrame:CGRectMake(30, 330, 170, 68)];
    [vaciBtn setFrame:CGRectMake(780, 135, 212, 100)];
    [propBtn setFrame:CGRectMake(780, 375, 212, 80)];
    [addRecordBtn setFrame:CGRectMake(230, 262, 32, 32)];
    [nextNaciView setFrame:CGRectMake(1000,180, 10, 16)];
    [nextPropView setFrame:CGRectMake(1000,407, 10, 16)];
    [preView setFrame:CGRectMake(10, 320, 10, 16)];
    [heiLineView setFrame:CGRectMake(30, 403, 240, 86)];
    [vaciLineView setFrame:CGRectMake(775, 240, 240, 86)];
    [propLineView setFrame:CGRectMake(775, 460, 240, 86)];
    [heiAndWeiView setFrame:CGRectMake(25, 255, 200, 138)];
    [vaciView setFrame:CGRectMake(775, 130, 212, 100)];
    [propView setFrame:CGRectMake(775, 370, 212, 80)];

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
    PostNotification(Noti_HiddenBabyView, nil);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
