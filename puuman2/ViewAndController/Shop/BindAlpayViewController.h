//
//  BindAlpayViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"

@interface BindAlpayViewController : CustomPopViewController<UITextFieldDelegate>
{
    CustomTextField * alipay;
    UIButton *  _confirmBtn;
}
@end
