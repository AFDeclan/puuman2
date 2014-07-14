//
//  OrderWaresFooterView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"


@interface OrderWaresFooterView : UIView
{
    UILabel *priceLabel;
    UILabel *infolabel;
    AFColorButton *selectedBtn;
    UIButton *button;
}
@property(nonatomic,assign)NSInteger section;

@end
