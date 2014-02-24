//
//  CATransition+Custom.h
//  PuumanForPhone
//
//  Created by Declan on 14-1-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#define kDefaultTransitionTime       0.3

@interface CATransition (Custom)

+ (CATransition *)EaseInEaseOut:(id)delegate;

+ (CATransition *)revealFromBottom:(id)delegate;

+ (CATransition *)pushFromRight:(id)delegate;

+ (CATransition *)pushFromLeft:(id)delegate;

+ (CATransition *)moveInFromTop:(id)delegate;

@end
