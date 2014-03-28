//
//  TeachingView.h
//  puman
//
//  Created by 祁文龙 on 13-12-18.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachingView : UIView
{
    UIImageView *bgImgView;
    UIImageView *teacher;
    UIImageView *teachHand;
    UIImageView *teachImg;
    UIImageView *teachImgForOne;
    UIImageView *teachImgForTwo;
    UIImageView *teachImgForThree;
    NSTimer *aniTimer;
    NSInteger step;
    BOOL pause;
}
-(void)pause;
-(void)restart;
- (void)remove;
@end
