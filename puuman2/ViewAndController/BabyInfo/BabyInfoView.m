//
//  BabyInfoView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoView.h"

#import "BabyData.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"
#import "MainTabBarController.h"
#import "TaskCell.h"

@implementation BabyInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [UserInfo sharedUserInfo].portraitUploadDelegate = self;
    }
    return self;
}

- (void)initialization
{
    UIImageView *portraitBg = [[UIImageView alloc] initWithFrame:CGRectMake(180, 0, 160, 160)];
    [portraitBg setImage:[UIImage imageNamed:@"circle_photo_baby.png"]];
    [self addSubview:portraitBg];
    portraitView = [[AFImageView alloc] initWithFrame:CGRectMake(24, 24, 112, 112)];
    portraitView.layer.cornerRadius = 56;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius =0.1;
    [portraitBg addSubview:portraitView];
    selectPhoto = [[UIButton alloc] initWithFrame:CGRectMake(204, 24, 112, 112)];
    [selectPhoto setBackgroundColor:[UIColor clearColor]];
    [selectPhoto addTarget:self action:@selector(selectedPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectPhoto];
    

    
    sexIcon = [[UIImageView alloc] initWithFrame:CGRectMake(156, 40, 24, 24)];
    [sexIcon setBackgroundColor:[UIColor clearColor]];
    [self addSubview:sexIcon];
    
    info_name = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 180, 24)];
    [info_name setTextAlignment:NSTextAlignmentRight];
    [info_name setTextColor:PMColor6];
    [info_name setFont:PMFont1];
    [info_name setBackgroundColor:[UIColor clearColor]];
    [self addSubview:info_name];
    
    info_age = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 180, 16)];
    [info_age setTextAlignment:NSTextAlignmentRight];
    [info_age setTextColor:PMColor1];
    [info_age setFont:PMFont3];
    [info_age setBackgroundColor:[UIColor clearColor]];
    [self addSubview:info_age];
    
    info_birthday = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 180, 16)];
    [info_birthday setTextAlignment:NSTextAlignmentRight];
    [info_birthday setTextColor:PMColor1];
    [info_birthday setFont:PMFont3];
    [info_birthday setBackgroundColor:[UIColor clearColor]];
    [self addSubview:info_birthday];
    
    info_usedays = [[UILabel alloc] initWithFrame:CGRectMake(340, 80, 180, 16)];
    [info_usedays setTextAlignment:NSTextAlignmentLeft];
    [info_usedays setTextColor:PMColor2];
    [info_usedays setFont:PMFont3];
    [info_usedays setBackgroundColor:[UIColor clearColor]];
    [self addSubview:info_usedays];
    
    info_diaryNum = [[UILabel alloc] initWithFrame:CGRectMake(340, 112, 180, 16)];
    [info_diaryNum setTextAlignment:NSTextAlignmentLeft];
    [info_diaryNum setTextColor:PMColor2];
    [info_diaryNum setFont:PMFont3];
    [info_diaryNum setBackgroundColor:[UIColor clearColor]];
    [self addSubview:info_diaryNum];
    
}

- (void)selectedPhoto
{
    NewTextPhotoSelectedViewController *chooseView = [[NewTextPhotoSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:chooseView.view];
    [chooseView setDelegate:self];
    [chooseView setStyle:ConfirmError];
    [chooseView show];
    
}

- (void)selectedPhoto:(UIImage *)img
{
    [[UserInfo sharedUserInfo] uploadPortrait:img];
    
}

- (void)resetBabyInfo
{
    BabyData *babyData = [BabyData sharedBabyData];
    [portraitView getImage:[[UserInfo sharedUserInfo] portraitUrl] defaultImage:default_portrait_image];
    info_name.text = [babyData babyName];
    info_age.text = [[NSDate date] ageStrFromDate:[babyData babyBirth]];
    if ([[BabyData sharedBabyData] babyHasBorned])
    {[info_name setFrame:CGRectMake(0, 40, 152, 24)];
        if ([babyData babyIsBoy]) {
            [sexIcon setImage:[UIImage imageNamed:@"icon_male_baby.png"]];
        }else
        {
            [sexIcon setImage:[UIImage imageNamed:@"icon_female_baby.png"]];
        }

        
    }else{
        [sexIcon setImage:nil];
        [info_name setFrame:CGRectMake(0, 40, 180, 24)];
    }
    NSString *birthStr = [DateFormatter stringFromDate:[babyData babyBirth]];
    NSString *constellationStr = [[babyData babyBirth] constellation];
    info_birthday.text = [NSString stringWithFormat:@"%@ %@", birthStr, constellationStr];
    info_usedays.text = [NSString stringWithFormat:@"%d的使用",10];
    info_diaryNum.text = [NSString stringWithFormat:@"%d条日记",15];
}

- (void)portraitUploadFinish:(BOOL)suc
{
    if (suc) {
        [[TaskCell sharedTaskCell] reloadPortrait];
         [portraitView getImage:[[UserInfo sharedUserInfo] portraitUrl] defaultImage:default_portrait_image];
    }
    
}


@end
