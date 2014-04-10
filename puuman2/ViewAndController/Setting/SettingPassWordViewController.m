//
//  SettingPassWordViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SettingPassWordViewController.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
#import "CustomNotiViewController.h"
#import "CustomAlertViewController.h"


@interface SettingPassWordViewController ()

@end

@implementation SettingPassWordViewController

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
    UILabel  *label_old_pwd = [[UILabel alloc] initWithFrame:CGRectMake(36, 114, 288, 24)];
    [label_old_pwd setText:@"请输入现在的密码"];
    [label_old_pwd setFont:PMFont2];
    [label_old_pwd setTextColor:PMColor3];
    [label_old_pwd setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:label_old_pwd];
    label_new_pwd  =[[UILabel alloc] initWithFrame:CGRectMake(36, 208, 288,  24)];
    [label_new_pwd setFont:PMFont2];
    [label_new_pwd setTextColor:PMColor3];
    [label_new_pwd setText:@"新密码"];
    [label_new_pwd setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:label_new_pwd];
    
    pwd_old_textfield  = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 146, 640, 48)];
    [pwd_old_textfield setTextAlignment:NSTextAlignmentLeft];
    [pwd_old_textfield setDelegate:self];
    [pwd_old_textfield setSecureTextEntry:YES];
    [_content addSubview:pwd_old_textfield];
    
    pwd_new_textfield = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 240, 640, 48)];
    [pwd_new_textfield setTextAlignment:NSTextAlignmentLeft];
    [pwd_new_textfield setSecureTextEntry:YES];
    [pwd_new_textfield setDelegate:self];
    [pwd_new_textfield setAlpha:0];
    [_content addSubview:pwd_new_textfield];
    
    pwd_textfield = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 304, 640, 48)];
    [pwd_textfield setTextAlignment:NSTextAlignmentLeft];
    [pwd_textfield setSecureTextEntry:YES];
    [pwd_textfield setDelegate:self];
    [pwd_textfield setAlpha:0];
    [pwd_textfield setPlaceholder:@"请再输入一遍"];
    [_content addSubview:pwd_textfield];
    
    
    flag_old_pwd = [[AFTextImgButton alloc] initWithFrame:CGRectMake(592, 0, 48, 48)];
    [pwd_old_textfield addSubview:flag_old_pwd];
    flag_new_pwd = [[AFTextImgButton alloc] initWithFrame:CGRectMake(592, 0, 48, 48)];
    [pwd_new_textfield addSubview:flag_new_pwd];
    flag_pwd = [[AFTextImgButton alloc] initWithFrame:CGRectMake(592, 0, 48, 48)];
    [pwd_textfield addSubview:flag_pwd];


   
    

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
    startEdit = YES;
    activeTextField = textField;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(range.length == 0)
    {
        [self examineWithtextField:[textField.text stringByAppendingString:string]];
    }else
    {
        if(startEdit)
        {
            [self examineWithtextField:@""];
        }else
        {
            [self examineWithtextField:[textField.text substringToIndex:[textField.text length]-1] ];
        }
    }
    startEdit = NO;
    return YES;
}

-(void)examine
{
    [self examineWithtextField:activeTextField.text];
}

-(void)examineWithtextField:(NSString *)password
{
    if(activeTextField == pwd_old_textfield)
    {
        
        if ( [[UserInfo sharedUserInfo] checkPwd:password] ) {
            [flag_old_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_check_set.png"] andButtonType:kButtonTypeTwo];
            [pwd_new_textfield setAlpha:1];
            [pwd_textfield setAlpha:0.5];
            [pwd_textfield setEnabled:NO];
            [label_new_pwd setAlpha:1];
            [pwd_textfield setText:@""];
            [pwd_new_textfield setText:@""];
        }else
        {
            [flag_old_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_cross_set.png"] andButtonType:kButtonTypeTwo];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
            [flag_new_pwd setAlpha:0];
            [flag_pwd setAlpha:0];
            [label_new_pwd setAlpha:0];
            [pwd_textfield setAlpha:0];
            [pwd_new_textfield setAlpha:0];
        }
        [flag_old_pwd setAlpha:1];
        if ([password isEqualToString:@""]) {
            [flag_old_pwd setAlpha:0];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
            [flag_new_pwd setAlpha:0];
            [flag_pwd setAlpha:0];
            [label_new_pwd setAlpha:0];
            [pwd_textfield setAlpha:0];
            [pwd_new_textfield setAlpha:0];
            
        }
    }else if (activeTextField == pwd_new_textfield)
    {
        
        if ([password isEqualToString:@""]) {
            [flag_new_pwd setAlpha:0];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
            [pwd_textfield setAlpha:0.5];
            [pwd_textfield setEnabled:NO];
            [pwd_textfield setText:@""];
            [flag_pwd setAlpha:0];
            
        }else{
            [flag_new_pwd setAlpha:1];
            [flag_new_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_check_set.png"] andButtonType:kButtonTypeTwo];
            [pwd_textfield setAlpha:1];
            [pwd_textfield setEnabled:YES];
            if ([password isEqualToString:pwd_textfield.text]) {
                [flag_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_check_set.png"] andButtonType:kButtonTypeTwo];
                [_finishBtn setAlpha:1];
                [_finishBtn setEnabled:YES];
                
            }else{
                [flag_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_cross_set.png"] andButtonType:kButtonTypeTwo];
                [_finishBtn setAlpha:0.5];
                [_finishBtn setEnabled:NO];
            }
        }
    }else if (activeTextField == pwd_textfield)
    {
        [flag_pwd setAlpha:1];
        if ([pwd_new_textfield.text isEqualToString:password]) {
            [flag_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_check_set.png"] andButtonType:kButtonTypeTwo];
            [_finishBtn setAlpha:1];
            [_finishBtn setEnabled:YES];
            
        }else{
            [flag_pwd setTitle:nil andImg:[UIImage imageNamed:@"icon_cross_set.png"] andButtonType:kButtonTypeTwo];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
        }
    }
    
}

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:@selector(startShow) stopSelector:nil];
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
}

- (void)startShow
{
    [pwd_old_textfield becomeFirstResponder];
}

- (void)finishBtnPressed
{
    
    UserActionResult result = [[UserInfo sharedUserInfo] changePwdTo:pwd_new_textfield.text];
    switch (result) {
        case succeeded:
        {
            [CustomNotiViewController showNotiWithTitle:@"修改成功" withTypeStyle:kNotiTypeStyleRight];
            break;
        }
        case checkFailed:
        {
            [CustomNotiViewController showNotiWithTitle:@"修改失败" withTypeStyle:kNotiTypeStyleRight];

        }
            break;
        case timeOut:
        {
            [CustomAlertViewController showAlertWithTitle:@"网络连接异常，请检查您的网络连接" confirmRightHandler:^{
                
            }];
        }
            break;
        default:
        {
            [CustomAlertViewController showAlertWithTitle:@"服务器异常" confirmRightHandler:^{
                
            }];
        }
            break;
    }
    [super finishBtnPressed];
}


@end
