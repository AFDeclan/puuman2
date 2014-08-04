//
//  PartnerInGroupDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "FiguresHeaderView.h"
#import "DataInfoScrollView.h"
#import "Group.h"

@interface PartnerInGroupDataView : UIView
{
    FiguresHeaderView *figuresHeader;
    DataInfoScrollView *dataInfoView;
    UIButton *manageBtn;
    BOOL selected;
    Group *group;
}

- (void)loadViewInfo;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
