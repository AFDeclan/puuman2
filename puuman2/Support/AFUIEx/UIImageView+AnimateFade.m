//
//  UIImageView+AnimateFade.m
//  puuman2
//
//  Created by Declan on 14-4-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "UIImageView+AnimateFade.h"

@implementation UIImageView (AnimateFade)

- (void)fadeToImage:(UIImage *)img withTimeInterval:(NSTimeInterval)interval
{
    CATransition *animation = [CATransition animation];
    animation.duration = interval;
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"imageFade"];
    [self setImage:img];
}

- (void)fadeToImage:(UIImage *)img
{
    [self fadeToImage:img withTimeInterval:0.5];
}

@end
