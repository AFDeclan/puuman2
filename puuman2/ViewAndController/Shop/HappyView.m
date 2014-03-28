//
//  HappyView.m
//  puman
//
//  Created by 祁文龙 on 13-12-20.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HappyView.h"

@implementation HappyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    bgImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgImgView setImage:[UIImage imageNamed:@"pic29_insure_shop.png"]];
    [self addSubview:bgImgView];
    
    cloudView =[[UIImageView alloc] initWithFrame:CGRectMake(120, 36, 473, 62)];
    [cloudView setImage:[UIImage imageNamed:@"pic30_insure_shop.png"]];
    [self addSubview:cloudView];
    
    birdView =[[UIImageView alloc] initWithFrame:CGRectMake(74, 42, 40, 30)];
    [birdView setImage:[UIImage imageNamed:@"pic33_insure_shop.png"]];
    [self addSubview:birdView];
 
    animalView =[[UIImageView alloc] initWithFrame:CGRectMake(152, 52, 430, 276)];
    [animalView setImage:[UIImage imageNamed:@"pic31_insure_shop.png"]];
    [self addSubview:animalView];
    
    sea_one =[[UIImageView alloc] initWithFrame:CGRectMake(0, 240, 640, 120)];
    [sea_one setImage:[UIImage imageNamed:@"pic32_insure_shop.png"]];
    [self addSubview:sea_one];
    
    sea_two =[[UIImageView alloc] initWithFrame:CGRectMake(-640, 240, 640, 120)];
    [sea_two setImage:[UIImage imageNamed:@"pic32_insure_shop.png"]];
    [self addSubview:sea_two];
    oneIsPre = YES;
    [self animateWithCloud];
    [self animateWithSea];
    
    [self animationAnimal];
    [self animateWithBird];
     aniTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animationAnimal) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(animateWithBird) userInfo:nil repeats:YES];
}


- (void)animateWithCloud
{
    CGRect frame = cloudView.frame;
    
    float length = frame.origin.x +frame.size.width;
    frame.origin.x = -frame.size.width;
    [UIView animateWithDuration:length/20
                     animations:^{
                         [cloudView setFrame:frame];
                     } completion:^(BOOL finished) {
                         CGRect frame2 = frame;
                         frame2.origin.x = 640;
                         [cloudView setFrame:frame2];
                         [self animateWithCloud];
                     }];
}
- (void)animateWithSea
{
    CGRect frame1;
    CGRect frame2;
    if (oneIsPre) {
        frame1 = sea_one.frame;
        frame2 = frame1;
        frame1.origin.x = 640;
        frame2.origin.x = 0;
    }else{
        frame2 = sea_two.frame;
        frame1 = frame2;
        frame2.origin.x = 640;
        frame1.origin.x = 0;
    }
    

    [UIView animateWithDuration:640/20
                     animations:^{
                         [sea_one setFrame:frame1];
                         [sea_two setFrame:frame2];
                     } completion:^(BOOL finished) {
                         CGRect frame = frame1;
                          frame.origin.x = -640;
                         if (oneIsPre) {
                              [sea_one setFrame:frame];
                         }else{
                            [sea_two setFrame:frame];
                          }
                         oneIsPre = !oneIsPre;
                         [self animateWithSea];
                         
                        
                         
                     }];
}

- (void)animateWithBird
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:5] forKey:kCATransactionAnimationDuration];
    
    // make it jump a couple of times
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef positionPath = CGPathCreateMutable();
    CGPathMoveToPoint(positionPath, NULL, [birdView layer].position.x, [birdView layer].position.y);
    
    
    
    CGPathAddQuadCurveToPoint(positionPath, NULL, [birdView layer].position.x-5, [birdView layer].position.y-5, [birdView layer].position.x-10, [birdView layer].position.y-5);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [birdView layer].position.x-5, [birdView layer].position.y+5, [birdView layer].position.x, [birdView layer].position.y);
    
    positionAnimation.path = positionPath;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [[birdView layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
    [CATransaction commit];
   CGPathRelease(positionPath);

}

- (void)animationAnimal
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:2] forKey:kCATransactionAnimationDuration];
    
    // make it jump a couple of times
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef positionPath = CGPathCreateMutable();
    CGPathMoveToPoint(positionPath, NULL, [animalView layer].position.x, [animalView layer].position.y);
    
  
    
    CGPathAddQuadCurveToPoint(positionPath, NULL, [animalView layer].position.x-5, [animalView layer].position.y-5, [animalView layer].position.x-10, [animalView layer].position.y-5);
   CGPathAddQuadCurveToPoint(positionPath, NULL, [animalView layer].position.x-5, [animalView layer].position.y+5, [animalView layer].position.x, [animalView layer].position.y);

    positionAnimation.path = positionPath;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [[animalView layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
    [CATransaction commit];
    CGPathRelease(positionPath);
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
