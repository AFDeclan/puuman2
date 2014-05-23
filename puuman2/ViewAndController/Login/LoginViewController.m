//
//  LoginViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfo.h"
#import "DateFormatter.h"
#import "CustomAlertViewController.h"
#import "TaskModel.h"
#import "BabyData.h"
#import "ProtocalPuumanViewController.h"
#import "MainTabBarController.h"
#import "CustomNotiViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isBirthView = NO;
        changeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 96, 704, 512)];
        [changeView setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:changeView];
        [changeView setContentSize:CGSizeMake(kLoginsubViewWidth*3, 512)];
        [changeView setScrollEnabled:NO];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
        [self.view addGestureRecognizer:tap];
        [self initProtocolNotiView];
    }
    return self;
}

- (void)hiddenKeyBoard
{
    switch (loginView) {
        case kLoginLoadView:
            [loadView resigntextField];
            break;
        case kLoginBirthRegisterView:
            [birth resigntextField];
            break;
        case kLoginPregnancyRegisterView:
            [pregnancy resigntextField];
            break;
        case kLoginEndView:
            [endView resigntextField];
            break;
        default:
            break;
    }
}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    if (loginView==kLoginBirthRegisterView) {
        [birth setHorizontalFrame];
    }
    if (kLoginPregnancyRegisterView) {
        [pregnancy setHorizontalFrame];
    }
    myFrame = _content.frame;
}

-(void)setVerticalFrame
{
    [super setVerticalFrame];
    if (loginView==kLoginBirthRegisterView) {
        [birth setVerticalFrame];
    }
    if (kLoginPregnancyRegisterView) {
        [pregnancy setVerticalFrame];
    }
    myFrame = _content.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

	// Do any additional setup after loading the view.

}




- (void)keyboardWillShow:(NSNotification *)notif
{
    
    
    if (![MainTabBarController sharedMainViewController].isVertical) {
         CGRect kframe = myFrame;
        CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval animationDuration = [[[notif userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
       // if (loginView == kLoginLoadView ||loginView == kLoginEndView) {
            float height = rect.size.height>rect.size.width ?rect.size.width:rect.size.height;
            height = height - 272>0 ?height - 272 :0;
            
            kframe.origin.y = myFrame.origin.y-height;
            [UIView animateWithDuration:animationDuration animations:^{
                _content.frame = kframe;
            }];
      //  }
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notif
{
    if (![MainTabBarController sharedMainViewController].isVertical)
    {
        NSTimeInterval animationDuration = [[[notif userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
      //  if (loginView == kLoginLoadView ||loginView == kLoginEndView) {
            [UIView animateWithDuration:animationDuration animations:^{
                _content.frame = myFrame;
            }];
     //   }
       
    }
}

- (void)loginSetting
{
    [_closeBtn setImage:[UIImage imageNamed:@"btn_back_login.png"] forState:UIControlStateNormal];
    [_finishBtn setImage:[UIImage imageNamed:@"btn_next_login.png"] forState:UIControlStateNormal];
    [_closeBtn setAlpha:0];
    [_finishBtn setAlpha:0];
    if ([[UserInfo sharedUserInfo] logined]) {
        if ([[BabyData sharedBabyData] babyHasBorned])
        {
            [self initBirthRegisterView];
            [changeView setContentOffset:CGPointMake(kLoginsubViewWidth, 0)];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
            [_closeBtn setAlpha:1];
        }else{
            [self initStarLoginView];
            [_closeBtn setAlpha:1];

        }
    }else{
        [self initStarLoginView];
    }
   
    modifyMode = [UserInfo sharedUserInfo].logined;
    if (modifyMode)
    {
        [startView hideGoLoginBtn];
        [self setTitle:@"完善您的信息" withIcon:nil];
        [_finishBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
        [_closeBtn setImage:[UIImage imageNamed:@"btn_close1.png"] forState:UIControlStateNormal];
        
    }
}



- (void)closeBtnPressed
{
   
    LoginView nextView = loginView;
    switch (nextView) {
        case kLoginLoadView:
        {
            [_finishBtn setAlpha:0];
            if ([[UserInfo sharedUserInfo] logined])
            {
                [_closeBtn setAlpha:1];
            }else{
                [_closeBtn setAlpha:0];
            }
            loginView = kLoginStartView;
            [changeView scrollRectToVisible:startView.frame animated:YES];
            [loadView resigntextField];
        }
            break;
        case kLoginBirthRegisterView:
        {
           
            [birth resigntextField];
            if ([[UserInfo sharedUserInfo] logined])
            {
               
                if ([[BabyData sharedBabyData] babyHasBorned]) {
                     [super closeBtnPressed];
                }else{
                    [_finishBtn setAlpha:0];
                    [_closeBtn setAlpha:1];
                    loginView = kLoginStartView;
                    [changeView scrollRectToVisible:startView.frame animated:YES];
                }
                
            }else{
                [_finishBtn setAlpha:0];
                [_closeBtn setAlpha:0];
                loginView = kLoginStartView;
                [changeView scrollRectToVisible:startView.frame animated:YES];
            }
           
            
        }
            break;
        case kLoginPregnancyRegisterView:
        {
            [_finishBtn setAlpha:0];
            if ([[UserInfo sharedUserInfo] logined])
            {
                [_closeBtn setAlpha:1];
            }else{
                [_closeBtn setAlpha:0];
            }
            loginView = kLoginStartView;
            [changeView scrollRectToVisible:startView.frame animated:YES];
            [pregnancy resigntextField];
        }
            break;
        case kLoginEndView:
        {
            [_finishBtn setAlpha:1];
            [_closeBtn setAlpha:1];
            if (isBirthView) {
                loginView = kLoginBirthRegisterView;
                [changeView scrollRectToVisible:birth.frame animated:YES];
            }else
            {
                loginView = kLoginPregnancyRegisterView;
                [changeView scrollRectToVisible:pregnancy.frame animated:YES];
            }
            [endView resigntextField];
            [UIView animateWithDuration:0.5 animations:^{
                [protocolNotiView setAlpha:0];
            }];
        }
            break;
        case kLoginCodeView:
        {
            loginView = kLoginLoadView;
            [changeView scrollRectToVisible:loadView.frame animated:YES];
            [loginCode removeFromSuperview];
        }
            break;
        case kLoginStartView:
        {
            [super  closeBtnPressed];
        }
            break;
        default:
        {
            [_finishBtn setAlpha:0];
            [_closeBtn setAlpha:0];
            loginView = kLoginStartView;
            [changeView scrollRectToVisible:startView.frame animated:YES];
        }
            break;
    }
    

}

- (void)finishBtnPressed
{
    switch (loginView) {
        case kLoginBirthRegisterView:
        {
            [birth resigntextField];
                if (modifyMode)
                {
                    NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
                    [meta setValue:@"生日" forKey:uMeta_whetherBirth];
                    [meta setValue:[birth babyName] forKey:uMeta_nickName];
                    [meta setValue:[DateFormatter stringFromDate:[birth birthDate]] forKey:uMeta_birthDate];
                    if ([birth babyType] == kGenderBoy)
                        [meta setValue:@"男宝宝" forKey:uMeta_gender];
                    else if([birth babyType] == kGenderGirl)
                        [meta setValue:@"女宝宝" forKey:uMeta_gender];
                    if ([[UserInfo sharedUserInfo] uploadBabyMeta:meta])
                    {
                        [CustomNotiViewController showNotiWithTitle:@"修改成功" withTypeStyle:kNotiTypeStyleRight];
                        [super finishBtnPressed];
                    }
                    else
                    {
                         [CustomNotiViewController showNotiWithTitle:@"网络异常" withTypeStyle:kNotiTypeStyleRight];
                    }
                    return;
                }
                isBirthView = YES;
                [self initEndLoginView];
                endView.identity = birth.identity;
                endView.whetherBirth = YES;
                endView.babyName = [birth babyName];
                endView.birthDate = [birth birthDate];
                if ([birth babyType] == kGenderBoy)
                    endView.isBoy = YES;
                else if([birth babyType] == kGenderGirl)
                    endView.isBoy = NO;
                
                [changeView scrollRectToVisible:endView.frame animated:YES];
                [_finishBtn setAlpha:0];
                [_closeBtn setAlpha:1];
    }
            break;
        case kLoginPregnancyRegisterView:
        {
            [pregnancy resigntextField];
            
                if (modifyMode)
                {
                    NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
                    [meta setValue:@"预产期" forKey:uMeta_whetherBirth];
                    [meta setValue:[pregnancy babyName] forKey:uMeta_nickName];
                    [meta setValue:[DateFormatter stringFromDate:[pregnancy birthDate]] forKey:uMeta_birthDate];
                    if ([[UserInfo sharedUserInfo] uploadBabyMeta:meta])
                    {

                         [CustomNotiViewController showNotiWithTitle:@"修改成功" withTypeStyle:kNotiTypeStyleRight];
                        
                        [self hidden];
                    }
                    else
                    {
                         [CustomNotiViewController showNotiWithTitle:@"网络异常" withTypeStyle:kNotiTypeStyleRight];
                    }
                    return;
                }
                isBirthView = NO;
                [self initEndLoginView];
                endView.identity = pregnancy.identity;
                endView.whetherBirth = NO;
                endView.babyName = [pregnancy babyName];
                endView.birthDate = [pregnancy birthDate];
                [changeView scrollRectToVisible:endView.frame animated:YES];
                [_finishBtn setAlpha:0];
                [_closeBtn setAlpha:1];
           
        }
            break;
        default:
            break;
    }
}



- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}

- (void)finishOut
{
    [MyNotiCenter postNotificationName:Noti_BabyDataUpdated object:nil];
    [super dismiss];
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initStarLoginView
{
    loginView = kLoginStartView;
    startView = [[LoginStartView alloc] initWithFrame:CGRectMake(0, 0, kLoginsubViewWidth, kLoginsubViewHeight)];
    startView.delegate = self;
    [startView setBackgroundColor:[UIColor clearColor]];
    [changeView addSubview:startView];
}

- (void)selectLoginView:(LoginView)login
{
    
    switch (login) {
        case kLoginLoadView:
            [self initLoginLoadView];
            [changeView scrollRectToVisible:loadView.frame animated:YES];
            [_finishBtn setAlpha:0];
            [_closeBtn setAlpha:1];
            break;
        case kLoginBirthRegisterView:
            [self initBirthRegisterView];
            switch (startView.relation) {
                case Relate_father:
                    birth.identity = Father;
                    break;
                default:
                    birth.identity = Mother;
                    break;
            }
            [changeView scrollRectToVisible:birth.frame animated:YES];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
            [_closeBtn setAlpha:1];
            break;
        case kLoginPregnancyRegisterView:
            [self initPregnancyRegisterView];
            switch (startView.relation) {
                case Relate_father:
                    pregnancy.identity = Father;
                    break;
                default:
                    pregnancy.identity = Mother;
                    break;
            }
            [changeView scrollRectToVisible:pregnancy.frame animated:YES];
            [_finishBtn setAlpha:0.5];
            [_finishBtn setEnabled:NO];
            [_closeBtn setAlpha:1];
            break;
        default:
            break;
    }
    
}

- (void)initLoginLoadView
{
    loginView = kLoginLoadView;
    if (!loadView) {
        loadView = [[LoginEndView alloc] initWithFrame:CGRectMake(kLoginsubViewWidth, 0, kLoginsubViewWidth, kLoginsubViewHeight)];
    }
    [loadView setDelegate:self];
    [loadView theViewIsEndView:NO];
    [birth setAlpha:0];
    [loadView setAlpha:1];
    [pregnancy setAlpha:0];
    [loadView setBackgroundColor:[UIColor clearColor]];
    [changeView addSubview:loadView];
   
}

- (void)initBirthRegisterView
{
    loginView = kLoginBirthRegisterView;
    if (!birth) {
        birth = [[LoginBirthRegisterView alloc] initWithFrame:CGRectMake(kLoginsubViewWidth, 0, kLoginsubViewWidth, kLoginsubViewHeight)];
        [birth setDelegate:self];
        
    }
    loginView =kLoginBirthRegisterView;
    [birth setAlpha:1];
    [loadView setAlpha:0];
    [pregnancy setAlpha:0];
    [birth setBackgroundColor:[UIColor clearColor]];
    [changeView addSubview:birth];
}

- (void)initPregnancyRegisterView
{
    loginView = kLoginPregnancyRegisterView;
    if (!pregnancy) {
        pregnancy = [[LoginPregnancyView alloc] initWithFrame:CGRectMake(kLoginsubViewWidth, 0, kLoginsubViewWidth, kLoginsubViewHeight)];
        [pregnancy setDelegate:self];
    }
    [birth setAlpha:0];
    [loadView setAlpha:0];
    [pregnancy setAlpha:1];
    [pregnancy setBackgroundColor:[UIColor clearColor]];
    [changeView addSubview:pregnancy];
}

- (void)initEndLoginView
{
    loginView = kLoginEndView;
    if (!endView) {
        endView = [[LoginEndView alloc] initWithFrame:CGRectMake(kLoginsubViewWidth*2, 0, kLoginsubViewWidth, kLoginsubViewHeight)];
        
    }
    [endView setAlpha:1];
    [endView theViewIsEndView:YES];
    [endView setBackgroundColor:[UIColor clearColor]];
    [changeView addSubview:endView];
    [UIView animateWithDuration:0.5 animations:^{
        [protocolNotiView setAlpha:1];
    }];
    
    
}

- (void)forget
{
    if (endView) {
        [endView setAlpha:0];
    }
    loginView = kLoginCodeView;
    if (loginCode) {
        [loginCode removeFromSuperview];
    }
    loginCode = [[LoginCodeView alloc] initWithFrame:CGRectMake(kLoginsubViewWidth*2, 0, kLoginsubViewWidth, kLoginsubViewHeight)];
    [changeView addSubview:loginCode];
    [changeView scrollRectToVisible:loginCode.frame animated:YES];
    
}

- (void)initProtocolNotiView
{
    
    protocolNotiView = [[UIView alloc] initWithFrame:CGRectMake(192, 568, 320, 32)];
    [_content addSubview:protocolNotiView];
    [protocolNotiView setBackgroundColor:[UIColor clearColor]];
    
    NSString *str = @"点击注册按钮即表示您已经阅读并同意";
    CGSize size = [str sizeWithFont:PMFont3];
    UILabel *noti = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 32)];
    [noti setText:str];
    [noti setTextColor:PMColor2];
    [noti setFont:PMFont3];
    [noti setBackgroundColor:[UIColor clearColor]];
    [protocolNotiView addSubview:noti];
    
    UIButton  *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width, 0, 160, 32)];
    [protocolNotiView addSubview:detailBtn];
    [detailBtn addTarget:self action:@selector(detailProtcol) forControlEvents:UIControlEventTouchUpInside];
    UILabel *noti_pro = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 32)];
    [noti_pro setText:@"《扑满日记服务协议》"];
    [noti_pro setTextColor:PMColor6];
    [noti_pro setFont:PMFont3];
    [noti_pro setBackgroundColor:[UIColor clearColor]];
    [detailBtn addSubview:noti_pro];
    [protocolNotiView setAlpha:0];
    
}

- (void)detailProtcol
{
    
    ProtocalPuumanViewController *protocal = [[ProtocalPuumanViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:protocal.view];
    [protocal setControlBtnType:kOnlyCloseButton];
    [protocal setTitle:@"扑满日记用户协议" withIcon:nil];
    [protocal show];
    [endView resigntextField];
}

- (void)loginSucceed
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super finishBtnPressed];
}

- (void)isFinished
{
    [_finishBtn setAlpha:1];
    [_finishBtn setEnabled:YES];
}

- (void)unFinished
{
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
}
@end
