//
//  ShopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"
#import "SearchTextField.h"
#import "ShopContentView.h"
#import "ShopSectionView.h"
#import "ShopCartViewController.h"

@interface ShopViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,PopViewDelegate>
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;

    SearchTextField *searchTextField;
    AFColorButton *searchBtn;
    UIView *searchView;
    ShopContentView *contentShop;
    UIButton *cartBtn;
    ShopSectionView *sectionView;
    BOOL wareInfoShow;
}


+ (ShopViewController *)sharedShopViewController;
- (void)showWareInfo;
@end
