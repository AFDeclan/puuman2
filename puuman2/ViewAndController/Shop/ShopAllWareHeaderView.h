//
//  ShopAllWareHeaderView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopAllWareHeaderView : UIView
{
    UIImageView *icon_ware;
    UIImageView *icon_tri;
    UIImageView *partLine;
    UILabel *wareLabel;
    UILabel *moreLabel;
    
}

- (void)setStatusWithKindIndex:(NSInteger)index andUnfold:(BOOL)unfold;
@end
