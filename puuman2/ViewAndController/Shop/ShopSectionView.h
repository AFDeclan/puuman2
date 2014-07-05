//
//  ShopSectionView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopSortSectionView.h"
#import "WareInfoSectionView.h"

@interface ShopSectionView : UIView
{
    ShopSortSectionView *sortView;
    WareInfoSectionView *wareInfoView;
    BOOL showAllShop;
    BOOL showWareInfo;
}
@end
