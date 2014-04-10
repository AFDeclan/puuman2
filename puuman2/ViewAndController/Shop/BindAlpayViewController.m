//
//  BindAlpayViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BindAlpayViewController.h"
#import "UserInfo.h"
#import "CustomAlertViewController.h"

@interface BindAlpayViewController ()

@end

@implementation BindAlpayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        alipay  = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 146, 640, 48)];
        [alipay setTextAlignment:NSTextAlignmentLeft];
        [alipay setDelegate:self];
        [alipay setPlaceholder:@"请输入您的支付宝账号"];
        [_content addSubview:alipay];
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(632, 154, 32, 32)];
        [_confirmBtn setImage:[UIImage imageNamed:@"btn_finish2.png"] forState:UIControlStateNormal];
        [_confirmBtn setAlpha:0];
        [_confirmBtn addTarget:self action:@selector(confirmBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:_confirmBtn];
        [alipay becomeFirstResponder];
    }
    return self;
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
          NSString *alipayStr = [[UserInfo sharedUserInfo] alipayAccount];
        [CustomAlertViewController showAlertWithTitle:[NSString stringWithFormat:@"您的支付宝账号已更新:\n%@", alipayStr] confirmRightHandler:^{
            
        }];
        [_confirmBtn setAlpha:0];
    }
    else
    {
        [CustomAlertViewController showAlertWithTitle:@"网络不给力喔~更新失败" confirmRightHandler:^{
            
        }];
     
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
        if (range.length == 1)
        {
            if ([textField.text length]==1) {
                [_confirmBtn setAlpha:0];
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
        
   
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
