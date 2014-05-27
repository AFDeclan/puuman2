//
//  VideoShowViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowViewController.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"
#import "ShareSelectedViewController.h"

@interface VideoShowViewController ()

@end

@implementation VideoShowViewController
@synthesize delegate = _delegate;
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
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, -768, 1024, 768)];
    contentView.backgroundColor = [UIColor blueColor];
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
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(240, 320, 128, 128);
    [shareBtn setImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:shareBtn];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(690, 320, 128, 128);
    [closeBtn setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnPressed)forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:closeBtn];


}

- (void)share
{
    [ShareSelectedViewController shareText:nil title:nil image:nil];
}

 -(void)closeBtnPressed
{
    [_delegate closeShowVideo];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showVideoView
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    positionAnimation.fillMode = kCAFillModeForwards;
//    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [contentView layer].position.x, [contentView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [contentView layer].position.x, [contentView layer].position.y, [contentView layer].position.x,[contentView layer].position.y+768);
    positionAnimation.path = positionPath;
    [contentView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(contentView, 0, 0);
    
}

@end
