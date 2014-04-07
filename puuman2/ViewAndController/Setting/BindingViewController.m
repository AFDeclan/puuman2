//
//  BindingViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BindingViewController.h"
#import "SocialNetwork.h"
#import "UserInfo.h"

@interface BindingViewController ()

@end

@implementation BindingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UILabel  *alipay_noti = [[UILabel alloc] initWithFrame:CGRectMake(36, 112, 288, 24)];
        [alipay_noti setText:@"支付宝："];
        [alipay_noti setFont:PMFont2];
        [alipay_noti setTextColor:PMColor3];
        [alipay_noti setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:alipay_noti];
        
        UILabel *weibo_noti = [[UILabel alloc] initWithFrame:CGRectMake(36, 208, 288,24)];
        [weibo_noti setText:@"新浪微博："];
        [weibo_noti setFont:PMFont2];
        [weibo_noti setTextColor:PMColor3];
        [weibo_noti setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:weibo_noti];
        
        
        UILabel  *weixin_noti = [[UILabel alloc] initWithFrame:CGRectMake(36, 304, 288, 24)];
        [weixin_noti setText:@"微信朋友圈"];
        [weixin_noti setFont:PMFont2];
        [weixin_noti setTextColor:PMColor3];
        [weixin_noti setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:weixin_noti];
        
        alipay  = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 146, 640, 48)];
        [alipay setTextAlignment:NSTextAlignmentLeft];
        [alipay setDelegate:self];
       
        [_content addSubview:alipay];
        
        weibo = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 240, 640, 48)];
        [weibo setTextAlignment:NSTextAlignmentLeft];
        [_content addSubview:weibo];
        weixin = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 304, 640, 48)];
        [weixin setTextAlignment:NSTextAlignmentLeft];
        [_content addSubview:weixin];
        
        
       
        [weibo setEnabled:NO];
        [weixin setEnabled:NO];
        
        alipay_btn = [[BindAddButton alloc] initWithFrame:CGRectMake(32, 146, 640, 48)];
        [alipay_btn addTarget:self action:@selector(alipayChanged) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:alipay_btn];
        
        weibo_btn = [[BindAddButton alloc] initWithFrame:CGRectMake(32, 240, 640, 48)];
        [weibo_btn addTarget:self action:@selector(bindWeibo:) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:weibo_btn];
     //   weixin_btn = [[BindAddButton alloc] initWithFrame:CGRectMake(32, 304, 640, 48)];
      //  [weixin_btn addTarget:self action:@selector(bindWeiXin:) forControlEvents:UIControlEventTouchUpInside];
      //  [_content addSubview:weixin_btn];
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(624, 146, 48, 48)];
        [_confirmBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
        [_confirmBtn setAlpha:0];
        [_confirmBtn addTarget:self action:@selector(confirmBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:_confirmBtn];
        
        NSString *userName = [[SocialNetwork sharedInstance] WeiboUserName];
        NSString *imgUrl = [[SocialNetwork sharedInstance] WeiboUserImgUrl];
        weibo.text = userName;
       // [self.sinaImgView getImage:imgUrl defaultImage:nil];
        if (userName && imgUrl){
            [weibo_btn hiddenAdd];
        }else{
            [weibo_btn showAdd];
        }
         //  [self.setSinaBtn setImage:nil forState:UIControlStateNormal];
        
      //  userName = [[SocialNetwork sharedInstance] QQUserName];
       // imgUrl = [[SocialNetwork sharedInstance] QQUserImgUrl];
       // self.QQLabel.text = userName;
     //   [self.QQImgView getImage:imgUrl defaultImage:nil];
     //   if (userName && imgUrl)
     //       [self.setQQBtn setImage:nil forState:UIControlStateNormal];
        
        NSString *alipayStr = [[UserInfo sharedUserInfo] alipayAccount];
        [alipay setText:alipayStr];
        if (alipayStr)
        {
            [alipay_btn hiddenAdd];
            //[self.setAlipayBtn setImage:nil forState:UIControlStateNormal];
        }else{
            [alipay_btn showAdd];

        }
        


    }
    return self;
}

- (void)alipayChanged
{
    [alipay becomeFirstResponder];
}

- (void)bindWeibo:(BindAddButton *)sender
{

    [MobClick event:umeng_event_click label:@"bindWeibo_SettingBindView"];
    [alipay resignFirstResponder];
    [_confirmBtn setAlpha:0];
    [[SocialNetwork sharedInstance] loginToSocial:Weibo];
 
}


- (void)bindWeiXin:(BindAddButton *)sender
{
    [MobClick event:umeng_event_click label:@"bindWeiXin_SettingBindView"];
    [alipay resignFirstResponder];
    [_confirmBtn setAlpha:0];
    [[SocialNetwork sharedInstance] loginToSocial:Weixin];
}

- (void)confirmBtnPressed:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"Confirm_Shop"];
    [alipay resignFirstResponder];
//    if( hud == nil )
//        hud = [[MBProgressHUD alloc] initWithView:self];
 //   [hud setLabelText:@"正在和服务器同步您的支付宝账号"];
  //  [self addSubview:hud];
  //  [hud show:YES];
    if ([[UserInfo sharedUserInfo] setAlipayAccount:alipay.text])
    {
      //  NSString *alipay = [[UserInfo sharedUserInfo] alipayAccount];
       // [CustomAlertView showInView:nil content:[NSString stringWithFormat:@"您的支付宝账号已更新:\n%@", alipay]];
        [alipay_btn hiddenAdd];
        [_confirmBtn setAlpha:0];
    }
    else
    {
       // [CustomAlertView showInView:nil content:[NSString stringWithFormat:@"网络不给力喔~更新失败"]];
        //[self.setAlipayBtn setAlpha:1];
    }
   // [hud removeFromSuperview];
   // hud = nil;
   //
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   // oldAlipayNum = textField.text;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == alipay) {
        
        if (range.length == 1)
        {
            if ([textField.text length]==1) {
                [_confirmBtn setAlpha:1];
               // _alipayChanged = YES;
            }else{
              //  NSString *alipayStr = [textField.text substringToIndex:[textField.text length]-1];
               // if ([alipayStr isEqualToString:oldAlipayNum]) {
                 //   [_confirmBtn setAlpha:0];
                 //   _alipayChanged = NO;
              //  }else{
                    [_confirmBtn setAlpha:1];
                  //  _alipayChanged = YES;
               // }
                
            }
        }else{
           // NSString *alipay = [textField.text stringByAppendingString:string];
           // if ([alipay isEqualToString:oldAlipayNum]) {
             //   [_confirmBtn setAlpha:0];
               // _alipayChanged = NO;
           // }else{
                [_confirmBtn setAlpha:1];
              //  _alipayChanged = YES;
           // }
            
            
            
        }
        
    }
    
    return YES;
}


@end
