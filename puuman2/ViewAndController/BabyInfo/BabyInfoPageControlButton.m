//
//  BabyInfoPageControlButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoPageControlButton.h"

@implementation BabyInfoPageControlButton
@synthesize isFold = _isFold;
@synthesize isLeft = _isLeft;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        [bgImgView setFrame:CGRectMake(0, 0, 40, 80)];
        [iconImgView setFrame:CGRectMake(12, 26, 16, 28)];
        _isFold = YES;
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 40, 80)];
}

- (void)foldWithDuration:(NSTimeInterval)time
{
    _isFold = YES;
    [self setEnabled:NO];
    [UIView animateWithDuration:0.5 animations:^{
        iconImgView.transform = CGAffineTransformMakeRotation(0);
    }completion:^(BOOL finished) {
        [self setEnabled:YES];
    }];
}
- (void)unfoldWithDuration:(NSTimeInterval)time
{
    _isFold = NO;
    [self setEnabled:NO];
    [UIView animateWithDuration:0.5 animations:^{
         iconImgView.transform = CGAffineTransformMakeRotation(M_PI);
    }completion:^(BOOL finished) {
        [self setEnabled:YES];
    }];
}

- (void)setIsLeft:(BOOL)isLeft
{
    _isLeft = isLeft;
    if (isLeft) {
        [self setWithbgImage:[UIImage imageNamed:@"btn_circle_baby.png"] andIconImage:[UIImage imageNamed:@"tri_white_right.png"]];
    }else{
        [self setWithbgImage:[UIImage imageNamed:@"btn_circle2_baby.png"] andIconImage:[UIImage imageNamed:@"tri_white_left.png"]];
    }
}

@end
