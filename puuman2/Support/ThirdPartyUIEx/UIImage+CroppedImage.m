//
//  UIImage+CroppedImage.m
//  puman
//
//  Created by 祁文龙 on 13-11-1.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "UIImage+CroppedImage.h"

@implementation UIImage (CroppedImage)
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)croppedImage:(UIImage *)image WithHeight:(float)height andWidth:(float)width
{
    CGRect newFrame=CGRectMake(0, 0, width, height);
    CGSize imgSize = image.size;
    if (imgSize.height/imgSize.width>height/width) {
        image = [self scaleImage:image toScale:width/imgSize.width];
        newFrame.origin.y = (image.size.height-height)/2;
    }else {
        image = [self scaleImage:image toScale:height/imgSize.height];
        newFrame.origin.x = (image.size.width-width)/2;
    }
 
    CGImageRef resultImage = CGImageCreateWithImageInRect([image CGImage], newFrame);
    UIImage *result = [UIImage imageWithCGImage:resultImage scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(resultImage);
    return result;
}

@end
