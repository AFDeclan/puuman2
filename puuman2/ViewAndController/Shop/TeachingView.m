//
//  TeachingView.m
//  puman
//
//  Created by 祁文龙 on 13-12-18.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "TeachingView.h"

@implementation TeachingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        step = 0;
        pause = YES;
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    bgImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgImgView setImage:[UIImage imageNamed:@"pic17_insure_shop"]];
    [self addSubview:bgImgView];
    teachImg = [[UIImageView alloc] initWithFrame:CGRectMake(286, 111, 213, 59)];
    [teachImg setImage:[UIImage imageNamed:@"pic20_insure_shop"]];
    [teachImg setAlpha:0];
    [self addSubview:teachImg];
    
    teachImgForOne = [[UIImageView alloc] initWithFrame:CGRectMake(300, 90, 35, 35)];
    [teachImgForOne setImage:[UIImage imageNamed:@"pic21_insure_shop"]];
    [self addSubview:teachImgForOne];
    teachImgForTwo = [[UIImageView alloc] initWithFrame:CGRectMake(376, 90, 35, 35)];
    [teachImgForTwo setImage:[UIImage imageNamed:@"pic21_insure_shop"]];
    [self addSubview:teachImgForTwo];
    teachImgForThree = [[UIImageView alloc] initWithFrame:CGRectMake(450, 90, 35, 35)];
    [teachImgForThree setImage:[UIImage imageNamed:@"pic22_insure_shop"]];
    [self addSubview:teachImgForThree];
    [teachImgForOne setAlpha:0];
    [teachImgForTwo setAlpha:0];
    [teachImgForThree setAlpha:0];
    teachHand = [[UIImageView alloc] initWithFrame:CGRectMake(180, 118, 78, 98)];
    [teachHand.layer setAnchorPoint:CGPointMake(0, 0.68)];
    [teachHand setImage:[UIImage imageNamed:@"pic19_insure_shop"]];
    [self addSubview:teachHand];
    teacher = [[UIImageView alloc] initWithFrame:CGRectMake(88, 59, 151, 272)];
    [teacher setImage:[UIImage imageNamed:@"pic18_insure_shop"]];
    [self addSubview:teacher];
    [self teacherImgAnimate];
     aniTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(teacherImgAnimate) userInfo:nil repeats:YES];
    
 
}
- (void)teacherImgAnimate
{
    
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.toValue = [NSNumber numberWithFloat:+0.05];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;
    shake.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [teachHand.layer  addAnimation:shake forKey:@"teach"];
}
- (void)appearTeacherImg
{
    step = 1;
   [UIView animateWithDuration:0.5 animations:^{
       [teachImg setAlpha:1];
   } completion:^(BOOL finished) {
       if (!pause) {
           [self performSelector:@selector(appearTeacherImgOne) withObject:nil afterDelay:0];
       }
       
   }];
}
- (void)appearTeacherImgOne
{
     step = 2;
    CGRect frame = teachImgForOne.frame;
    frame.origin.y = 54;
    [UIView animateWithDuration:0.5 animations:^{
        [teachImgForOne setAlpha:1];
        [teachImgForOne setFrame:frame];
    } completion:^(BOOL finished) {
        if (!pause) {
            [self performSelector:@selector(appearTeacherImgTwo) withObject:nil afterDelay:1];
        }
        
    }];
}
- (void)appearTeacherImgTwo
{
    step = 3;
    CGRect frame = teachImgForTwo.frame;
    frame.origin.y = 54;
    [UIView animateWithDuration:0.5 animations:^{
        [teachImgForTwo setAlpha:1];
        [teachImgForTwo setFrame:frame];
    } completion:^(BOOL finished) {
        if (!pause) {
            [self performSelector:@selector(appearTeacherImgThree) withObject:nil afterDelay:1];
        }
        
    }];
}
- (void)appearTeacherImgThree
{
    step = 4;
    CGRect frame = teachImgForThree.frame;
    frame.origin.y = 54;
    [UIView animateWithDuration:0.5 animations:^{
        [teachImgForThree setAlpha:1];
        [teachImgForThree setFrame:frame];
    } ];
}
-(void)pause
{
    pause = YES;
    
}
-(void)restart
{
    if (pause) {
        pause = NO;
        switch (step) {
            case 0:
                [self performSelector:@selector(appearTeacherImg) withObject:nil afterDelay:1];
                break;
            case 1:
                [self performSelector:@selector(appearTeacherImgOne) withObject:nil afterDelay:1];
                break;
            case 2:
                [self performSelector:@selector(appearTeacherImgTwo) withObject:nil afterDelay:1];
                break;
            case 3:
                [self performSelector:@selector(appearTeacherImgThree) withObject:nil afterDelay:1];
                break;
            case 4:
                
                break;
                
            default:
                break;
        }

    }
}
- (void)remove
{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
