//
//  TeachedView.m
//  puman
//
//  Created by 祁文龙 on 13-12-20.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "TeachedView.h"

@implementation TeachedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pause = NO;
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    bgImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgImgView setImage:[UIImage imageNamed:@"pic23_insure_shop"]];
    [self addSubview:bgImgView];
    picFirst =[[UIImageView alloc] initWithFrame:CGRectMake(29, 32, 118, 152)];
    [picFirst setImage:[UIImage imageNamed:@"pic24_insure_shop"]];
    [self addSubview:picFirst];
    
    picSecond =[[UIImageView alloc] initWithFrame:CGRectMake(256, 28, 90, 153)];
    [picSecond setImage:[UIImage imageNamed:@"pic26_insure_shop"]];
    [self addSubview:picSecond];
    picThird =[[UIImageView alloc] initWithFrame:CGRectMake(480, 28, 118, 152)];
    [picThird setImage:[UIImage imageNamed:@"pic27_insure_shop"]];
    [self addSubview:picThird];
    pointOne =[[UIImageView alloc] initWithFrame:CGRectMake(168, 96, 62, 38)];
    [pointOne setImage:[UIImage imageNamed:@"pic25_insure_shop"]];
    [self addSubview:pointOne];
    pointTwo =[[UIImageView alloc] initWithFrame:CGRectMake(387, 98, 62, 38)];
    [pointTwo setImage:[UIImage imageNamed:@"pic25_insure_shop"]];
    [self addSubview:pointTwo];
    stick =[[UIImageView alloc] initWithFrame:CGRectMake(296, 196, 7, 140)];
    [stick setImage:[UIImage imageNamed:@"pic28_insure_shop"]];
    [stick.layer setAnchorPoint:CGPointMake(0.5, 1)];
    [self addSubview:stick];
    [picFirst setAlpha:0];
    [picSecond setAlpha:0];
    [picThird setAlpha:0];
    [pointOne setAlpha:0];
    [pointTwo setAlpha:0];
    appearImg = NonePic;
    stick.transform =CGAffineTransformMakeRotation(-0.3);
  }

- (void)animateForImgView:(UIImageView *)view
{
    
    
        [UIView animateWithDuration:0.5 animations:^{
            [view setAlpha:1];
        } completion:^(BOOL finished) {
           
            BOOL jump;
            ImgViewAppear appearWill ;
            switch (appearImg) {
                case NonePic:
                    appearWill = FirstPic;
                    jump = YES;
                    [self shakeWithRotation:-0.3];
                    if (!pause) {
                         [self performSelector:@selector(animateForImgView:) withObject:pointOne afterDelay:0.5];
                    }
                   
                    break;
                case FirstPic:
                    appearWill = PointOne;
                    jump = NO;
                    if (!pause) {
                        [self performSelector:@selector(animateForImgView:) withObject:picSecond afterDelay:0.5];
                    }
                    
                    
                    break;
                case PointOne:
                    appearWill = SecondPic;
                    jump = YES;
                    [self shakeWithRotation:-0.3];
                    if (!pause) {
                         [self performSelector:@selector(animateForImgView:) withObject:pointTwo afterDelay:0.5];
                    }
                   
                    
                    break;
                case SecondPic:
                    appearWill = PointTwo;
                    jump = NO;
                    if (!pause) {
                         [self performSelector:@selector(animateForImgView:) withObject:picThird afterDelay:0.5];
                    }
                   
                    
                    break;
                case PointTwo:
                    [self shakeWithRotation:-0.3];
                    appearWill = ThirdPic;
                    jump = YES;
                    break;
              
                default:
                    appearWill = NonePic;
                     jump = NO;
                    break;
                    
            }
            appearImg = appearWill;
            if (jump) {
                CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                positionAnimation.fillMode = kCAFillModeForwards;
                positionAnimation.removedOnCompletion =NO;
                positionAnimation.duration = 0.5;
                CGMutablePathRef positionPath = CGPathCreateMutable();
                positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                CGPathMoveToPoint(positionPath, NULL, [view layer].position.x, [view layer].position.y);
                CGPathAddQuadCurveToPoint(positionPath, NULL, [view layer].position.x, [view layer].position.y-10, [view layer].position.x,[view layer].position.y);
                positionAnimation.path = positionPath;
                [view.layer addAnimation:positionAnimation forKey:@"position"];
                CGPathRelease(positionPath);
            }

        }];
}
- (void)shakeWithRotation:(float)rotation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:rotation];
    shake.toValue = [NSNumber numberWithFloat:rotation-0.1];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 1;
    shake.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [stick.layer addAnimation:shake forKey:@"shake"];
}
-(void)pause
{
    pause = YES;
}
-(void)restart
{
    if (pause) {
        pause = NO;
        switch (appearImg) {
            case NonePic:
                [self performSelector:@selector(animateForImgView:) withObject:picFirst afterDelay:0.5];
                break;
            case FirstPic:
                [self performSelector:@selector(animateForImgView:) withObject:pointOne afterDelay:0.5];
                
                break;
            case PointOne:
                [self performSelector:@selector(animateForImgView:) withObject:picSecond afterDelay:0.5];
                
                break;
            case SecondPic:
                [self performSelector:@selector(animateForImgView:) withObject:pointTwo afterDelay:0.5];
                
                break;
            case PointTwo:
                [self performSelector:@selector(animateForImgView:) withObject:picThird afterDelay:0.5];
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
