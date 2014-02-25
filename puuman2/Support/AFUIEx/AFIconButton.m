//
//  AFIconButton.m
//  puuman2
//
//  Created by Declan on 14-2-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFIconButton.h"
#import "UILabel+AdjustSize.h"
#import "AFUICode.h"

@implementation AFIconButton
{
    UILabel *_titleLabel;
    UIImageView *_iconView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        [self addSubview:_iconView];
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
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

- (void)setTitleStr:(NSString *)titleStr
{
    [_titleLabel setText:titleStr];
    [self adjustLayout];
}

- (void)setIconImg:(UIImage *)iconImg
{
    [_iconView setImage:iconImg];
    [self adjustLayout];
}

- (NSString *)titleStr
{
    return _titleLabel.text;
}

- (UIImage *)iconImg
{
    return _iconView.image;
}

@end
