//
//  CoinButtonAnimation.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-9-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CoinButtonAnimation : UIView

- (id)initWithPrimaryView:(UIView *)primaryView andSecondaryView:(UIView *)secondaryView inFrame:(CGRect) frame;

@property (nonatomic,retain) UIView *primaryView;
@property (nonatomic,retain) UIView *secondaryView;
@property float spinTime;

- (void)showAnimationCoinView;

@end


