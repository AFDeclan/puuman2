//
//  BabyInfoViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyInfoView.h"
#import "ColorButton.h"
#import "BabyInfoButton.h"
#import "BabyBodyView.h"
#import "BabyVaccineView.h"
#import "BabyPuumanView.h"
#import "BabyPropView.h"
#import "BabyPreView.h"


@interface BabyInfoViewController : UIViewController
{

    UIImageView *bgImageView;
    BabyInfoView *babyInfoView;
    ColorButton *modifyBtn;
    UIView *controlBtnsView;
    BabyInfoButton *acticeBtn;
    BabyBodyView *bodyView;
    BabyVaccineView *vaccineView;
    BabyPuumanView *puumanView;
    BabyPropView *propView;
    BabyPreView *preView;
    BabyInfoButtonType selectType;
}


- (void)refresh;
@end
