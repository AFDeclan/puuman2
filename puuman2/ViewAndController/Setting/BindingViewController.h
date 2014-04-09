//
//  BindingViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "BindAddButton.h"

@interface BindingViewController : CustomPopViewController<UITextFieldDelegate>
{
    CustomTextField * qq;
    CustomTextField * weibo;
    CustomTextField * alipay;
    BindAddButton *qq_btn;
    BindAddButton *weibo_btn;
    BindAddButton *alipay_btn;
    UIButton *  _confirmBtn;

}
@end
