//
//  AFTextImgButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"
#import "ColorsAndFonts.h"
#import "UILabel+AdjustSize.h"
#import "AFUICode.h"

@implementation AFTextImgButton
@synthesize buttonType = _buttonType;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        // Initialization code
        backgroundImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backgroundImgView];
        [backgroundImgView setBackgroundColor:[UIColor clearColor]];
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
        [self setBackgroundColor:[UIColor clearColor]];
        mark  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [mark setBackgroundColor:[UIColor blackColor]];
        [mark setAlpha:0];
        [self addSubview:mark];
    }
    return self;
}


- (void)adjustLayout
{
    [_titleLabel adjustSize];
    if (_iconView.image) {
        CGFloat contentWidth = ViewWidth(_iconView) + 2 + ViewWidth(_titleLabel);
        CGFloat x = ( ViewWidth(self) - contentWidth ) / 2;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_iconView, x, y);
        x = x + ViewWidth(_iconView) + 2;
        SetViewLeftCenter(_titleLabel, x, y);
    } else {
        CGFloat contentWidth = ViewWidth(_titleLabel);
        CGFloat x = ( ViewWidth(self) - contentWidth ) / 2;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_titleLabel, x, y);
    }
}

- (void)setTitle:(NSString *)title andImg:(UIImage *)image andButtonType:(TextImgBtnType)type;
{
    [_titleLabel setText:title];
    [_iconView setImage:image];
    btnType = type;

    switch (type) {
        case kButtonTypeOne:
        {
            [_iconView setFrame:CGRectMake(0, 0, 32, 32)];
            [_titleLabel setFont:PMFont1];
            [self adjustLayout];
        }
            break;
        case kButtonTypeTwo:
        {
            [_iconView setFrame:CGRectMake(0, 0, 16, 16)];
            [_titleLabel setFont:PMFont2];
            [self setBackgroundColor:PMColor5];
            [self adjustLayout];

        }
            break;
        case kButtonTypeThree:
        {
            [_iconView setFrame:CGRectMake(58, 32, 140, 140)];
            [_titleLabel setFrame:CGRectMake(58, 176, 140, 48)];
            [_titleLabel setFont:PMFont2];
            [self setBackgroundColor:PMColor5];
        }
            break;
        case kButtonTypeFour:
        {
            [_iconView setFrame:CGRectMake(ViewWidth(self)-24, (ViewHeight(self)-28)/2, 16, 28)];
            [_titleLabel setFont:PMFont3];
            [self setBackgroundColor:PMColor6];
            [self adjustLayoutRight];
        }
            break;
        case kButtonTypeFive:
        {
            [_iconView setFrame:CGRectMake(37, 32, 32, 22)];
            [_titleLabel setFrame:CGRectMake(0, 64, 106, 24)];
            [_titleLabel setFont:PMFont2];
            [self setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case kButtonTypeSix:
        {
            [_iconView setFrame:CGRectMake(0, 0, 16, 28)];
            [_titleLabel setFont:PMFont1];
            [self adjustLayout];
        }
            break;
        case kButtonTypeSeven:
        {
            [_iconView setFrame:CGRectMake(0, 0, 24, 24)];
            [_titleLabel setFont:PMFont1];
            [self adjustLayout];
        }
            break;
        case kButtonTypeEight:
        {
            [_iconView setFrame:CGRectMake(8, (ViewHeight(self)-12)/2, 12, 12)];
            [_titleLabel setFont:PMFont3];
            [self setBackgroundColor:[UIColor clearColor]];
           [self adjustLayoutLeft];
        }
            break;
        case kButtonTypeNine:
        {
            [_iconView setFrame:CGRectMake(0, 0, 37, 18)];
            [_titleLabel setFont:PMFont1];
            [self adjustLayout];
        }
        
            break;
        default:
            break;
    }
}

- (void)adjustLayoutVertical
{

}

- (void)adjustLayoutRight
{
    [_titleLabel adjustSize];
    if (_iconView.image) {
        CGFloat contentWidth = ViewWidth(_iconView) + 8 + ViewWidth(_titleLabel);
        CGFloat x = ViewWidth(self) - contentWidth - 8;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_titleLabel, x, y);
    } else {
        CGFloat contentWidth = ViewWidth(_titleLabel);
        CGFloat x = ViewWidth(self) - contentWidth -8;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_titleLabel, x, y);
    }
}

- (void)adjustLayoutLeft
{
    [_titleLabel adjustSize];
    if (_iconView.image) {
        CGFloat x = 8+ViewWidth(_iconView)+2;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_titleLabel, x, y);
    } else {
        CGFloat x = 8;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_titleLabel, x, y);
    }
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    [_titleLabel setTextColor:titleLabelColor];
}

- (void)selected
{
    [mark setAlpha:0.3];
}

- (void)unSelected
{
    [mark setAlpha:0];
}




@end
