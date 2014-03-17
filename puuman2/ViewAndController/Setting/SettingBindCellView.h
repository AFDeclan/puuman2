//
//  SettingBindCellView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "ColorButton.h"

typedef enum{
    Status_NotAdded,
    Status_Changing,
    Status_NotVerified,
    Status_Verified
} Status;

typedef enum{
    TypeOfEmail,
    TypeOfPhone
} ButtonType;

@protocol SettingBindDelegate;

@interface SettingBindCellView : UIView<UITextFieldDelegate>
{
    UIButton *settingButton;
    Status status, oStatus;
    ButtonType buttontype;
    CustomTextField *numTextField;
    UILabel *titleLabel;
    UILabel  *codeLabel;
    ColorButton *modify;
    UIButton *conformBtn;
    UIImageView *settingBgImgView;
    BOOL isCheck;
}
@property (nonatomic, weak) id<SettingBindDelegate> delegate;
- (void)setCheck:(BOOL)check andType:(ButtonType)btnType withTheNum:(NSString *)num;
- (void)textFieldresignFirstResponder;
- (void)resend;
@end
@protocol SettingBindDelegate <NSObject>

@optional
- (void)sendTheInfo;
- (void)textFieldresign;

@end