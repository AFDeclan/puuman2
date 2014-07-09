//
//  BabyInfoBornViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "AFImageView.h"
#import "UserInfo.h"
#import "BabyInfoIconViewDelegate.h"
#import "BabyView.h"
#import "BabyInfoChooseButton.h"

@interface BabyInfoBornViewCell : UITableViewCell<BabyInfoDelegate,BabyInfoIconViewDelegate>

{
    UIView *clearInfoView;
    UIView *contentView;
    UIButton *bottomBtn;
    BabyInfoChooseButton *heightBtn;
    BabyInfoChooseButton *weightBtn;
    BabyInfoChooseButton *vaciBtn;
    BabyInfoChooseButton *propBtn;
    UIButton *addRecordBtn;
    UIImageView *preView;
    UIImageView *nextNaciView;
    UIImageView *nextPropView;
    UIImageView *heiLineView;
    UIImageView *vaciLineView;
    UIImageView *propLineView;
    UIImageView *bgImageView;
    
}

@property (nonatomic,assign) id <BabyInfoIconViewDelegate>delegate;

- (void)refresh;

@end
