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
#import "DiaryFileManager.h"
#import "CAKeyframeAnimation+DragAnimation.h"

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
    
    shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"shareVideo.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnPressed)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];

    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setImage:[UIImage imageNamed:@"saveVideo.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnPressed)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveBtn];

    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"deleteVideo.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnPressed)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    shareBtn.frame = CGRectMake(194, 768, 128, 170);

    saveBtn.frame = CGRectMake(448, 768, 128, 170);

    closeBtn.frame = CGRectMake(702, 768, 128, 170);


    mainLab = [[UILabel alloc] initWithFrame:CGRectMake(408,216, 215, 25)];
    mainLab.text = @"您觉得这段视频......";
    mainLab.textColor = [UIColor whiteColor];
    [mainLab setFont:[UIFont fontWithName:nil size:25.0f]];
    [self addSubview:mainLab];
    [mainLab setAlpha:0];

}

- (void)showAnimate
{
    [UIView animateWithDuration:0.6 animations:^{
        [mainLab setAlpha:1];
    }];
    [CAKeyframeAnimation dragAnimationWithView:shareBtn andDargPoint:CGPointMake(0, -450) andDelegate:nil andDuration:0.9];
    SetViewLeftUp(shareBtn, 194, 318);

    [CAKeyframeAnimation dragAnimationWithView:saveBtn andDargPoint:CGPointMake(0, -450) andDelegate:nil andDuration:0.95];
    SetViewLeftUp(saveBtn, 448, 318);
    
    [CAKeyframeAnimation dragAnimationWithView:closeBtn andDargPoint:CGPointMake(0, -450) andDelegate:nil andDuration:1.0];
    SetViewLeftUp(closeBtn, 702, 318);

}

- (void)shareBtnPressed
{
    [_delegate shareVideo];

}

- (void)saved
{
    [saveBtn setEnabled:NO];

}

- (void)saveBtnPressed
{
    [saveBtn setEnabled:NO];

    [_delegate saveVideo];
}

-(void)closeBtnPressed
{
    [_delegate deleteVideo];
}

@end
