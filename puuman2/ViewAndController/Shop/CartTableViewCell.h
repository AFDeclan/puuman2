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
@protocol CartCellDelegate;
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
    UIImageView *rmb_icon;
    NSInteger wareIndex;
    UIImageView *selectedFlag;
    UIView *bg_compareSelected;
    UIImageView* flag[5];

}
@property(nonatomic,assign)id<CartCellDelegate>  delegate;
@property(nonatomic,assign)BOOL isCompare;
@property(nonatomic,assign)BOOL unflod;
@property(nonatomic,assign)BOOL chooseToCompared;
@property(nonatomic,retain)NSIndexPath *indexPath;
- (void)buildCellWithPaid:(BOOL)paid andWareIndex:(NSInteger)index;
@end

@protocol CartCellDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end