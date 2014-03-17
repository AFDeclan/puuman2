//
//  SettingPassWordViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "SettingBindViewController.h"
#import "AFTextImgButton.h"

@interface SettingPassWordViewController : CustomPopViewController<UITextFieldDelegate>
{
    UILabel *label_new_pwd;
    CustomTextField * pwd_old_textfield;
    CustomTextField * pwd_new_textfield;
    CustomTextField * pwd_textfield;
    AFTextImgButton *flag_pwd;
    AFTextImgButton *flag_old_pwd;
    AFTextImgButton *flag_new_pwd;

    UITextField *activeTextField;
    BOOL startEdit;
}

@end
