//
//  HospitalEndView.m
//  puman
//
//  Created by 祁文龙 on 13-12-21.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HospitalEndView.h"
#import "ColorsAndFonts.h"

@implementation HospitalEndView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}
-(void)initialization
{
    bgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [bgView setBackgroundColor:RGBColor(141, 194, 236)];
    [self addSubview:bgView];
     envelope =[[UIImageView alloc] initWithFrame:CGRectMake(62, -354, 515, 354)];
    [envelope setImage:[UIImage imageNamed:@"pic35_insure_shop.png"]];
    [self addSubview:envelope];
     arrow =[[UIImageView alloc] initWithFrame:CGRectMake(350, 165, 74, 54)];
    [arrow setAlpha:0];
    [arrow setImage:[UIImage imageNamed:@"pic36_insure_shop.png"]];
    [arrow setAnimationImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"pic36_insure_shop.png"],[UIImage imageNamed:@"pic39_insure_shop.png"], nil] ];
    [arrow setAnimationRepeatCount:0];
    [arrow setAnimationDuration:0.5];
    [self addSubview:arrow];
    arrowBtn =[[UIButton alloc] initWithFrame:arrow.frame];
    [arrowBtn setAlpha:0];
    [arrowBtn addTarget:self action:@selector(envelopeOpened:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:arrowBtn];
    
    envelopeBg =[[UIImageView alloc] initWithFrame:CGRectMake(93, 0, 453, 109)];
    [envelopeBg setImage:[UIImage imageNamed:@"pic38_insure_shop.png"]];
    [envelopeBg setAlpha:0];
    [self addSubview:envelopeBg];
    letter =[[UIImageView alloc] initWithFrame:CGRectMake(101, 22, 438, 315)];
    [letter setImage:[UIImage imageNamed:@"pic34_insure_shop.png"]];
    [letter setAlpha:0];
    [self addSubview:letter];
    verticalenvelope =[[UIImageView alloc] initWithFrame:CGRectMake(93, 109, 454, 245)];
    [verticalenvelope setImage:[UIImage imageNamed:@"pic37_insure_shop.png"]];
    [verticalenvelope setAlpha:0];
    [self addSubview:verticalenvelope];
}
- (void)envelopeOpened:(UIButton *)sender
{

    [arrow stopAnimating];
    [_delegate envelopeOpened];
    [UIView animateWithDuration:1 animations:^{
        [arrow setAlpha:0];
        [arrowBtn setAlpha:0];
        [letter setAlpha:1];
        [envelope setAlpha:0];
        [verticalenvelope setAlpha:1];
        [envelopeBg setAlpha:1];
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:1 animations:^{
           [verticalenvelope setFrame:CGRectMake(93, 469, 454, 245)];
           [envelopeBg setFrame:CGRectMake(93,360, 453, 109)];
       }];
    }];
}
-(void)startAnimate
{
    [UIView animateWithDuration:1 animations:^{
        [envelope setFrame:CGRectMake(62, 3, 515, 354)];
    }completion:^(BOOL finished) {
        [arrow setAlpha:1];
        [arrowBtn setAlpha:1];
        [arrow startAnimating];
    }];
    
    
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
