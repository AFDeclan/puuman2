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
        notiType = kNotiTypeStyleNone;
        [self initNoti];
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
    [_content setFrame:CGRectMake(0, 0, 106, 106)];
    notiView  = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 106, 106)];
    [notiView setBackgroundImage:[UIImage imageNamed:@"circle_status.png"] forState:UIControlStateNormal];
    [notiView setEnabled:NO];
    [notiView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:notiView];
    [notiView unSelectedButton];
  
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
        [bgView setBackgroundColor:[UIColor clearColor]];
        [_content setBackgroundColor:[UIColor clearColor]];
        [self.view setBackgroundColor:[UIColor clearColor]];

}

- (void)hidden
{
 
    [_content hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
    [self.view removeFromSuperview];
}

- (void)setVerticalFrame
{

    self.view.frame = CGRectMake(331, 459, 106, 106);

}

- (void)setHorizontalFrame
{
  
    self.view.frame = CGRectMake(459, 331, 106, 106);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showNotiWithTitle:(NSString *)title withTypeStyle:(NotiTypeStyle)style
{
    CustomNotiViewController *alert  = [[CustomNotiViewController alloc] initWithNibName:nil bundle:nil];
    [alert initWithTitle:title andStyle:style];
    [[MainTabBarController sharedMainViewController].view addSubview:alert.view];
    [alert show];
    
}

- (void)initWithTitle:(NSString *)title andStyle:(NotiTypeStyle)typeStyle
{
    [notiView.title setText:title];
    [notiView.title setFont:PMFont2];
    [notiView.title setTextColor:[UIColor whiteColor]];
    [notiView setBackgroundColor:[UIColor clearColor]];

    switch (typeStyle) {
        case kNotiTypeStyleRight:
        {
            [notiView setBackgroundColor:[UIColor whiteColor]];
            [notiView setIconImg:[UIImage imageNamed:@"check_status.png"]];
        }
          
            break;
        case kNotiTypeStyleNone:
        {
            [notiView setIconImg:nil];
            [notiView setBackgroundColor:PMColor5];

        }
            break;
        default:
            break;
    }
    [notiView adjustLayout];
    
}



- (void)show
{
    [bgView setBackgroundColor:[UIColor clearColor]];
    [_content setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hidden) userInfo:nil repeats:NO];

}
@end
