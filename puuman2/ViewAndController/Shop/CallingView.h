//
//  CallingView.h
//  puman
//
//  Created by 祁文龙 on 13-12-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallingView : UIView
{
    UIImageView *bgImgView;
    UIImageView *cloud;
    UIImageView *phone;
    UIImageView *phoneBg;
    NSTimer *aniTimer;
}
- (void)remove;
@end
