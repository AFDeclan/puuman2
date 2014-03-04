//
//  BabyInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoViewController.h"

#import "AppDelegate.h"
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

    
}

- (void)viewWillAppear:(BOOL)animated
{
   
    popView = [[NewTextViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:popView.view];
    [popView setControlBtnType:kCloseAndFinishButton];
    [popView setTitle:@"录声音" withIcon:[UIImage imageNamed:@"icon_info_diary.png"]];
    [popView show];
}
- (void)viewDidDisappear:(BOOL)animated
{

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
