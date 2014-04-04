//
//  idSettingView.m
//  puman
//
//  Created by 祁文龙 on 13-11-4.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SettingBindView.h"
#import "SettingViewController.h"
#import "SocialNetwork.h"
#import "UserInfo.h"
#import "UniverseConstant.h"

@implementation SettingBindView
@synthesize sinaBlockView = _sinaBlockView;
@synthesize qqBlockView = _qqBlockView;
@synthesize alipayBlockView = _alipayBlockView;
@synthesize setAlipayBtn = _setAlipayBtn;
@synthesize setQQBtn = _setQQBtn;
@synthesize setSinaBtn = _setSinaBtn;
@synthesize sinaLabel = _sinaLabel;
@synthesize QQLabel =_QQLabel;
@synthesize sinaImgView =_sinaImgView;
@synthesize QQImgView =_QQImgView;
@synthesize alipayTextfield = _alipayTextfield;
@synthesize userBlockLabel = _userBlockLabel;
@synthesize changePwdBtn = _changePwdBtn;
@synthesize relatedBtn = _relatedBtn;
@synthesize confirmBtn = _confirmBtn;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _alipayChanged = NO;
        // Initialization code
        [self initUserBlock];
        NSString *userName = [[SocialNetwork sharedInstance] WeiboUserName];
        NSString *imgUrl = [[SocialNetwork sharedInstance] WeiboUserImgUrl];
        self.sinaLabel.text = userName;
        [self.sinaImgView getImage:imgUrl defaultImage:nil];
        if (userName && imgUrl)
            [self.setSinaBtn setImage:nil forState:UIControlStateNormal];
        
        userName = [[SocialNetwork sharedInstance] QQUserName];
        imgUrl = [[SocialNetwork sharedInstance] QQUserImgUrl];
        self.QQLabel.text = userName;
        [self.QQImgView getImage:imgUrl defaultImage:nil];
        if (userName && imgUrl)
            [self.setQQBtn setImage:nil forState:UIControlStateNormal];
        
        NSString *alipay = [[UserInfo sharedUserInfo] alipayAccount];
        [self.alipayTextfield setText:alipay];
        if (alipay)
        {
            [self.setAlipayBtn setImage:nil forState:UIControlStateNormal];
        }
    }
    return self;
}



-(void)initUserBlock
{
    //title
    _userBlockLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 352, 21)];
    [_userBlockLabel setText:@"您可以将扑满日记账户与其他账户进行绑定"];
    [_userBlockLabel setFont:PMFont2];
    [_userBlockLabel setTextColor:PMColor2];
    [self addSubview:_userBlockLabel];
    //blockview
    _sinaBlockView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 48, 352, 40)];
    [_sinaBlockView setImage:[UIImage imageNamed:@"btn_sina_set.png"]];
    [self addSubview:_sinaBlockView];
    _qqBlockView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 104, 352, 40)];
    [_qqBlockView setImage:[UIImage imageNamed:@"btn_tencent_set.png"]];
    [self addSubview:_qqBlockView];
    _alipayBlockView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 160, 352, 40)];
    [_alipayBlockView setImage:[UIImage imageNamed:@"btn_zhifubao_set.png"]];
    [self addSubview:_alipayBlockView];
    //img
    _sinaImgView = [[AFImageView alloc] initWithFrame:CGRectMake(63, 48, 40, 40)];
    [self addSubview:_sinaImgView];
    
    _QQImgView = [[AFImageView alloc] initWithFrame:CGRectMake(63, 104, 40, 40)];
    [self addSubview:_QQImgView];
    //label
    _sinaLabel =[[UILabel alloc] initWithFrame:CGRectMake(110, 49, 247, 40)];
    [_sinaLabel setFont:PMFont2];
    [_sinaLabel setTextColor:PMColor2];
    [self addSubview:_sinaLabel];
    _QQLabel =[[UILabel alloc] initWithFrame:CGRectMake(110, 104, 247, 40)];
    [_QQLabel setFont:PMFont2];
    [_QQLabel setTextColor:PMColor2];
    [self addSubview:_QQLabel];
    //btn
    _setSinaBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 48, 352, 40)];
    [_setSinaBtn setImage:[UIImage imageNamed:@"btn_add_set.png"] forState:UIControlStateNormal];
    [_setSinaBtn addTarget:self action:@selector(bindWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_setSinaBtn];
    
    _setQQBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 104, 352, 40)];
    [_setQQBtn setImage:[UIImage imageNamed:@"btn_add_set.png"] forState:UIControlStateNormal];
    [_setQQBtn addTarget:self action:@selector(bindQQ:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_setQQBtn];
     _setAlipayBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 160, 352, 40)];
    [_setAlipayBtn setImage:[UIImage imageNamed:@"btn_add_set.png"] forState:UIControlStateNormal];
    [_setAlipayBtn addTarget:self action:@selector(bindAlipay:) forControlEvents:UIControlEventTouchUpInside];
    

    //textField
    
    _alipayTextfield = [[UITextField alloc] initWithFrame:CGRectMake(70, 168, 260, 21)];
    [_alipayTextfield setTextColor:PMColor2];
    [_alipayTextfield setFont:PMFont2];
    _alipayTextfield.delegate = self;
    [self addSubview:_alipayTextfield];
     _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(340, 168, 25, 25)];
    [_confirmBtn setImage:[UIImage imageNamed:@"btn_finish_diary.png"] forState:UIControlStateNormal];
    [_confirmBtn setAlpha:0];
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmBtn];
    
}

- (void)confirmBtnPressed:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"Confirm_Shop"];
    [_alipayTextfield resignFirstResponder];
    if( hud == nil )
        hud = [[MBProgressHUD alloc] initWithView:self];
    [hud setLabelText:@"正在和服务器同步您的支付宝账号"];
    [self addSubview:hud];
    [hud show:YES];
    if ([[UserInfo sharedUserInfo] setAlipayAccount:_alipayTextfield.text])
    {
        NSString *alipay = [[UserInfo sharedUserInfo] alipayAccount];
       // [CustomAlertView showInView:nil content:[NSString stringWithFormat:@"您的支付宝账号已更新:\n%@", alipay]];
        [_setAlipayBtn setAlpha:0];
        _alipayChanged = NO;
    }
    else
    {
       // [CustomAlertView showInView:nil content:[NSString stringWithFormat:@"网络不给力喔~更新失败"]];
        [self.setAlipayBtn setAlpha:1];
    }
    [hud removeFromSuperview];
    hud = nil;
    
    
}










- (void)bindWeibo:(UIButton *)sender
{
     [MobClick event:umeng_event_click label:@"bindWeibo_SettingBindView"];
    [_alipayTextfield resignFirstResponder];
    _alipayChanged = NO;
    [_confirmBtn setAlpha:0];
  //  [_alipayTextfield setText:oldAlipayNum];
    [[SocialNetwork sharedInstance] loginToSocial:Weibo];
}
- (void)bindQQ:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"bindQQ_SettingBindView"];
    [_alipayTextfield resignFirstResponder];
    _alipayChanged = NO;
    [_confirmBtn setAlpha:0];
  //  [_alipayTextfield setText:oldAlipayNum];
    [[SocialNetwork sharedInstance] loginToSocial:QQ];
  
}
- (void)bindAlipay:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"BindAlipay_SettingBindView"];
 
    self.alipayTextfield.enabled = YES;
    [self.alipayTextfield becomeFirstResponder];
    [self.setAlipayBtn setAlpha:0];
   

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    oldAlipayNum = textField.text;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
     if (textField == self.alipayTextfield) {
        
            if (range.length == 1)
            {
                if ([textField.text length]==1) {
                    [_confirmBtn setAlpha:1];
                    _alipayChanged = YES;
                    }else{
                        NSString *alipay = [textField.text substringToIndex:[textField.text length]-1];
                        if ([alipay isEqualToString:oldAlipayNum]) {
                            [_confirmBtn setAlpha:0];
                            _alipayChanged = NO;
                        }else{
                            [_confirmBtn setAlpha:1];
                            _alipayChanged = YES;
                        }
                        
                        }
            }else{
                NSString *alipay = [textField.text stringByAppendingString:string];
                if ([alipay isEqualToString:oldAlipayNum]) {
                    [_confirmBtn setAlpha:0];
                    _alipayChanged = NO;
                }else{
                    [_confirmBtn setAlpha:1];
                    _alipayChanged = YES;
                }
                
                
                
         }
         
     }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)socialNetworkLogined:(NSNotification *)sender
{
    switch ((SocialType)[sender.object integerValue]) {
        case Weibo:
        {
            NSString *userName = [[SocialNetwork sharedInstance] WeiboUserName];
            NSString *imgUrl = [[SocialNetwork sharedInstance] WeiboUserImgUrl];
            self.sinaLabel.text = userName;
            [self.sinaImgView getImage:imgUrl defaultImage:nil];
            [self.setSinaBtn setImage:nil forState:UIControlStateNormal];
        }
            break;
        case QQ:
        {
            NSString *userName = [[SocialNetwork sharedInstance] QQUserName];
            NSString *imgUrl = [[SocialNetwork sharedInstance] QQUserImgUrl];
            self.QQLabel.text = userName;
            [self.QQImgView getImage:imgUrl defaultImage:nil];
            [self.setQQBtn setImage:nil forState:UIControlStateNormal];
        }
        default:
            break;
    }
}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}


@end
