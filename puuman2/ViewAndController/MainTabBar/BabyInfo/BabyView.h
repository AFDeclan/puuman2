//
//  BabyView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyView.h"
#import "BabyInfoBornView.h"
#import "BabyInfoPregnancyView.h"

@interface BabyView : UIView
{
    UIView *babyInfoView;
    
}

- (void)loadDataInfo;
@end
