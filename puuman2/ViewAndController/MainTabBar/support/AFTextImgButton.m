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
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [self setBackgroundColor:[UIColor clearColor]];
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
            
        default:
            break;
    }
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    [_titleLabel setTextColor:titleLabelColor];
}

@end
