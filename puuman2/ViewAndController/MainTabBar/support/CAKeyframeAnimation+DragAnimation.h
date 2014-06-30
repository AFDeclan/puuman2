//
//  CAKeyframeAnimation+DragAnimation.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-5.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (DragAnimation)
+ (void)dragAnimationWithView:(UIView *)view andDargPoint:(CGPoint)pos;
@end
