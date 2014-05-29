//
//  VideoManageView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VideoManageView.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"


@implementation VideoManageView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 1024, 768)];
}

- (void)initialization
{
    AnimateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    AnimateView.backgroundColor = [UIColor clearColor];
    [self addSubview:AnimateView];
    
    shareView = [[UIView alloc] initWithFrame:CGRectMake(180, 768, 270, 190)];
    [shareView setBackgroundColor:[UIColor clearColor]];
    [AnimateView addSubview:shareView];
    closeView =[[UIView alloc] initWithFrame:CGRectMake(640, 768, 270, 190)];
    [closeView setBackgroundColor:[UIColor clearColor]];
    [AnimateView addSubview:closeView];
    
    mainLab = [[UILabel alloc] initWithFrame:CGRectMake(408,216, 215, 25)];
    mainLab.text = @"您觉得这段视频......";
    mainLab.textColor = [UIColor whiteColor];
    [mainLab setFont:[UIFont fontWithName:nil size:25.0f]];
    [AnimateView addSubview:mainLab];
    [mainLab setAlpha:0];
    
    UILabel *subLab1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 200, 270, 40)];
    subLab1.text = @"太赞了，必须分享";
    subLab1.textColor = [UIColor whiteColor];
    [subLab1 setFont:[UIFont fontWithName:nil size:30.0f]];
    [shareView  addSubview:subLab1];
    
    UILabel *subLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 270, 40)];
    subLab.text = @"太丑了，马上销毁";
    subLab.textColor = [UIColor whiteColor];
    [subLab setFont:[UIFont fontWithName:nil size:30.0f]];
    [closeView addSubview:subLab];
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    shareBtn.frame = CGRectMake(60, 0, 128, 128);
    [shareBtn setImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:shareBtn];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    closeBtn.frame = CGRectMake(60, 0, 128, 128);
    [closeBtn setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnPressed)forControlEvents:UIControlEventTouchUpInside];
    [closeView addSubview:closeBtn];
}

-(void)showShareView{
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 0.9;
    CGMutablePathRef positionPath =CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [shareView layer].position.x, [shareView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [shareView layer].position.x, [shareView layer].position.y, [shareView layer].position.x, [shareView layer].position.y-768+320);
    positionAnimation.path = positionPath;
    [shareView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(shareView, 180, 320);
    
}
-(void)showCloseView{
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [closeView layer].position.x, [closeView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [closeView layer].position.x, [closeView layer].position.y, [closeView layer].position.x, [closeView layer].position.y-768+320);
    positionAnimation.path = positionPath;
    [closeView.layer addAnimation:positionAnimation forKey:@"position"];
    SetViewLeftUp(closeView, 640, 320);
    
}

- (void)showAnimate
{
    [UIView animateWithDuration:0.6 animations:^{
        [mainLab setAlpha:1];
    }];
    [self showShareView];
    [self showCloseView];
}

- (void)share
{
    ShareSelectedViewController *shareVC = [[ShareSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [self addSubview:shareVC.view];
    [shareVC setShareText:nil];
    [shareVC setShareTitle:nil];
    [shareVC setShareImg:nil];
    [shareVC setStyle:ConfirmError];
    shareVC.delegate = self;
    [shareVC show];
    //[ShareSelectedViewController shareText:nil title:nil image:nil];
    [_delegate shareVideo];
}

- (void)popViewfinished
{

}

-(void)closeBtnPressed
{
    [_delegate deleteVideo];
}

@end
