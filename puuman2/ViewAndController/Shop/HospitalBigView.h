//
//  HosipitalBigView.h
//  puman
//
//  Created by 祁文龙 on 13-11-29.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalBigView : UIView
{
    UIImageView *wingAni;
    UIImageView *wing2Ani;
    UIImageView  *wing;
    UIImageView  *earAni;
    NSTimer *earaniTimer;
    NSTimer *wingAnianiTimer;
    NSTimer *wingTimer;
    NSTimer *numaniTimer;
    UIImageView *bgNum;
    BOOL numAnimate;
    UILabel *numLabel;
    int  num;
    float time;
    
}
-(void)stopAni;
@end
