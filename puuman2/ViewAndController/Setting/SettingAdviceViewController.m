//
//  SettingAdviceViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SettingAdviceViewController.h"
#import "PumanRequest.h"
#import "UserInfo.h"
#import "CustomAlertViewController.h"
#import "CustomNotiViewController.h"

@interface SettingAdviceViewController ()

@end

@implementation SettingAdviceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [self initContentView];
    }
    return self;
}

-(void)initContentView
{
    UILabel *label  =[[UILabel alloc] initWithFrame:CGRectMake(36, 114, 288, 24)];
    [label setFont:PMFont2];
    [label setTextColor:PMColor3];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:@"请在下面输入您对我们的宝贵意见和建议："];
    [_content addSubview:label];
    textBgView  =[[UIImageView alloc] initWithFrame: CGRectMake(32, 146, 640, 160)];
    [textBgView setBackgroundColor:PMColor5];
    [_content addSubview:textBgView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(48, 146, 606, 160)];
    [_textView setFont:PMFont2];
    [_textView setTextColor:PMColor2];
    [_textView setDelegate:self];
    [_textView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:_textView];
   

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (range.length == 1) {
        if ([textView.text length]==1) {
            _finishBtn.enabled = NO;
            _finishBtn.alpha = 0.5;
        }else
        {
            _finishBtn.enabled = YES;
            _finishBtn.alpha = 1;
        }
    }else{
        
        _finishBtn.enabled = YES;
        _finishBtn.alpha = 1;
    }
    return YES;
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

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:@selector(startShow) stopSelector:nil];
    [_finishBtn setEnabled:NO];
    [_finishBtn setAlpha:0.5];
}

- (void)startShow
{
    [_textView becomeFirstResponder];
}

- (void)finishBtnPressed
{
    PumanRequest* request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_PostFeedback;
    [request setTimeOutSeconds:5];
    [request setParam:[NSString stringWithFormat:@"%d", [UserInfo sharedUserInfo].UID] forKey:@"UID"];
    [request setParam:_textView.text forKey:@"Content"];
    
    PostNotification(Noti_ShowHud, @"正在提交反馈...");
    [request postSynchronous];
    PostNotification(Noti_HideHud, nil);
    
    switch (request.result) {
        case PumanRequest_Succeeded:
        {
            [_textView resignFirstResponder];
            [CustomNotiViewController showNotiWithTitle:@"提交成功" withTypeStyle:kNotiTypeStyleRight];
            [self recoverSettingView];
            [super finishBtnPressed];
            break;
        }
        case PumanRequest_TimeOut:
        {
            [CustomAlertViewController showAlertWithTitle: @"您当前的网络状态不佳，请在网络通畅的环境中再次尝试" confirmRightHandler:^{
                
            }];
        }
            break;
        default:
            [CustomAlertViewController showAlertWithTitle:  @"链接异常，请稍后重试" confirmRightHandler:^{
                
            }];
            break;
    }

}

-(void) recoverSettingView{
    
    [_textView setText:@""];
    _finishBtn.alpha = 0.5;
    _finishBtn.enabled = NO;
    
    
}

@end
