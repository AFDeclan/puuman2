//
//  PageControlButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PageControlButton.h"

@implementation PageControlButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bgImgView = [[UIImageView alloc] init];
        [bgImgView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:bgImgView];
        iconImgView = [[UIImageView alloc]init];
        [bgImgView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:iconImgView];
    }
    return self;
}

- (void)setWithbgImage:(UIImage *)bgImg andIconImage:(UIImage *)icon
{
    [bgImgView setImage:bgImg];
    [iconImgView setImage:icon];
}

- (void)foldWithDuration:(NSTimeInterval)time
{

}
- (void)unfoldWithDuration:(NSTimeInterval)time
{

}

@end
