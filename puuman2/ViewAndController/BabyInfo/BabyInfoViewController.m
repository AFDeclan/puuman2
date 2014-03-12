//
//  BabyInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoViewController.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"

@interface BabyInfoViewController ()

@end

@implementation BabyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [MyNotiCenter addObserver:self selector:@selector(updateBabyDate) name:Noti_BabyDataUpdated object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialization];
      [self.view setBackgroundColor:[UIColor clearColor]];
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];

}

- (void)initialization
{
    bgImageView = [[UIImageView alloc] init];
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bgImageView];
    babyInfoView = [[BabyInfoView alloc] initWithFrame:CGRectMake(80, 0, 540, 160)];
    [babyInfoView resetBabyInfo];
    [self.view addSubview:babyInfoView];
    
    modifyBtn = [[ColorButton alloc] init];
    [modifyBtn initWithTitle:@"修改" andIcon:[UIImage imageNamed:@"icon_fix_baby.png"] andButtonType:kGrayLeft];
    [modifyBtn addTarget:self action:@selector(moadifyBabyInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyBtn];
}



- (void)viewWillAppear:(BOOL)animated
{
   
}

//竖屏
-(void)setVerticalFrame
{
    SetViewLeftUp(modifyBtn, 640, 40);
    SetViewLeftUp(babyInfoView, 114, 16);
    [bgImageView setFrame:CGRectMake(80, 16, 672, 992)];
    [bgImageView setImage:[UIImage imageNamed:@"paper_baby.png"]];
}

//横屏
-(void)setHorizontalFrame
{
    SetViewLeftUp(modifyBtn, 896, 40);
    SetViewLeftUp(babyInfoView, 242, 16);
    [bgImageView setFrame:CGRectMake(80, 16, 928, 736)];
    [bgImageView setImage:[UIImage imageNamed:@"paper_h_baby.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moadifyBabyInfo
{
    LoginViewController *modifyInfoVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:modifyInfoVC.view];
    [modifyInfoVC setControlBtnType:kCloseAndFinishButton];
    [modifyInfoVC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [modifyInfoVC loginSetting];
    [modifyInfoVC show];

}

- (void)updateBabyDate
{
    [babyInfoView resetBabyInfo];
}

@end
