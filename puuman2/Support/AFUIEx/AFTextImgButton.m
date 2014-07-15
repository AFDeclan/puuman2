//
//  AFTextImgButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"
#import "UILabel+AdjustSize.h"
#import "UniverseConstant.h"

@implementation AFTextImgButton
@synthesize title = _title;
@synthesize iconImg = _iconImg;
@synthesize iconSize = _iconSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initalization];
    }
    return self;
}

- (void)initalization
{
    iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [_title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_title];
    [self setBackgroundColor:[UIColor clearColor]];
  

}


- (void)setIconImg:(UIImage *)iconImg
{
    _iconImg = iconImg;
    [iconView setImage:iconImg];
    
}

- (void)setIconSize:(CGSize)iconSize
{
    _iconSize = iconSize;
    [iconView setFrame:CGRectMake(0, 0, iconSize.width, iconSize.height)];
    
}

- (void)adjustLayout
{
    [_title adjustSize];
    if (iconView.image) {
        CGFloat contentWidth = ViewWidth(iconView) + 2 + ViewWidth(_title);
        CGFloat x = ( ViewWidth(self) - contentWidth ) / 2;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(iconView, x, y);
        x = x + ViewWidth(iconView) + 2;
        SetViewLeftCenter(_title, x, y);
    } else {
        CGFloat contentWidth = ViewWidth(_title);
        CGFloat x = ( ViewWidth(self) - contentWidth ) / 2;
        CGFloat y = ViewHeight(self)/2;
        SetViewLeftCenter(_title, x, y);
    }

}

- (void)setIconLocation:(CGPoint)pos
{
    SetViewLeftUp(iconView, pos.x, pos.y);
}


@end
