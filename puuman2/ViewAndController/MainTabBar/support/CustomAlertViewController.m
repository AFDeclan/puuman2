//
//  CustomAlertViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomAlertViewController.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"


@interface CustomAlertViewController ()

@end

@implementation CustomAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 448, 256)];
        [bgImgView setImage:[UIImage imageNamed:@"bg_prompt.png"]];
        [_content addSubview:bgImgView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 96, 448, 48)];
        [_titleLabel setTextColor:PMColor2];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:PMFont2];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:_titleLabel];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)showWithTitle:(NSString *)title
{
    [_titleLabel setText:title];
    [self show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(160, 384, 448, 256)];
    
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
     [_content setFrame:CGRectMake(288, 256, 448, 256)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setStyle:(AlertStyle)style
{
    _style = style;
    switch (style) {
        case ConfirmRight:
            [self initFinishBtn];
            break;
        case ConfirmError:
            [self initCloseBtn];
            break;
        case Question:
            [self initCloseAndFinishBtn];
            break;
        default:
            break;
    }
}

- (void)initCloseAndFinishBtn
{
    _closeBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 192, 224, 64)];
    [_closeBtn.title setText:@"取消"];
    [_closeBtn.title setTextColor:PMColor8];
    [_closeBtn.title setFont:PMFont1];
    [_closeBtn setIconImg:[UIImage imageNamed:@"btn_close2.png"]];
    [_closeBtn setIconSize:CGSizeMake(32, 32)];
    [_closeBtn adjustLayout];
    [_closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_closeBtn];
    
    _finishBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(224, 192, 224, 64)];
    [_finishBtn.title setText:@"确定"];
    [_finishBtn.title setTextColor:PMColor6];
    [_finishBtn.title setFont:PMFont1];
    [_finishBtn setIconImg:[UIImage imageNamed:@"btn_finish2.png"]];
    [_finishBtn setIconSize:CGSizeMake(32, 32)];
    [_finishBtn adjustLayout];
    [_finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_finishBtn];
    
}

- (void)initCloseBtn
{
    _closeBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 192, 448, 64)];
    [_closeBtn.title setText:@"取消"];
    [_closeBtn.title setTextColor:PMColor8];
    [_closeBtn.title setFont:PMFont1];
    [_closeBtn setIconImg:[UIImage imageNamed:@"btn_close2.png"]];
    [_closeBtn setIconSize:CGSizeMake(32, 32)];
    [_closeBtn adjustLayout];
    [_closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_closeBtn];
}

- (void)initFinishBtn
{
    _finishBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 192, 448, 64)];
    [_finishBtn.title setText:@"确定"];
    [_finishBtn.title setTextColor:PMColor6];
    [_finishBtn.title setFont:PMFont1];
    [_finishBtn setIconImg:[UIImage imageNamed:@"btn_finish2.png"]];
    [_finishBtn setIconSize:CGSizeMake(32, 32)];
    [_finishBtn adjustLayout];
    [_finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_finishBtn];
}

- (void)closeBtnPressed
{
    if (self.cancelHandler) self.cancelHandler();
    [self hidden];
}

- (void)finishBtnPressed
{
    if (self.confirmHandler) self.confirmHandler();
    [self hidden];
}

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
}

- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
    [self.view removeFromSuperview];
}

+ (void)showAlertWithTitle:(NSString *)title confirmHandler:(CustomAlertViewHandler)confirm cancelHandler:(CustomAlertViewHandler)cancel fromViewController:(UIViewController *)viewController
{
    CustomAlertViewController *alert  = [[CustomAlertViewController alloc] initWithNibName:nil bundle:nil];
    [alert setStyle:Question];
    alert.confirmHandler = confirm;
    alert.cancelHandler = cancel;
    [viewController.view addSubview:alert.view];
    [alert showWithTitle:title];
}

+ (void)showAlertWithTitle:(NSString *)title confirmErrorHandler:(CustomAlertViewHandler)confirm fromViewController:(UIViewController *)viewController
{
    CustomAlertViewController *alert  = [[CustomAlertViewController alloc] initWithNibName:nil bundle:nil];
    [alert setStyle:ConfirmError];
    alert.confirmHandler = nil;
    alert.cancelHandler = confirm;
    [viewController.view addSubview:alert.view];
    [alert showWithTitle:title];
}

+ (void)showAlertWithTitle:(NSString *)title confirmRightHandler:(CustomAlertViewHandler)confirm fromViewController:(UIViewController *)viewController
{
    CustomAlertViewController *alert  = [[CustomAlertViewController alloc] initWithNibName:nil bundle:nil];
    [alert setStyle:ConfirmRight];
    alert.confirmHandler = confirm;
    alert.cancelHandler = nil;
    [viewController.view addSubview:alert.view];
    [alert showWithTitle:title];
}


+ (void)showAlertWithTitle:(NSString *)title confirmHandler:(CustomAlertViewHandler)confirm cancelHandler:(CustomAlertViewHandler)cancel
{
    [self showAlertWithTitle:title confirmHandler:confirm cancelHandler:cancel fromViewController:[MainTabBarController sharedMainViewController]];
}

+ (void)showAlertWithTitle:(NSString *)title confirmErrorHandler:(CustomAlertViewHandler)confirm
{
    [self showAlertWithTitle:title confirmErrorHandler:confirm fromViewController:[MainTabBarController sharedMainViewController]];
}

+ (void)showAlertWithTitle:(NSString *)title confirmRightHandler:(CustomAlertViewHandler)confirm
{
    [self showAlertWithTitle:title confirmRightHandler:confirm fromViewController:[MainTabBarController sharedMainViewController]];
}
@end
