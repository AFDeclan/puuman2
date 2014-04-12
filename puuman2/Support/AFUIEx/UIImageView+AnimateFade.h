//
//  UIImageView+AnimateFade.h
//  puuman2
//
//  Created by Declan on 14-4-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AnimateFade)

- (void)fadeToImage:(UIImage *)img withTimeInterval:(NSTimeInterval)interval;

- (void)fadeToImage:(UIImage *)img;

@end
