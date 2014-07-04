//
//  ShopContentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopMenuView.h"
#import "BabyInfoPageControlButton.h"
#import "ShopShowContentView.h"

@interface ShopContentView : UIScrollView<UIGestureRecognizerDelegate>
{
    
    ShopShowContentView *contentView;
    UIView *menuMask;
    ShopMenuView *menu;
    BabyInfoPageControlButton *showAndHiddenBtn;
    NSTimer *_timerToFoldDrawer;
    BOOL menuShowed;

    
}
- (void)hiddenMenuWithTapPoint:(CGPoint)pos;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
