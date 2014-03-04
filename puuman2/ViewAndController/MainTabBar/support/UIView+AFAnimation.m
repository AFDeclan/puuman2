//
//  UIView+AFAnimation.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "UIView+AFAnimation.h"

@implementation UIView (AFAnimation)
- (void)showInFrom:(AFAnimationDirection)direction inView:(UIView*)enclosingView withFade:(BOOL)fade duration:(NSTimeInterval)duration delegate:(id)delegate
     startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
    CAAnimation *backInAnim = [[AFAnimationManager sharedManager] showInAnimationFor:self withFade:fade direction:direction inView:enclosingView
																			duration:duration delegate:delegate
																	   startSelector:startSelector stopSelector:stopSelector];
	[self.layer addAnimation:backInAnim forKey:kAFAnimationShowIn];

}

- (void)hiddenOutTo:(AFAnimationDirection)direction inView:(UIView*)enclosingView withFade:(BOOL)fade duration:(NSTimeInterval)duration delegate:(id)delegate
      startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
    CAAnimation *backInAnim = [[AFAnimationManager sharedManager] hiddenOutAnimationFor:self withFade:fade direction:direction inView:enclosingView
																			duration:duration delegate:delegate
																	   startSelector:startSelector stopSelector:stopSelector];
	[self.layer addAnimation:backInAnim forKey:kAFAnimationHiddenOut];

}

@end
