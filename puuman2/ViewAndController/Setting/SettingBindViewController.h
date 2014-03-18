//
//  SettingBindViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "SettingBindCellView.h"
#import "ReSendButton.h"

@interface SettingBindViewController : CustomPopViewController<SettingBindDelegate>
{

    ReSendButton *resend;
    SettingBindCellView *mail;
    SettingBindCellView *phone;
}
@end
