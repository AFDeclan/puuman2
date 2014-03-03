//
//  UIView+AFAnimation.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAnimationManager.h"

@interface UIView (AFAnimation)
- (void)showInFrom:(AFAnimationDirection)direction inView:(UIView*)enclosingView withFade:(BOOL)fade duration:(NSTimeInterval)duration delegate:(id)delegate
     startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;

- (void)hiddenOutTo:(AFAnimationDirection)direction inView:(UIView*)enclosingView withFade:(BOOL)fade duration:(NSTimeInterval)duration delegate:(id)delegate
    startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;
@end
