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
    Group *group;
    UIView *blockView;
    BOOL managing;
}

- (void)loadViewInfo;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
