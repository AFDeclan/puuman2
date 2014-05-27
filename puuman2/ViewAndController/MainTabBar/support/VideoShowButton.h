//
//  VideoShowButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>


@interface VideoShowButton : UIView
{
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    NSInteger index;
    NSInteger count;
    NSTimer *timer; 
}

- (id)initWithFrame:(CGRect)frame fileName:(NSString *)fileName;
- (void)stopGif;
@end
