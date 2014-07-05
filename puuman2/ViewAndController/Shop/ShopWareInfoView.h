//
//  ShopWareInfoView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "SelectedButton.h"
#import "ColorButton.h"
#import "UIColumnView.h"

@interface ShopWareInfoView : UIView<SelectedButtonDelegate,UIColumnViewDataSource,UIColumnViewDelegate>
{
    
    UIView *headView;
    UIView *infoView;

    UILabel *titleLabel;
    UIButton *backBtn;
    AFImageView *wareImgView;
    UILabel *wareName;
    UILabel *priceLabel;
    SelectedButton *addCountBtn;
    SelectedButton *reduceCountBtn;
    UILabel *changeCountLabel;
    ColorButton *shareBtn;
    ColorButton *addToCart;
    UIColumnView *infoTableView;

}
- (void)refresh;

@end

