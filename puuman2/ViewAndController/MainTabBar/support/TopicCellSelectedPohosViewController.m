//
//  TopicCellSelectedPohosViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicCellSelectedPohosViewController.h"

#import "MainTabBarController.h"


@interface TopicCellSelectedPohosViewController ()

@end

@implementation TopicCellSelectedPohosViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)importBtnPressed
{
    NewImportDiaryViewController  *popView = [[NewImportDiaryViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:popView.view];
    [popView setControlBtnType:kCloseAndFinishButton];
    [popView setTitle:@"传照片" withIcon:[UIImage imageNamed:@"icon_input_diary.png"]];
    [popView setIsTopic:YES];
    [popView setDelegate:self];
    [popView show];
    [self hidden];
    

}

- (void)takePicBtnPressed
{
    NewCameraViewController  *popView = [[NewCameraViewController alloc] initWithNibName:nil bundle:nil];
    [popView setCameraModel:YES];
    [popView setDelegate:self];
    [[MainTabBarController sharedMainViewController] presentModalViewController:popView animated:YES];
    [popView setIsTopic:YES];
    [self hidden];
 
}

- (void)cameraViewHidden
{
   [self hidden];
}

- (void)popViewfinished
{
    [self hidden];
}
@end
