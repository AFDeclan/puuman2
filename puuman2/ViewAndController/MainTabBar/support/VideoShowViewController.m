//
//  VideoShowViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoShowViewController.h"
#import "UniverseConstant.h"

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
    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, -768, 1024, 768)];
    [videoView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:videoView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showVideoView
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [videoView layer].position.x, [videoView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [videoView layer].position.x, [videoView layer].position.y, [videoView layer].position.x,[videoView layer].position.y+768);
    positionAnimation.path = positionPath;
    [videoView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(videoView, 0, 0);
}

@end
