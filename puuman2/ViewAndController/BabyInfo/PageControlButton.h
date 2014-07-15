//
//  PageControlButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlButton : UIButton
{
    UIImageView *bgImgView;
    UIImageView *iconImgView;
}

- (void)setWithbgImage:(UIImage *)bgImg andIconImage:(UIImage *)icon;
- (void)foldWithDuration:(NSTimeInterval)time;
- (void)unfoldWithDuration:(NSTimeInterval)time;
@end
