//
//  OrderWaresTableViewCell.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "Ware.h"

@interface OrderWaresTableViewCell : UITableViewCell
{
    AFImageView *wareImgView;
    UIImageView *frameBgImgView;
    UILabel *wareName;
    UILabel *orderNum;
    UILabel *priceLabel;

}
@property(nonatomic,assign) Ware *ware;
@end
