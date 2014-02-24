//
//  UIImage+CroppedImage.h
//  puman
//
//  Created by 祁文龙 on 13-11-1.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CroppedImage)
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (UIImage *)croppedImage:(UIImage *)image WithHeight:(float)height andWidth:(float)width;

@end
