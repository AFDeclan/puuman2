//
//  BabyView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyView.h"
#import "UIColumnView.h"
#import "AFColorButton.h"
#import "AFImageView.h"
#import "BabyInfoIconViewDelegate.h"
#import "BabyShowButton.h"
#import "PuumanShowView.h"



@interface BabyView : UIView <UIColumnViewDataSource,UIColumnViewDelegate,BabyInfoIconViewDelegate>
{
    UIView *titleInfoView;
    UIImageView *portraitBg;
    UIColumnView *babyInfoColumnView;
    AFColorButton *modifyBtn;
    AFImageView *portraitView;
    UIImageView *info_sexIcon;
    UILabel *info_name;
    UILabel *info_age;
    UILabel *info_birthday;
    BOOL prop;
    NSInteger currentNum;
    PuumanShowView *puumanView;
    BabyShowButton *babyShowBtn;

}

- (void)setHorizontalFrame;
- (void)setVerticalFrame;
- (void)loadDataInfo;
@end
