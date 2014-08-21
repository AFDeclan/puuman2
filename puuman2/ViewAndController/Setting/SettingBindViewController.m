//
//  SettingBindViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SettingBindViewController.h"
#import "UserInfo.h"
#import "MainTabBarController.h"

@interface SettingBindViewController ()

@end

@implementation SettingBindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContentView];
        
    }
    return self;
}

- (void)initContentView
{
    UILabel  *email_address = [[UILabel alloc] initWithFrame:CGRectMake(36, 114, 288, 24)];
    [email_address setText:@"邮箱地址"];
    [email_address setFont:PMFont2];
    [email_address setTextColor:PMColor3];
    [email_address setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:email_address];
    UILabel  *phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(36, 208, 288,  24)];
    [phoneNum setText:@"手机号码"];
    [phoneNum setFont:PMFont2];
    [phoneNum setTextColor:PMColor3];
    [phoneNum setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:phoneNum];
    
    [self initEmailBtn];
    [self initPhoneBtn];
    
    resend = [[ReSendButton alloc] initWithFrame:CGRectMake(128, 336, 320, 48)];
    [resend addTarget:self action:@selector(resent:) forControlEvents:UIControlEventTouchUpInside];
    [resend setAlpha:0];
    [_content addSubview:resend];
    
}

- (void)initEmailBtn
{
    //是否验证，是否有号码
    NSString *mailAddr = [[UserInfo sharedUserInfo] mailAddr];
    BOOL check = [[UserInfo sharedUserInfo] mailVerified];
    mail = [[SettingBindCellView alloc] initWithFrame:CGRectMake(32, 146, 672, 48)];
    [mail setCheck:check andType:TypeOfEmail withTheNum:mailAddr];
    [mail setDelegate:self];
    [_content addSubview:mail];
    
}

- (void)initPhoneBtn
{
    //是否验证，是否有号码
    NSString *phoneNum = [[UserInfo sharedUserInfo] phoneNum];
    BOOL check = [[UserInfo sharedUserInfo] phoneVerified];
    phone = [[SettingBindCellView alloc] initWithFrame:CGRectMake(32, 240, 672, 48)];
    [phone setDelegate:self];
    [phone setCheck:check andType:TypeOfPhone withTheNum:phoneNum];
    [_content addSubview:phone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)keyboardWillShow:(NSNotification *)notif
{
    
 
}

- (void)keyboardWillHide:(NSNotification *)notif
{
   
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resent:(ReSendButton *)sender
{
    [phone resend];
}

- (void)sendTheInfo
{
    [resend startSend];
    [resend setAlpha:1];
}

@end
