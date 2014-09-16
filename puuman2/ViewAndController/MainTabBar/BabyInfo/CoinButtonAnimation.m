//
//  CoinButtonAnimation.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-9-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CoinButtonAnimation.h"
#import "UniverseConstant.h"
#import "DiaryViewController.h"

@interface CoinButtonAnimation ()
{
    BOOL displayingPrimary;

}

@end

@implementation CoinButtonAnimation
@synthesize primaryView = _primaryView,secondaryView = _secondaryView,spinTime;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        displayingPrimary = YES;
        spinTime = 0.1;
    }
    return self;
}



- (id) initWithPrimaryView:(UIView *)primaryView andSecondaryView:(UIView *)secondaryView inFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.primaryView = primaryView;
        self.secondaryView = secondaryView;
        displayingPrimary = YES;
        spinTime = 0.1;
    }
    return self;
}

- (void) setPrimaryView:(UIView *)primaryView{
    _primaryView = primaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.primaryView setFrame: frame];
    [self roundView: self.primaryView];
    self.primaryView.userInteractionEnabled = YES;
    [self addSubview: self.primaryView];
    [self roundView:self];
}

- (void) setSecondaryView:(UIView *)secondaryView{
    _secondaryView = secondaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.secondaryView setFrame: frame];
    [self roundView: self.secondaryView];
    self.secondaryView.userInteractionEnabled = YES;
    [self addSubview: self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
    [self roundView:self];
}

- (void) roundView: (UIView *) view{
    [view.layer setCornerRadius: (self.frame.size.height/2)];
    [view.layer setMasksToBounds:YES];
}

- (void)coinAnimationSecond
{
    [UIView animateWithDuration:0.3 animations:^{
        self.secondaryView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.secondaryView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.secondaryView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }];
        
    }];

}

-(void)showAnimationCoinView{
    [UIView transitionFromView:(displayingPrimary ? self.primaryView : self.secondaryView)
                        toView:(displayingPrimary ? self.secondaryView : self.primaryView)
                      duration: 0.4
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                    
                    [self coinAnimationSecond];

                  }];
     [self performSelector:@selector(coinAnimationBack) withObject:nil afterDelay:1];

}

- (void)coinAnimationBack
{
        [UIView transitionFromView:(displayingPrimary ? self.secondaryView : self.primaryView)
                            toView:(displayingPrimary ? self.primaryView : self.secondaryView)
                          duration:0.8 options: UIViewAnimationOptionTransitionFlipFromLeft + UIViewAnimationOptionCurveEaseInOut
                       completion:^(BOOL finished){
                           
                    
                           if ([_deledate respondsToSelector:@selector(updateBytes)]) {
                
                               [_deledate updateBytes];
                               [[DiaryViewController sharedDiaryViewController] refreshToosView];
                           
                           }
                           
                       }];
}






@end
