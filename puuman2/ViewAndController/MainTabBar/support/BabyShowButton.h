//
//  BabyShowView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "PuumanButtonAnimateView.h"
typedef enum
{
    PuumanAnimateAdd,
    PuumanAnimateMinus,
    PuumanAnimateShow,
    PuumanAnimateNone
}PuumanAnimateStatus;
@interface BabyShowButton : UIView<PuumanAnimateDelegate>
{
    UIImageView *bg_babybutton;
    AFImageView *portraitView;
    PuumanButtonAnimateView *animateView;
    PuumanAnimateStatus status;
    UILabel *showLabel;
    UILabel *coin_num;
    UILabel *coin_label;
    UIButton *babyInfoBtn;

}

- (void)addPuuman;
- (void)minusPuuman;
- (void)loadData;
@end