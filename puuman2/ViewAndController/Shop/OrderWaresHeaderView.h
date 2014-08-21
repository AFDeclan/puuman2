//
//  OrderWaresHeaderView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderWaresHeaderView : UIView
{
    UIView *content;
    UIImageView *icon_status;
    UILabel *label_status;
    UILabel *info_date;
    UILabel *label_detail;
    UIButton *button;

}

@property(nonatomic,assign)NSInteger section;
@end
