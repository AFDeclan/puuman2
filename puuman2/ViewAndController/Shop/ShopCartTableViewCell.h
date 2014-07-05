//
//  ShopCartTableViewCell.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "Ware.h"
#import "SelectedButton.h"

@interface ShopCartTableViewCell : UITableViewCell<SelectedButtonDelegate>
{
    UIButton *selectedBtn;
    AFImageView *wareImgView;
    UIImageView *frameBgImgView;
    UILabel *wareName;
    UILabel *orderNum;
    UILabel *priceLabel;
    UIView *content;
    UILabel *total_priceLabel;
    SelectedButton *addBtn;
    SelectedButton *minusBtn;
    UILabel *num_wares;
    int count;
}
@property(nonatomic,assign) Ware *ware;
@property(nonatomic,assign) BOOL selectedWare;
@end
