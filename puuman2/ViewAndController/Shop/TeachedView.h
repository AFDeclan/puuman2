//
//  TeachedView.h
//  puman
//
//  Created by 祁文龙 on 13-12-20.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    NonePic = 0,
    FirstPic,
    SecondPic,
    ThirdPic,
    PointOne,
    PointTwo
} ImgViewAppear;
@interface TeachedView : UIView
{
    UIImageView *bgImgView;
    UIImageView *picFirst;
    UIImageView *picSecond;
    UIImageView *picThird;
    UIImageView *pointOne;
    UIImageView *pointTwo;
    UIImageView *stick;
    ImgViewAppear appearImg;
    BOOL pause;
 }
-(void)pause;
-(void)restart;
- (void)remove;
@end
