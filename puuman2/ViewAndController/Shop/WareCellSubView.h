//
//  WareCellSubView.h
//  puman
//
//  Created by 陈晔 on 13-9-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ware;
@class AFImageView;
@interface WareCellSubView : UIView
{
    AFImageView *_wareImageView;
    UILabel *_lowPriceIntLabel, *_lowPriceFracLabel, *_highPriceLabel;
    UILabel *_nameLabel;
    UILabel *_shopCntLabel;
    Ware *_ware;
}

- (void)setWare:(Ware *)ware;
- (void)prepareForReuse;


@end
