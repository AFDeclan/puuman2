//
//  InviteView.h
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "AFColorButton.h"

@interface InviteView : UIView<UITextFieldDelegate>
{
    UILabel *titleLabel;
    UILabel *detailLabel;
    CustomTextField *relateNum;
    AFColorButton *inviteBtn;
    
}
-(void)resign;
@end
