//
//  HosipitalBigView.m
//  puman
//
//  Created by 祁文龙 on 13-11-29.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HospitalBigView.h"
#import "ColorsAndFonts.h"

@implementation HospitalBigView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialzation];
    }
    return self;
}
- (void)initialzation
{
    numAnimate = NO;
    num = 35;
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgImg setImage:[UIImage imageNamed:@"pic5_insure_shop.png"]];
    [self addSubview:bgImg];
    
    
    bgNum = [[UIImageView alloc] initWithFrame:CGRectMake(120, -72, 198, 72)];
    [bgNum setImage:[UIImage imageNamed:@"block2_insure_shop.png"]];
    [self addSubview:bgNum];
   
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(48, 32, 64, 32)];
    [numLabel setFont:PMFont(32)];
    [numLabel setTextColor:PMColor1];
    [numLabel setTextAlignment:NSTextAlignmentCenter];
    [numLabel setBackgroundColor:[UIColor clearColor]];
    [bgNum addSubview:numLabel];
    [numLabel setText:@"035"];
    
    
    
    earAni=[[UIImageView alloc] initWithFrame:CGRectMake(100, 125, 80, 96)];
    [earAni setImage:[UIImage imageNamed:@"ear_insure_shop.png"]];
    [earAni setBackgroundColor:[UIColor clearColor]];
    [self addSubview:earAni];
    [earAni.layer setAnchorPoint:CGPointMake(0.07, 0.34)];
 
    wingAni=[[UIImageView alloc] initWithFrame:CGRectMake(221, 132, 12, 22)];
    [self addSubview:wingAni];
    [wingAni setImage: [UIImage imageNamed:@"wing1_insure_shop.png"]];
     [wingAni.layer setAnchorPoint:CGPointMake(0.67, 0.09)];
    
    wing2Ani=[[UIImageView alloc] initWithFrame:CGRectMake(248, 134, 13, 22)];
    [self addSubview:wing2Ani];
    [wing2Ani setImage:[UIImage imageNamed:@"wing2_insure_shop.png"]];
    [wing2Ani.layer setAnchorPoint:CGPointMake(0.08, 0.13)];
    
     wing =  [[UIImageView alloc] initWithFrame:CGRectMake(496, 272, 29, 21)];
    [wing setImage:[UIImage imageNamed:@"wing3_insure_shop.png"]];
    [wing.layer setAnchorPoint:CGPointMake(0.24, 0.36)];
    [self addSubview:wing];
    [self performSelector:@selector(earAniStart) withObject:nil afterDelay:0];
    [self performSelector:@selector(changeNum) withObject:nil afterDelay:1];
    [self performSelector:@selector(goDown) withObject:nil afterDelay:1];
    [self performSelector:@selector(wingAniStart) withObject:nil afterDelay:1];
    [self performSelector:@selector(wingStart) withObject:nil afterDelay:2];
 
  
}
- (void)goDown
{
    [UIView animateWithDuration:0.5 animations:^{
        [bgNum setFrame:CGRectMake(120, 0, 198, 72)];
    } completion:^(BOOL finished) {
        numAnimate = YES;
    }];
}
- (void)changeNum
{
    
    if (numaniTimer) {
        [numaniTimer invalidate];
        numaniTimer = nil;
    }
 
    if (num<10) {
        [numLabel setText:[NSString stringWithFormat:@"00%d",num]];
    }else if (num < 100) {
        [numLabel setText:[NSString stringWithFormat:@"0%d",num]];
    }else{
        [numLabel setText:[NSString stringWithFormat:@"%d",num]];
    }
    num++;
    if (num < 45) {
        time = (num-35)/2;
    }else if (num<100) {
        time = rand()%5+5;
    }else if(num <200)
    {
        time = rand()%30+10;
    }else{
         time = rand()%60+15;
    }
    if(num<= 275)
    {
        numaniTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(changeNum) userInfo:nil repeats:NO];
    }
   
}
- (void)earAniStart
{
    if (earaniTimer) {
        [earaniTimer invalidate];
        earaniTimer = nil;
    }
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:0];
    
    shake.toValue = [NSNumber numberWithFloat:+0.2];
    
    shake.duration = 0.2;
    
    shake.autoreverses = NO; //是否重复
    
    shake.repeatCount = 2;
    
    [earAni.layer addAnimation:shake forKey:@"imageView"];
    
    float duration = random()%3+1;
    earaniTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(earAniStart) userInfo:nil repeats:NO];
    
}
- (void)wingAniStart
{
    if(wingAnianiTimer)
    {
        [wingAnianiTimer invalidate];
        wingAnianiTimer = nil;
    }
   
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:0];
    
    shake.toValue = [NSNumber numberWithFloat:+0.2];
    
    shake.duration = 0.2;
    
    shake.autoreverses = NO; //是否重复
    
    shake.repeatCount = 2;
    
     [wingAni.layer addAnimation:shake forKey:@"imageView"];
     shake.toValue = [NSNumber numberWithFloat:-0.2];
      [wing2Ani.layer addAnimation:shake forKey:@"imageView"];
     float duration = random()%3+1;
    wingAnianiTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(wingAniStart) userInfo:nil repeats:NO];

}
- (void)wingStart
{
    if (wingTimer) {
        [wingTimer invalidate];
        wingTimer = nil;
    }
  
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:0];
    
    shake.toValue = [NSNumber numberWithFloat:-0.3];
    
    shake.duration = 0.2;
    
    shake.autoreverses = NO; //是否重复
    
    shake.repeatCount = 2;
    [wing.layer addAnimation:shake forKey:@"imageView"];
  
    float duration = random()%3+1;
    wingTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(wingStart) userInfo:nil repeats:NO];
  
}
-(void)stopAni
{
    if (wingTimer) {
        [wingTimer invalidate];
        wingTimer = nil;
    }
    if (wingAnianiTimer) {
        [wingAnianiTimer invalidate];
        wingAnianiTimer = nil;
    }
    if (earaniTimer) {
        [earaniTimer invalidate];
        earaniTimer = nil;
    }
   
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
