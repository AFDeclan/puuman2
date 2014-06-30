//
//  HospitalHomeView.m
//  puman
//
//  Created by 祁文龙 on 13-11-27.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HospitalHomeView.h"
#import "MobClick.h"
#import "UniverseConstant.h"

@implementation HospitalHomeView
@synthesize delegate = _delegate;
@synthesize hospitalOnShow = _hospitalOnShow;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // [self initialization];
        
    }
    return self;
}
- (void)initialization
{
    bigHospitalClicked = NO;
    smallHospitalClicked = NO;
    privateHospitalClicked  = NO;
    _hospitalOnShow = kNoneHospital;
    hospitalAnimate = kNoneHospital;
    bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgImg setImage:[UIImage imageNamed:@"pic_insure1_shop.png"]];
    [self addSubview:bgImg];
     bigHospitalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [bigHospitalBtn setFrame:CGRectMake(40, 16, 224, 164)];
    [bigHospitalBtn addTarget:self action:@selector(bigHospitalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:bigHospitalBtn];
    bigHospital = [[UIImageView alloc] initWithFrame:CGRectMake(40, 16, 224, 164)];
    [bigHospital setImage:[UIImage imageNamed:@"pic_insure2_shop.png"]];
    [self addSubview:bigHospital];
    
    
    privateHospitalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateHospitalBtn setFrame:CGRectMake(248, 24, 194, 154)];
    [privateHospitalBtn addTarget:self action:@selector(privateHospitalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:privateHospitalBtn];
    privateHospital = [[UIImageView alloc] initWithFrame:CGRectMake(248, 24, 194, 154)];
    [privateHospital setImage:[UIImage imageNamed:@"pic_insure3_shop.png"]];
    [self addSubview:privateHospital];
    
    smallHospitalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [smallHospitalBtn setFrame:CGRectMake(448, 56, 162, 121)];
    [smallHospitalBtn addTarget:self action:@selector(smallHospitalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:smallHospitalBtn];
    smallHospital = [[UIImageView alloc] initWithFrame:CGRectMake(448, 56, 162, 121)];
    [smallHospital setImage:[UIImage imageNamed:@"pic_insure4_shop.png"]];
    [self addSubview:smallHospital];
    aniTimer = [NSTimer scheduledTimerWithTimeInterval:1.4 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}
- (void)animation
{
    
    switch (hospitalAnimate) {
        case kNoneHospital:
            if (!bigHospitalClicked) {
                [self biganimate];
                hospitalAnimate = kBigHospital;
            }else if(!privateHospitalClicked)
            {
                [self privatanimate];
                hospitalAnimate = kPrivateHospital;
            }else{
                [self smallanimate];
                hospitalAnimate = kSmallHospital;
            }
           
            break;
        case kBigHospital:
            
            if (!privateHospitalClicked) {
                [self privatanimate];
                hospitalAnimate = kPrivateHospital;
            }else if(!smallHospital)
            {
                [self smallanimate];
                hospitalAnimate = kSmallHospital;
            }else{
                [self biganimate];
                hospitalAnimate = kBigHospital;
            }
            break;
        case kPrivateHospital:
            if (!smallHospitalClicked) {
              [self smallanimate];
                hospitalAnimate = kSmallHospital;
            }else if(!bigHospitalClicked){
              [self biganimate];
                hospitalAnimate = kBigHospital;
            }else{
                [self privatanimate];
                hospitalAnimate = kPrivateHospital;
            }
            
            break;
        case kSmallHospital:
            if (!bigHospitalClicked) {
                [self biganimate];
                hospitalAnimate = kBigHospital;
            }else if(!privateHospitalClicked)
            {
              [self privatanimate];
                hospitalAnimate = kPrivateHospital;
            }else{
                [self smallanimate];
                hospitalAnimate = kSmallHospital;
            }
          
            
            break;
        default:
            break;
    }
}

- (void)smallanimate
{
    [self animatedWithImgView:smallHospital withDuration:0.7 andMax:0.3 andMiddle:0.15 andMin:0.075];
}
- (void)privatanimate
{
    [self animatedWithImgView:privateHospital withDuration:0.7 andMax:0.2 andMiddle:0.1 andMin:0.05];
}
- (void)biganimate
{
    [self animatedWithImgView:bigHospital withDuration:0.7 andMax:0.2 andMiddle:0.1 andMin:0.05];
}
- (void)animatedWithImgView:(UIImageView *)img withDuration:(float)duration andMax:(float)max andMiddle:(float)middle andMin:(float)min
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:duration] forKey:kCATransactionAnimationDuration];
    
    // make it jump a couple of times
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef positionPath = CGPathCreateMutable();
    CGPathMoveToPoint(positionPath, NULL, [img layer].position.x, [img layer].position.y);
    
    //落下3次
    
    CGPathAddQuadCurveToPoint(positionPath, NULL, [img layer].position.x, [img layer].position.y-img.frame.size.height*max, [img layer].position.x, [img layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [img layer].position.x, [img layer].position.y-img.frame.size.height*middle, [img layer].position.x, [img layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [img layer].position.x, [img layer].position.y-img.frame.size.height*min, [img layer].position.x, [img layer].position.y);
    
    positionAnimation.path = positionPath;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [[img layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
    [CATransaction commit];
    CGPathRelease(positionPath);
}

- (void)bigHospitalBtnPressed:(UIButton *)sender
{
    bigHospitalClicked = YES;
    [MobClick event:umeng_event_click label:@"BigHospital_HospitalHomeView"];
    if (_hospitalOnShow ==kNoneHospital) {
        [smallHospitalBtn setEnabled:NO];
        [privateHospitalBtn setEnabled:NO];
        [bigHospitalBtn setEnabled:NO];
        if (aniTimer) {
            [aniTimer invalidate];
            aniTimer = nil;
        }
         _hospitalOnShow = kBigHospital;
        [self initWithBigHospital];
         [self performSelector:@selector(exChangeView) withObject:nil afterDelay:0];
    }
    
}

- (void)initWithBigHospital
{
    if (!bigHospitalView) {
        bigHospitalView = [[HospitalBigView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    
    }
    [bigHospitalView setAlpha:0];
    [self addSubview:bigHospitalView];
   
}




- (void)privateHospitalBtnPressed:(UIButton *)sender
{
    privateHospitalClicked = YES;
     [MobClick event:umeng_event_click label:@"PrivateHospital_HospitalHomeView"];
     if (_hospitalOnShow ==kNoneHospital) {
         [smallHospitalBtn setEnabled:NO];
         [privateHospitalBtn setEnabled:NO];
         [bigHospitalBtn setEnabled:NO];
         if (aniTimer) {
             [aniTimer invalidate];
             aniTimer = nil;
         }
         _hospitalOnShow = kPrivateHospital;
         [self initWithPrivateHospital];
         [self performSelector:@selector(exChangeView) withObject:nil afterDelay:0];
     }

   
    
}
- (void)exChangeView
{
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:1] forKey:kCATransactionAnimationDuration];
    // scale it down
    CABasicAnimation *shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrinkAnimation.delegate = self;
    shrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    shrinkAnimation.toValue = [NSNumber numberWithFloat:5.0];
    // fade it out
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // make it jump a couple of times
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
       switch (_hospitalOnShow) {
        case kSmallHospital:
               [[smallHospital layer]addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
               [[smallHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
               [[bigHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
               [[privateHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
               fadeAnimation.toValue = [NSNumber numberWithFloat:1];
               [[smallHospitalView layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
               CGPathMoveToPoint(positionPath, NULL, [smallHospital layer].position.x, [smallHospital layer].position.y);
               CGPathAddQuadCurveToPoint(positionPath, NULL, [smallHospital layer].position.x, [smallHospital layer].position.y, 400, [smallHospital layer].position.y);

               [[smallHospital layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
               
            break;
        case kPrivateHospital:
            [[privateHospital layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
            [[smallHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            [[bigHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            [[privateHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            fadeAnimation.toValue = [NSNumber numberWithFloat:1];
            [[privateHospitalView layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            CGPathMoveToPoint(positionPath, NULL, [privateHospital layer].position.x, [privateHospital layer].position.y);
            CGPathAddQuadCurveToPoint(positionPath, NULL, [privateHospital layer].position.x, [privateHospital layer].position.y, 400, [privateHospital layer].position.y);
              

            [[privateHospital layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
          
            break;
        case kBigHospital:
            [[bigHospital layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
            [[smallHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            [[bigHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            [[privateHospital layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
            fadeAnimation.toValue = [NSNumber numberWithFloat:1];
            [[bigHospitalView layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
               CGPathMoveToPoint(positionPath, NULL, [bigHospital layer].position.x, [privateHospital layer].position.y);
               CGPathAddQuadCurveToPoint(positionPath, NULL, 400, [bigHospital layer].position.y, 400, [bigHospital layer].position.y);
               positionAnimation.path = positionPath;

            [[bigHospital layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
           
            break;
        default:
            break;
    }
    
    [CATransaction commit];
    [self performSelector:@selector(stopMyAnimate) withObject:nil afterDelay:0.95];
      [self performSelector:@selector(setTitles) withObject:nil afterDelay:1];
    CGPathRelease(positionPath);
    
}
-(void)setTitles
{

  [_delegate setDatawithHospital:_hospitalOnShow];
  
}
- (void)initWithPrivateHospital
{
    if (!privateHospitalView) {
        privateHospitalView = [[HospitalPrivateView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
        
    }
    [privateHospitalView setAlpha:0];
    [self addSubview:privateHospitalView];
   
    
}
- (void)smallHospitalBtnPressed:(UIButton *)sender
{
     smallHospitalClicked = YES;
     [MobClick event:umeng_event_click label:@"SmallHospital_HospitalHomeView"];
    if (_hospitalOnShow ==kNoneHospital) {
        [smallHospitalBtn setEnabled:NO];
        [privateHospitalBtn setEnabled:NO];
        [bigHospitalBtn setEnabled:NO];
        if (aniTimer) {
            [aniTimer invalidate];
            aniTimer = nil;
        }
        _hospitalOnShow = kSmallHospital;
        [self initWithSmallHospital];
        [self performSelector:@selector(exChangeView) withObject:nil afterDelay:0];
    }
}
-(void)initWithSmallHospital
{
    if (!smallHospitalView) {
         smallHospitalView = [[HospitalSmallView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    }
    [smallHospitalView setAlpha:0];
    [self addSubview:smallHospitalView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)flagAnimateWithHositalBtn:(HospitalOnShow)hosipitalBtn
{
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.2] forKey:kCATransactionAnimationDuration];
    // scale it down
    CABasicAnimation *shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrinkAnimation.delegate = self;
    shrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    shrinkAnimation.fromValue = [NSNumber numberWithFloat:5.0];
    // fade it out
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    switch (hosipitalBtn) {
        case kSmallHospital:
            if (!smallHospitalFlag) {
                smallHospitalFlag = [[UIImageView alloc] initWithFrame:CGRectMake(508, 66, 84, 84)];
                [smallHospitalFlag setImage:[UIImage imageNamed:@"icon3_insure_shop.png"]];
            }
            [smallHospitalFlag setAlpha:1];
            [self addSubview:smallHospitalFlag];
            
            [[smallHospitalFlag layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
            [[smallHospitalFlag layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];

            break;
        case kPrivateHospital:
            
            if (!privateHospitalFlag) {
                privateHospitalFlag = [[UIImageView alloc] initWithFrame:CGRectMake(294, 66, 84, 84)];
                [privateHospitalFlag setImage:[UIImage imageNamed:@"icon2_insure_shop"]];
            }
            [privateHospitalFlag setAlpha:1];
            [self addSubview:privateHospitalFlag];
            
            [[privateHospitalFlag layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
            [[privateHospitalFlag layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];

            
            break;
        case kBigHospital:
            if (!bigHospitalFlag) {
                bigHospitalFlag = [[UIImageView alloc] initWithFrame:CGRectMake(80, 66, 84, 84)];
                [bigHospitalFlag setImage:[UIImage imageNamed:@"icon1_insure_shop.png"]];
            }
            [bigHospitalFlag setAlpha:1];
            [self addSubview:bigHospitalFlag];
            
            [[bigHospitalFlag layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
            [[bigHospitalFlag layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
        

            
            break;
        default:
            break;
    }
    
    [CATransaction commit];
}
- (void)back
{
    if (_hospitalOnShow == kEndHospital) {
        [self backToStart];
    }else{
        [self backNormal];
    }

}
- (void)backNormal
{
    [UIView animateWithDuration:0.5 animations:^{
        
        switch (_hospitalOnShow) {
            case kSmallHospital:
                [smallHospitalView setAlpha:0];
                break;
            case kPrivateHospital:
                [privateHospitalView setAlpha:0];
                break;
            case kBigHospital:
                [bigHospitalView setAlpha:0];
                break;
            default:
                break;
        }
        [bgImg setAlpha:1];
        if (bigHospitalClicked) {
            [bigHospitalBtn setEnabled:NO];
            [bigHospital setAlpha:0.3];
        }else{
            [bigHospitalBtn setEnabled:YES];
            [bigHospital setAlpha:1];
        }
        if (smallHospitalClicked) {
            [smallHospitalBtn setEnabled:NO];
            [smallHospital setAlpha:0.3];
        }else{
            [smallHospitalBtn setEnabled:YES];
            [smallHospital setAlpha:1];
        }
        if (privateHospitalClicked) {
            [privateHospitalBtn setEnabled:NO];
            [privateHospital setAlpha:0.3];
        }else{
            [privateHospitalBtn setEnabled:YES];
            [privateHospital setAlpha:1];
        }
        
        
        
    } completion:^(BOOL finished) {
        
        switch (_hospitalOnShow) {
            case kSmallHospital:
                [smallHospitalView removeFromSuperview];
                smallHospitalView = nil;
                break;
            case kPrivateHospital:
                
                [privateHospitalView removeFromSuperview];
                privateHospitalView = nil;
                
                break;
            case kBigHospital:
                
                [bigHospitalView removeFromSuperview];
                bigHospitalView  = nil;
                
                break;
            default:
                break;
        }
        
        [self flagAnimateWithHositalBtn:_hospitalOnShow];
        [self setHospitalBtnStatus];
        
        self.hospitalOnShow = kNoneHospital;
    }];

}
- (void)stopMyAnimate
{
    switch (_hospitalOnShow) {
        case kBigHospital:
            [bigHospitalView setAlpha:1];
            break;
        case kPrivateHospital:
            [privateHospitalView setAlpha:1];
       case kSmallHospital:
            [smallHospitalView setAlpha:1];
            break;
        default:
            break;
    }
    
    [bigHospital setAlpha:0];
    [smallHospital setAlpha:0];
    [privateHospital setAlpha:0];
    [bgImg setAlpha:0];
    
}
- (void)setHospitalBtnStatus
{
    
    if(bigHospitalClicked&&smallHospitalClicked&&privateHospitalClicked)
    {
        //show the end page
        [self performSelector:@selector(showTheEndView) withObject:nil afterDelay:1];
        
    }else{
       
        _hospitalOnShow = kNoneHospital;
        if (aniTimer) {
            [aniTimer invalidate];
            aniTimer = nil;
        }
        aniTimer = [NSTimer scheduledTimerWithTimeInterval:1.4 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    }
}
- (void)showTheEndView
{
    [self initEndHospital];
    _hospitalOnShow = kEndHospital;
    [UIView animateWithDuration:0.5 animations:^{
        [endHosipitalView setAlpha:1];
    }completion:^(BOOL finished) {
        
        [_delegate setDatawithHospital:kEndHospital];
        [endHosipitalView startAnimate];
    }];
}
-(void)initEndHospital
{
    if (!endHosipitalView) {
        endHosipitalView = [[HospitalEndView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
        [endHosipitalView setDelegate:self];
    }
    [endHosipitalView setAlpha:0];
    [self addSubview:endHosipitalView];
}
- (void)backToStart
{
    [privateHospitalFlag removeFromSuperview];
    [bigHospitalFlag removeFromSuperview];
    [smallHospitalFlag removeFromSuperview];
    bigHospitalClicked = NO;
    privateHospitalClicked = NO;
    smallHospitalClicked = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [endHosipitalView setAlpha:0];
        [bgImg setAlpha:1];
        [bigHospitalBtn setEnabled:YES];
        [bigHospital setAlpha:1];
        [smallHospitalBtn setEnabled:YES];
        [smallHospital setAlpha:1];
        [privateHospitalBtn setEnabled:YES];
        [privateHospital setAlpha:1];
        
    } completion:^(BOOL finished) {
        [endHosipitalView removeFromSuperview];
        endHosipitalView  = nil;
        self.hospitalOnShow = kNoneHospital;
        if (aniTimer) {
            [aniTimer invalidate];
            aniTimer = nil;
        }

        aniTimer = [NSTimer scheduledTimerWithTimeInterval:1.4 target:self selector:@selector(animation) userInfo:nil repeats:YES];

    }];
   
    
}
- (void)envelopeOpened
{
    [_delegate restartBtnAppear];
}
@end
