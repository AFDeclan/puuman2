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
    BabyInfoChooseButton *weightBtn;
    BabyInfoChooseButton *vaciBtn;
    BabyInfoChooseButton *propBtn;
    BabyInfoChooseButton *heightBtn;
}

@property (nonatomic,assign) id <BabyInfoIconViewDelegate>delegate;

- (void)refresh;

@end
