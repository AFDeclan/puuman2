//
//  BabyInfoPregnancyViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "AFImageView.h"
#import "UIColumnView.h"
#import "BabyInfoIconViewDelegate.h"
#import "BabyInfoChooseButton.h"
#import "BabyView.h"

@interface BabyInfoPregnancyViewCell : UITableViewCell<BabyInfoIconViewDelegate,UIColumnViewDataSource,UIColumnViewDelegate,BabyViewDelegate>
{
    UIView *clearInfoView;
    ColorButton *modifyBtn;
    AFImageView *portraitView;
    UIImageView *info_sexIcon;
    UILabel *info_name;
    UILabel *info_age;
    UILabel *weekLabel;
    UIButton *preBtn;
    UIButton *nextBtn;
    UIColumnView *_columnView;
    NSInteger columnIndex;
    UIButton *questionBtn;
    BOOL scrolling;
    BabyInfoChooseButton *changeModelBtn;
    UIView *contentView;
    UIButton *bottomBtn;
    BabyInfoChooseButton *propBtn;
    UIView *weekView;
    UIView *picView;
    
}

@property (nonatomic,assign)id<BabyInfoIconViewDelegate>delegate;
@property (nonatomic,assign)id <BabyViewDelegate>PreDelegate;

@property (nonatomic,assign) BOOL columnImgBMode;
- (void)refreshBabyInfo;

@end
