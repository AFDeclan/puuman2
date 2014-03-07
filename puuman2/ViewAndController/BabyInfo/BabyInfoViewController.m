//
//  BabyInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"

@interface BabyInfoViewController ()

@end

@implementation BabyInfoViewController

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
      [self.view setBackgroundColor:[UIColor clearColor]];
	// Do any additional setup after loading the view.
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:login.view];
      [login setControlBtnType:kCloseAndFinishButton];
    [login setTitle:@"欢迎使用扑满日记！" withIcon:nil];
   [login loginSetting];
    [login show];
}

- (void)viewWillAppear:(BOOL)animated
{
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
