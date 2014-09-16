//
//  ToolsView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolsInfoView.h"
#import "ToolsUnitView.h"

@interface ToolsView : UIView<ToolsUnitViewDelegate>
{
    UIView *contentView;
    ToolsInfoView *toolsInfo;
    ToolsUnitView *unitViews[3];
    NSInteger selectedIndex;
    BOOL animated;

}
- (void)showAnimate;
- (void)reloadView;
- (void)addPie;
- (void)changedPie;


@end
