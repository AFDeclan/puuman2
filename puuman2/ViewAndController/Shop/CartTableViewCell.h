//
//  CartTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "AFTextImgButton.h"
#import "Ware.h"

@interface CartTableViewCell : UITableViewCell<UIScrollViewDelegate>
{
    AFImageView *wareImg;
    UILabel *wareName;
    UILabel *warePrice;
    UILabel *wareTime;
    UILabel *wareShop;
    UIScrollView *infoScrollView;
    AFTextImgButton *delBtn;
    UIImageView *time_icon;
    Ware *_ware;
    BOOL isPaid;
}
@property(nonatomic,assign)BOOL isCompare;
- (void)buildCellWithWare:(Ware *)ware  flagCount:(NSInteger)flagCount wareTime:(NSString *)wt;
- (void)setWare:(Ware *)ware price:(float)price wareTime:(NSString *)wt;
@end
