//
//  idSettingView.h
//  puman
//
//  Created by 祁文龙 on 13-11-4.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "MBProgressHUD.h"
#import "CustomTextField.h"


@interface SettingBindView : UIView<UITextFieldDelegate>
{
     MBProgressHUD* hud;
     UIView *codeView;
     NSString *oldAlipayNum;
     BOOL _alipayChanged;
}
@property (strong, nonatomic)  UIImageView *sinaBlockView;
@property (strong, nonatomic)  UIImageView *qqBlockView;
@property (strong, nonatomic)  UIImageView *alipayBlockView;
@property (strong, nonatomic)  UIButton *setSinaBtn;
@property (strong, nonatomic)  UIButton *setQQBtn;
@property (strong, nonatomic)  UIButton *setAlipayBtn;
@property (strong, nonatomic)  UILabel *sinaLabel;
@property (strong, nonatomic)  UILabel *QQLabel;
@property (strong, nonatomic)  AFImageView *sinaImgView;
@property (strong, nonatomic)  AFImageView *QQImgView;
@property (strong, nonatomic)  UITextField *alipayTextfield;
@property (strong, nonatomic)   UILabel *userBlockLabel;
@property (strong, nonatomic)   UIButton *changePwdBtn;
@property (strong, nonatomic)   UIButton *relatedBtn;
@property (strong, nonatomic)   UIButton *confirmBtn;

@end
