//
//  AFAnimationManager.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFAnimationManager.h"
#import "NSObject+AFUtils.h"
#import "AFUICode.h"

@implementation AFAnimationManager
@synthesize overshootThreshold = _overshootThreshold;
static AFAnimationManager *sharedAnimationManager = nil;
+ (AFAnimationManager *)sharedManager {
    @synchronized(self) {
        if (sharedAnimationManager == nil) {
            sharedAnimationManager = [[self alloc] init];
        }
    }
    return sharedAnimationManager;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        _overshootThreshold = 10.f;
    }
    return self;
}
- (CAAnimation *)showInAnimationFor:(UIView *)view withFade:(BOOL)fade direction:(AFAnimationDirection)direction inView:(UIView*)enclosingView
                           duration:(NSTimeInterval)duration delegate:(id)delegate
                      startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
    CGPoint path[3] = {
		FTAnimationOutOfViewCenterPoint(enclosingView.bounds, view.frame, view.center, direction),
		[self overshootPointFor:view.center withDirection:direction threshold:(_overshootThreshold * 1.15)],
		view.center
	};
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGPathAddLines(thePath, NULL, path, 3);
	animation.path = thePath;
	CGPathRelease(thePath);
	NSArray *animations;
	if(fade) {
		CAAnimation *fade = [self fadeAnimationFor:view duration:duration * .5f delegate:nil startSelector:nil stopSelector:nil fadeOut:NO];
		fade.fillMode = kCAFillModeForwards;
		
		animations = [NSArray arrayWithObjects:animation, fade, nil];
	} else {
		animations = [NSArray arrayWithObject:animation];
	}
	return [self animationGroupFor:animations withView:view duration:duration
						  delegate:delegate startSelector:startSelector stopSelector:stopSelector
							  name:kAFAnimationShowIn type:kAFAnimationTypeIn];
}

- (CAAnimation *)hiddenOutAnimationFor:(UIView *)view withFade:(BOOL)fade direction:(AFAnimationDirection)direction inView:(UIView*)enclosingView
                              duration:(NSTimeInterval)duration delegate:(id)delegate
                         startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{

    
    CGPoint path[3] = {
		view.center,
		[self overshootPointFor:view.center withDirection:direction threshold:_overshootThreshold],
		FTAnimationOutOfViewCenterPoint(enclosingView.bounds, view.frame, view.center, direction)
	};
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGPathAddLines(thePath, NULL, path, 3);
	animation.path = thePath;
	CGPathRelease(thePath);
	NSArray *animations;
    
    
	if(fade) {
		CAAnimation *fade = [self fadeAnimationFor:view duration:duration * .5f delegate:nil startSelector:nil stopSelector:nil fadeOut:YES];
		fade.beginTime = duration * .5f;
		fade.fillMode = kCAFillModeForwards;
		animations = [NSArray arrayWithObjects:animation, fade, nil];
	} else {
		animations = [NSArray arrayWithObject:animation];
	}
	return [self animationGroupFor:animations withView:view duration:duration
						  delegate:delegate startSelector:startSelector stopSelector:stopSelector
							  name:kAFAnimationHiddenOut type:kAFAnimationTypeOut];
    
}

- (CGPoint)overshootPointFor:(CGPoint)point withDirection:(AFAnimationDirection)direction threshold:(CGFloat)threshold {
    CGPoint overshootPoint;
    if(direction == kAFAnimationTop || direction == kAFAnimationBottom) {
        overshootPoint = CGPointMake(point.x, point.y + ((direction == kAFAnimationBottom ? -1 : 1) * threshold));
    } else if (direction == kAFAnimationLeft || direction == kAFAnimationRight){
        overshootPoint = CGPointMake(point.x + ((direction == kAFAnimationRight ? -1 : 1) * threshold), point.y);
    } else if (direction == kAFAnimationTopLeft){
        overshootPoint = CGPointMake(point.x + threshold, point.y + threshold);
    } else if (direction == kAFAnimationTopRight){
        overshootPoint = CGPointMake(point.x - threshold, point.y + threshold);
    } else if (direction == kAFAnimationBottomLeft){
        overshootPoint = CGPointMake(point.x + threshold, point.y - threshold);
    } else if (direction == kAFAnimationBottomRight){
        overshootPoint = CGPointMake(point.x - threshold, point.y - threshold);
    }
    
    return overshootPoint;
}


- (CAAnimation *)fadeAnimationFor:(UIView *)view duration:(NSTimeInterval)duration
                         delegate:(id)delegate startSelector:(SEL)startSelector
                     stopSelector:(SEL)stopSelector fadeOut:(BOOL)fadeOut {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    NSString *name, *type;
    if(fadeOut) {
        animation.fromValue = [NSNumber numberWithFloat:1.f];
        animation.toValue = [NSNumber numberWithFloat:0.f];
        name = kAFAnimationFadeOut;
        type = kAFAnimationTypeOut;
    } else {
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat:1.f];
        name = kAFAnimationFadeIn;
        type = kAFAnimationTypeIn;
    }
    CAAnimationGroup *group = [self animationGroupFor:[NSArray arrayWithObject:animation] withView:view duration:duration
                                             delegate:delegate startSelector:startSelector stopSelector:stopSelector
                                                 name:name type:type];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return group;
    
}

- (CAAnimationGroup *)animationGroupFor:(NSArray *)animations withView:(UIView *)view
                               duration:(NSTimeInterval)duration delegate:(id)delegate
                          startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
                                   name:(NSString *)name type:(NSString *)type {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithArray:animations];
    group.delegate = self;
    group.duration = duration;
    group.removedOnCompletion = NO;
    if([type isEqualToString:kAFAnimationTypeOut]) {
        group.fillMode = kCAFillModeBoth;
    }
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [group setValue:view forKey:kAFAnimationTargetViewKey];
    [group setValue:delegate forKey:kAFAnimationCallerDelegateKey];
    if(!startSelector) {
        startSelector = @selector(animationDidStart:);
    }
    [group setValue:NSStringFromSelector(startSelector) forKey:kAFAnimationCallerStartSelectorKey];
    if(!stopSelector) {
        stopSelector = @selector(animationDidStop:finished:);
    }
    [group setValue:NSStringFromSelector(stopSelector) forKey:kAFAnimationCallerStopSelectorKey];
    [group setValue:name forKey:kAFAnimationName];
    [group setValue:type forKey:kAFAnimationType];
    return group;
}

- (void)animationDidStart:(CAAnimation *)theAnimation {
    UIView *targetView = [theAnimation valueForKey:kAFAnimationTargetViewKey];
    [theAnimation setValue:[NSNumber numberWithBool:targetView.userInteractionEnabled] forKey:kAFAnimationWasInteractionEnabledKey];
    [targetView setUserInteractionEnabled:NO];
    
    if([[theAnimation valueForKey:kAFAnimationType] isEqualToString:kAFAnimationTypeIn]) {
        [targetView setHidden:NO];
    }
    
    //Check for chaining and forward the delegate call if necessary
    NSObject *callerDelegate = [theAnimation valueForKey:kAFAnimationCallerDelegateKey];
    SEL startSelector = NSSelectorFromString([theAnimation valueForKey:kAFAnimationCallerStartSelectorKey]);
    do {
      
        if(callerDelegate != nil && [callerDelegate respondsToSelector:startSelector]) {
            [callerDelegate performSelector:startSelector withObject:theAnimation afterDelay:0];
        }
    } while(0);

}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished {
    UIView *targetView = [theAnimation valueForKey:kAFAnimationTargetViewKey];
    BOOL wasInteractionEnabled = [[theAnimation valueForKey:kAFAnimationWasInteractionEnabledKey] boolValue];
    [targetView setUserInteractionEnabled:wasInteractionEnabled];
    
    if([[theAnimation valueForKey:kAFAnimationType] isEqualToString:kAFAnimationTypeOut]) {
        [targetView setHidden:YES];
    }
    [targetView.layer removeAnimationForKey:[theAnimation valueForKey:kAFAnimationName]];
    
    //Forward the delegate call
    id callerDelegate = [theAnimation valueForKey:kAFAnimationCallerDelegateKey];
    SEL stopSelector = NSSelectorFromString([theAnimation valueForKey:kAFAnimationCallerStopSelectorKey]);
    
    if([theAnimation valueForKey:kAFAnimationIsChainedKey]) {
        CAAnimation *next = [theAnimation valueForKey:kAFAnimationNextAnimationKey];
        if(next) {
            //Add the next animation to its layer
            UIView *nextTarget = [next valueForKey:kAFAnimationTargetViewKey];
            [nextTarget.layer addAnimation:next forKey:[next valueForKey:kAFAnimationName]];
        }
    }
    
    void *arguments[] = { &theAnimation, &finished };
    [callerDelegate performSelectorIfExists:stopSelector withArguments:arguments];
}


@end
