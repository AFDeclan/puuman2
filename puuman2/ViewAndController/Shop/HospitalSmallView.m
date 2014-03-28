//
//  HospitalSmallView.m
//  puman
//
//  Created by 祁文龙 on 13-12-12.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HospitalSmallView.h"
#define speedLeftCloud 20
#define speedRightCloud 30
#define speedSpider 40
@implementation HospitalSmallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    bgImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgImgView1 setImage:[UIImage imageNamed:@"pic7_insure_shop.png"]];
    [self addSubview:bgImgView1];
    
    leftCloudView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 12, 160, 100)];
    [leftCloudView setImage:[UIImage imageNamed:@"pic8_insure_shop.png"]];
    [self addSubview:leftCloudView];
    
    rightCloudView = [[UIImageView alloc] initWithFrame:CGRectMake(440, 16, 98, 60)];
    [rightCloudView setImage:[UIImage imageNamed:@"pic9_insure_shop.png"]];
    [self addSubview:rightCloudView];
    
    bgImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(76, 76, 489, 247)];
    [bgImgView2 setImage:[UIImage imageNamed:@"pic12_insure_shop.png"]];
    [self addSubview:bgImgView2];

    insureView = [[UIImageView alloc] initWithFrame:CGRectMake(223, 53, 75, 69)];
    [insureView setImage:[UIImage imageNamed:@"pic10_insure_shop.png"]];
    [insureView.layer setAnchorPoint:CGPointMake(0.6, 1)];
    [self addSubview:insureView];
    spiderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(180, 152, 14, 83)];
    [spiderScrollView setContentSize:CGSizeMake(14,83*2)];
    [spiderScrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:spiderScrollView];
    
    UIImageView *spider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 83)];
    [spider setImage:[UIImage imageNamed:@"pic11_insure_shop.png"]];
    [spiderScrollView addSubview:spider];
    [self animateWithLeftCloud];
    [self animateWithRightCloud];
    [self animateWithSpiderUp];
    [self performSelector:@selector(animationDidWithInsureView) withObject:nil afterDelay:2];
}
- (void)animationDidWithInsureView
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [insureView layer].position.x, [insureView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [insureView layer].position.x, [insureView layer].position.y, [insureView layer].position.x,321);
    positionAnimation.path = positionPath;
   
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fillMode = kCAFillModeForwards;
    shake.removedOnCompletion = NO;
    shake.duration = 0.5;
    shake.toValue = [NSNumber numberWithFloat:0.5];
    shake.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [shake setBeginTime:1];
    
    CAAnimationGroup*group = [CAAnimationGroup animation];
    group.removedOnCompletion = NO;
    [group  setDuration:3];
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:[NSArray arrayWithObjects:shake, positionAnimation, nil]];
    [insureView.layer addAnimation:group forKey:nil];
    CGPathRelease(positionPath);
    
}


- (void)animateWithSpiderUp
{
    CGRect  frame = spiderScrollView.frame;
    CGPoint pos = spiderScrollView.contentOffset;
    float length = random()%(int)(frame.size.height-14 - pos.y);
    pos.y = pos.y + length;
    [UIView animateWithDuration:length/speedSpider animations:^{
        spiderScrollView.contentOffset = pos;
    } completion:^(BOOL finished) {
         [self performSelector:@selector(animateWithSpiderDown) withObject:nil afterDelay:1];
       
    }];
    
}

- (void)animateWithSpiderDown
{
    
    CGPoint pos = spiderScrollView.contentOffset;
    float length = random()%(int)(pos.y);
    pos.y = pos.y- length;
    [UIView animateWithDuration:length/speedSpider animations:^{
        spiderScrollView.contentOffset = pos;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(animateWithSpiderUp) withObject:nil afterDelay:1.5];
       
    }];
}
- (void)animateWithLeftCloud
{
    CGRect frame = leftCloudView.frame;

    float length = frame.origin.x +frame.size.width;
    frame.origin.x = -frame.size.width;
    [UIView animateWithDuration:length/speedLeftCloud
                     animations:^{
                         [leftCloudView setFrame:frame];
                     } completion:^(BOOL finished) {
                         CGRect frame2 = frame;
                         frame2.origin.x = 640;
                         [leftCloudView setFrame:frame2];
                         [self animateWithLeftCloud];
                     }];
}
- (void)animateWithRightCloud
{
    CGRect frame = rightCloudView.frame;
    
    float length = frame.origin.x +frame.size.width;
    frame.origin.x = -frame.size.width;
    [UIView animateWithDuration:length/speedRightCloud
                     animations:^{
                         [rightCloudView setFrame:frame];
                     } completion:^(BOOL finished) {
                         CGRect frame2 = frame;
                         frame2.origin.x = 640;
                         [rightCloudView setFrame:frame2];

                         [self animateWithRightCloud];
                     }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)stopAni
{

    
}
@end
