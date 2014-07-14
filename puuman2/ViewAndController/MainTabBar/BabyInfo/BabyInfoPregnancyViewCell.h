//
//  BabyInfoPregnancyViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"
#import "AFImageView.h"
#import "UIColumnView.h"
#import "BabyInfoIconViewDelegate.h"
#import "BabyInfoChooseButton.h"
#import "BabyView.h"

@interface BabyInfoPregnancyViewCell : UITableViewCell<BabyInfoIconViewDelegate,UIColumnViewDataSource,UIColumnViewDelegate>
{
    UIView *clearInfoView;
    UILabel *weekLabel;
    UIButton *preBtn;
    UIButton *nextBtn;
    UIColumnView *_columnView;
    UIView *babyShowView;
    NSInteger columnIndex;
    BOOL scrolling;
    BabyInfoChooseButton *changeModelBtn;
    UIView *contentView;
    UIButton *bottomBtn;
    BabyInfoChooseButton *propBtn;
    UIView *weekView;
    UIView *picView;
    UIImageView *grayLineRight;
    UIImageView *grayLineLeft;
    UIImageView *nextPropView;
    UIView *tapView;
}

@property (nonatomic,assign)id<BabyInfoIconViewDelegate>delegate;

@property (nonatomic,assign) BOOL columnImgBMode;
- (void)refreshBabyInfo;

@end
