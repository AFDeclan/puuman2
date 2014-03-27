//
//  RectRankSubCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecomWare.h"
#import "AFImageView.h"

@interface RectRankSubCell : UITableViewCell
{
    AFImageView *iconWare;
    UILabel *priceLabel;
    UILabel *nameLabel;
    
}
- (void)bulidCellWithWareData:(RecomWare *)ware;
@end
