//
//  VideoShowViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowViewController.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"
#import "ShareSelectedViewController.h"

@interface VideoShowViewController ()

@end

@implementation VideoShowViewController

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
    [self initialization];
    // Do any additional setup after loading the view.
}

-(void)initialization{
    
    contentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    contentView.backgroundColor = [UIColor greenColor];
    [contentView setAlpha:0.5];
    [self.view addSubview:contentView];
    UILabel *mainLab = [[UILabel alloc] initWithFrame:CGRectMake(408,216, 215, 25)];
    mainLab.text = @"您觉得这段视频......";
    mainLab.textColor = [UIColor whiteColor];
    [mainLab setFont:[UIFont fontWithName:nil size:25.0f]];
    [contentView addSubview:mainLab];
    UILabel *subLab1 = [[UILabel alloc] initWithFrame:CGRectMake(180, 480, 270, 40)];
    subLab1.text = @"太赞了，必须分享";
    subLab1.textColor = [UIColor whiteColor];
    [subLab1 setFont:[UIFont fontWithName:nil size:30.0f]];
    [contentView addSubview:subLab1];
    UILabel *subLab = [[UILabel alloc]initWithFrame:CGRectMake(640, 480, 270, 40)];
    subLab.text = @"太丑了，马上销毁";
    subLab.textColor = [UIColor whiteColor];
    [subLab setFont:[UIFont fontWithName:nil size:30.0f]];
    [contentView addSubview:subLab];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(240, 320, 128, 128);
    [btn1 setImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 100;
    [contentView addSubview:btn1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(690, 320, 128, 128);
    [btn setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    btn.tag= 101;
    [contentView addSubview:btn];


}

-(void)btnClick:(id)sender{
    
    UIButton *button = sender;
    if(button.tag == 100){
        
        [ShareSelectedViewController shareText:nil title:nil image:nil];
        
    }else if(button.tag == 101){
        
         
    }
    
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
