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
@interface ShopContentView : UIScrollView
{
    RectWareView *rectView;
    AllWareView *allView;
}
- (void)goToAllShop;
- (void)goToRectShop;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
