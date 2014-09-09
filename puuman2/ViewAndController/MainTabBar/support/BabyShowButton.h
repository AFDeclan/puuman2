//
//  BabyShowView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "CoinButtonAnimation.h"
typedef enum
{
    PuumanAnimateAdd,
    PuumanAnimateMinus,
    PuumanAnimateShow,
    PuumanAnimateNone
}PuumanAnimateStatus;
@interface BabyShowButton : UIView<CoinButtonAnimationDelagate>
{
    UIImageView *bg_babybutton;
    AFImageView *portraitView;
    CoinButtonAnimation *animataView;
    PuumanAnimateStatus status;
    UILabel *coin_num;
    UILabel *coin_label;
    UIButton *babyInfoBtn;
    UIImageView *profileView;

}

- (void)loadData;
@end