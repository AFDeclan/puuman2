//
//  CATransition+Custom.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "CATransition+Custom.h"

@implementation CATransition (Custom)

+ (CATransition *)EaseInEaseOut:(id)delegate
{
    CATransition *transition = [CATransition animation];
    transition.duration = kDefaultTransitionTime;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = delegate;
    return transition;
}

+ (CATransition *)revealFromBottom:(id)delegate
{
    CATransition *transition = [self EaseInEaseOut:delegate];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    return transition;
}

+ (CATransition *)pushFromRight:(id)delegate
{
    CATransition *transition = [self EaseInEaseOut:delegate];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    return transition;
}

+ (CATransition *)pushFromLeft:(id)delegate
{
    CATransition *transition = [self EaseInEaseOut:delegate];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    return transition;
}

+ (CATransition *)moveInFromTop:(id)delegate
{
    CATransition *transition = [self EaseInEaseOut:delegate];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    return transition;

}

@end
