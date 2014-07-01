//
//  ShopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFSelecedTextImgButton.h"
#import "ColorButton.h"
#import "SearchTextField.h"
#import "ShopContentView.h"

@interface ShopViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;
    AFSelecedTextImgButton *priceBtn;
    AFSelecedTextImgButton *heatBtn;
    AFSelecedTextImgButton *timeBtn;
    SearchTextField *searchTextField;
    ColorButton *searchBtn;
    UIView *searchView;
    ShopContentView *contentShop;
    UIButton *cartBtn;
}

- (void)showAllShop;
- (void)showRectShop;
+ (ShopViewController *)sharedShopViewController;

@end
