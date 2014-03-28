//
//  CallingView.m
//  puman
//
//  Created by 祁文龙 on 13-12-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "CallingView.h"

@implementation CallingView

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
    bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [bgImgView setImage:[UIImage imageNamed:@"pic13_insure_shop.png"]];
    [self addSubview:bgImgView];
    cloud = [[UIImageView alloc] initWithFrame:CGRectMake(64, 32, 211, 134)];
    [cloud setImage:[UIImage imageNamed:@"pic14_insure_shop.png"]];
    [self addSubview:cloud];
    phoneBg= [[UIImageView alloc] initWithFrame:CGRectMake(50, 52, 97, 56)];
    [phoneBg setImage:[UIImage imageNamed:@"pic15_insure_shop.png"]];
    [cloud addSubview:phoneBg];
    phone = [[UIImageView alloc] initWithFrame:CGRectMake(50, 30, 98, 27)];
    [phone setImage:[UIImage imageNamed:@"pic16_insure_shop.png"]];
    [cloud addSubview:phone];
    
    [self animate];
     aniTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(animate) userInfo:nil repeats:YES];

}
- (void)animate
{
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 0.5;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [phone layer].position.x, [phone layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [phone layer].position.x, [phone layer].position.y, [phone layer].position.x,[phone layer].position.y-10);
    positionAnimation.path = positionPath;
  
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:-0.1];
    shake.toValue = [NSNumber numberWithFloat:+0.1];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 5;
    shake.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [shake setBeginTime:0.5];
    

    
    CAKeyframeAnimation *positionAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation2.fillMode = kCAFillModeForwards;
    positionAnimation2.removedOnCompletion =NO;
    positionAnimation2.duration = 0.5;
     CGMutablePathRef positionPath2 = CGPathCreateMutable();
    positionAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation2 setBeginTime:1.5];
    CGPathMoveToPoint(positionPath2, NULL, [phone layer].position.x, [phone layer].position.y-10);
    CGPathAddQuadCurveToPoint(positionPath2, NULL, [phone layer].position.x, [phone layer].position.y-10, [phone layer].position.x,[phone layer].position.y);
    positionAnimation2.path = positionPath2;
    
    CAAnimationGroup*group = [CAAnimationGroup animation];
    [group  setDuration:4];
    [group setAnimations:[NSArray arrayWithObjects:positionAnimation, shake,positionAnimation2, nil]];
    [phone.layer addAnimation:group forKey:nil];
     CGPathRelease(positionPath);
    CGPathRelease(positionPath2);
    
}
- (void)remove
{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
