//
//  PartnerDataInGroupView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiguresHeaderView.h"
#import "DataInfoScrollView.h"
#import "AFColorButton.h"
#import "Group.h"

@interface PartnerDataInGroupView : UIView
{
    FiguresHeaderView *figuresHeader;
    DataInfoScrollView *dataInfoView;
    AFColorButton *manageBtn;
    BOOL manage;
    Group *group;
}


- (void)loadViewInfo;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
