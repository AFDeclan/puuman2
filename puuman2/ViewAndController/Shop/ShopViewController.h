//
//  ShopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFSelecedTextImgButton.h"
#import "AllWareView.h"
#import "RectWareView.h"
#import "ColorButton.h"
#import "SearchTextField.h"

@interface ShopViewController : UIViewController
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;
    AFSelecedTextImgButton *rectWareBtn;
    AFSelecedTextImgButton *allWareBtn;
    RectWareView *rectView;
    AllWareView *allView;
    ColorButton *searchBtn;
    SearchTextField *searchTextField;
    UIView *searchView;
    
}
@end
