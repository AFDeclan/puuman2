//
//  ShopAllWareHeaderView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"

@interface ShopAllWareHeaderView : UIView
{
    UIImageView *icon_ware;
    UILabel *wareLabel;
    ColorButton *filtrateBtn;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
- (void)setStatusWithKindIndex:(NSInteger)index andUnfold:(BOOL)unfold;
@end
