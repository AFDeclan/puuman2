//
//  ShopContentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllWareView.h"
#import "RectWareView.h"
#import "ShopMenuView.h"
#import "BabyInfoPageControlButton.h"

@interface ShopContentView : UIScrollView<UIGestureRecognizerDelegate>
{
    RectWareView *rectView;
    AllWareView *allView;
    UIView *menuMask;
    ShopMenuView *menu;
    BabyInfoPageControlButton *showAndHiddenBtn;
     NSTimer *_timerToFoldDrawer;
    BOOL menuShowed;
}
- (void)hiddenMenuWithTapPoint:(CGPoint)pos;
- (void)showAllShop;
- (void)showRectShop;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
