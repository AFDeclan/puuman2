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

@interface ShopViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;

    SearchTextField *searchTextField;
    AFColorButton *searchBtn;
    UIView *searchView;
    ShopContentView *contentShop;
    UIButton *cartBtn;
    ShopSectionView *sectionView;
}


+ (ShopViewController *)sharedShopViewController;

@end
