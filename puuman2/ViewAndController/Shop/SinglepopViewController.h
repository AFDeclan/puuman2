//
//  SinglepopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFImageView.h"
#import "ColorButton.h"
#import "Ware.h"

@interface SinglepopViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate>
{
    Ware *_ware;
    AFImageView *wareImgView;
    UILabel *_lowPriceIntLabel, *_lowPriceFracLabel, *_highPriceLabel;
    UILabel *wareNameLabel;
    UITableView *_propertyTableView;
    UITableView *_shopsTableView;
    ColorButton *shareBtn;
    ColorButton *addBtn;
     NSMutableArray *_shopsInfo;
     NSMutableArray *_detail_propertyKeys;
     NSArray *_propertyKeys;
}

- (void)setWare:(Ware *)w;
- (void)singleInfoButtonUnpress;

@end
