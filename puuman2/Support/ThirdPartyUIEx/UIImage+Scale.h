//
//  UIImage+Scale.h
//  puman
//
//  Created by 陈晔 on 13-8-12.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Scale)

- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)scaleToHeight:(CGFloat)height;

- (UIImage *)scaleToWidth:(CGFloat)width;

- (UIImage *)addImage:(UIImage *)image;

- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur;

+ (UIImage *)imageWithScreenContents:(BOOL)upsideDown;

+ (UIImage *)bluredScreenWithBlurLevel:(CGFloat)blur upsideDown:(BOOL)upsideDown;

- (UIImage *)croppedImageWithFrame:(CGRect)frame;

@end
