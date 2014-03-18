//
//  CustomNotiViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomNotiViewController.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"

@interface CustomNotiViewController ()

@end

@implementation CustomNotiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)initNoti
{
    notiView  = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 106, 106)];
    [notiView setBackgroundImage:[UIImage imageNamed:@"circle_status.png"] forState:UIControlStateNormal];
    [notiView setEnabled:NO];
    [_content setFrame:CGRectMake(0, 0, 106, 106)];
    [bgView setAlpha:0];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
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

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(160, 384, 448, 256)];
    SetViewLeftUp(_content, 331, 459);
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(288, 256, 448, 256)];
    SetViewLeftUp(_content, 459, 331);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showNotiWithTitle:(NSString *)title withTypeStyle:(TypeStyle)style
{
    CustomNotiViewController *alert  = [[CustomNotiViewController alloc] initWithNibName:nil bundle:nil];
    [alert initWithTitle:title andStyle:style];
    [[MainTabBarController sharedMainViewController].view addSubview:alert.view];
    [alert show];
    
}
- (void)initWithTitle:(NSString *)title andStyle:(TypeStyle)typeStyle
{
    switch (typeStyle) {
        case kTypeStyleError:
            [notiView setTitle:title andImg:[UIImage imageNamed:@"check_status.png"] andButtonType:kButtonTypeFive];
            break;
        case kTypeStyleRight:
            [notiView setTitle:title andImg:[UIImage imageNamed:@"check_status.png"] andButtonType:kButtonTypeFive];
            break;
        case kTypeStyleNone:
            [notiView setTitle:title andImg:nil andButtonType:kButtonTypeTwo];
            [notiView setBackgroundColor:[UIColor clearColor]];
            break;
        default:
            break;
    }
   
    
}



- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hidden) userInfo:nil repeats:NO];

}
@end
