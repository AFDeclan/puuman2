//
//  CAKeyframeAnimation+DragAnimation.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-5.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "CAKeyframeAnimation+DragAnimation.h"

@implementation CAKeyframeAnimation (DragAnimation)
+ (CAKeyframeAnimation *)dragAnimationWithView:(UIView *)view andDargPoint:(CGPoint)pos
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    positionAnimation.fillMode = kCAFillModeForwards;
    //    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [positionAnimation setBeginTime:0];
    CGPathMoveToPoint(positionPath, NULL, [view layer].position.x, [view layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [view layer].position.x, [view layer].position.y, [view layer].position.x +pos.x,[view layer].position.y+pos.y);
    positionAnimation.path = positionPath;
    [view.layer addAnimation:positionAnimation forKey:@"position"];
    return positionAnimation;
}

@end
