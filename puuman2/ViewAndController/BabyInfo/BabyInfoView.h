//
//  BabyInfoView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "NewTextPhotoSelectedViewController.h"
#import "UserInfo.h"
@interface BabyInfoView : UIView<BabyInfoDelegate>
{
    UILabel  *info_name;
    UILabel  *info_age;
    UILabel  *info_birthday;
    UILabel  *info_usedays;
    UILabel  *info_diaryNum;
    UIImageView *sexIcon;
    AFImageView *portraitView;
    UIButton *selectPhoto;
   
}

- (void)resetBabyInfo;
@end
