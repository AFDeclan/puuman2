//
//  codeView.h
//  puman
//
//  Created by 祁文龙 on 13-11-12.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface LoginCodeView : UIView<UITextFieldDelegate>
{
    CustomTextField *user_textfield;
}
@end
