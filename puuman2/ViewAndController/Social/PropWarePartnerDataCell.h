//
//  PropWarePartnerDataCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
@interface PropWarePartnerDataCell : UITableViewCell
{
    AFImageView *propImageView;
    UIView *mask;
    UIView *mask_name;
    UILabel *name_label;
    UILabel *status_label;
}
@property (assign,nonatomic)float frameY;
@property (assign,nonatomic)float frameH;
- (void)setDataWithWareName:(NSString *)wareNmae andStatus:(NSString *)staus andWarePic:(NSString *)pic;

@end
