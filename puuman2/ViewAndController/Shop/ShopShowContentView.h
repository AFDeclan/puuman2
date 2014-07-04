//
//  ShopShowContentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllWareView.h"
#import "RectWareView.h"
#import "ShopWareInfoView.h"

@interface ShopShowContentView : UIView
{
    RectWareView *rectView;
    AllWareView *allView;
    ShopWareInfoView *infoView;
    UIScrollView *wareInfoScrollView;
    BOOL wareInfoShowed;
}

- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
