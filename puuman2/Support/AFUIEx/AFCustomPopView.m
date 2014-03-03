//
//  AFCustomPopView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFCustomPopView.h"
#import "MainTabBarController.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation AFCustomPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 704, 608)];
        [bgImgView setImage:[UIImage imageNamed:@"bg_subpage.png"]];
        [_content addSubview:bgImgView];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:PMColor6];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:PMFont1];
        [_content addSubview:_titleLabel];
        
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [_content addSubview:icon];
        
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title withIcon:(UIImage *)image
{
    CGSize size = [title sizeWithFont:PMFont1];
    [_titleLabel setText:title];
    if (!image) {
        [_titleLabel setFrame:CGRectMake((704- size.width)/2, 36, size.width, 24)];
    }else{
        [icon setImage:image];
        SetViewLeftUp(icon,(704- size.width-4-24)/2,36 );
        [_titleLabel setFrame:CGRectMake(icon.frame.origin.x +2+24, 36, size.width, 24)];
    }
}

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(32, 16, 704, 608)];
    

}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
     [_content setFrame:CGRectMake(160, 16, 704, 608)];
    
}

- (void)setControlBtnType:(ControlBtnType)controlBtnType
{
    _controlBtnType = controlBtnType;
    switch (controlBtnType) {
        case kCloseAndFinishButton:
        {
            [self initFinishBtn];
            [self initCloseBtn];
        }
            
            break;
        case kOnlyFinishButton:
            [self initFinishBtn];
            break;
        case kOnlyCloseButton:
            [self initCloseBtn];
            break;
        case kNoneButton:
            break;
        default:
            break;
    }
    
}

- (void)initCloseBtn
{
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(32, 24, 48, 48)];
    [_closeBtn setImage:[UIImage imageNamed:@"btn_close1.png"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_closeBtn];
}

- (void)initFinishBtn
{
    _finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(624, 24, 48, 48)];
    [_finishBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
    [_finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_finishBtn];
}

- (void)closeBtnPressed
{
     [self hidden];
}

- (void)finishBtnPressed
{
     [self hidden];
}



- (void)show
{
    [_content showInFrom:kAFAnimationTop inView:self withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
}

- (void)hidden
{
     [_content hiddenOutTo:kAFAnimationTop inView:self withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
    [self removeFromSuperview];
}
@end
