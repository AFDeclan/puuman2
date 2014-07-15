//
//  ShopSortSectionView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFSelectedImgButton.h"

@interface ShopSortSectionView : UIView
{
    AFSelectedImgButton *priceBtn;
    AFSelectedImgButton *heatBtn;
    AFSelectedImgButton *timeBtn;
}

- (void)refresh;
@end
