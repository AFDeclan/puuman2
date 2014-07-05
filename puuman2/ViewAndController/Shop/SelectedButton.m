//
//  SelectedButton.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-5-6.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "SelectedButton.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "UILabel+AdjustSize.h"

@implementation SelectedButton
@synthesize delegate = _delegate;
@synthesize titleLabel = _titleLabel;
@synthesize icon = _icon;
@synthesize type = _type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        bgSelectedView = [[UIView alloc] initWithFrame:CGRectMake(-frame.size.height, 0, frame.size.width+frame.size.height, frame.size.height)];
        [self addSubview:bgSelectedView];
        bgSelectedView.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds = YES;
        [bgSelectedView setBackgroundColor:[UIColor clearColor]];
        _icon = [[UIImageView alloc] init];
        [bgSelectedView addSubview:_icon];
        _type = kSelectedRight;
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:PMFont2];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [bgSelectedView addSubview:_titleLabel];
        
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width+frame.size.height, frame.size.height)];
        [maskView setBackgroundColor:[UIColor blackColor]];
        [bgSelectedView addSubview:maskView];
         bgSelectedView.layer.masksToBounds = YES;
        [maskView setAlpha:0];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [maskView setAlpha:0.3];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [maskView setAlpha:0];
    [_delegate selectedButtonSelectedWithButton:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [maskView setAlpha:0];

}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [bgSelectedView setBackgroundColor:backgroundColor];
}

- (void)adjustSize
{
    [_titleLabel adjustSize];
    switch (_type) {
        case kSelectedLeft:
        {
            SetViewLeftUp(_icon, (self.frame.size.width- ViewWidth(_titleLabel) -ViewWidth(_icon))/2 , (self.frame.size.height - ViewHeight(_icon))/2);
            SetViewLeftUp(_titleLabel,ViewX(_icon) +ViewWidth(_icon)+ 8,  (self.frame.size.height - ViewHeight(_titleLabel))/2);

        }
            break;
        case kSelectedRight:
        {
            SetViewLeftUp(_icon, (self.frame.size.width- ViewWidth(_titleLabel) -ViewWidth(_icon))/2 +self.frame.size.height, (self.frame.size.height - ViewHeight(_icon))/2);
            SetViewLeftUp(_titleLabel,ViewX(_icon) +ViewWidth(_icon)+ 8,  (self.frame.size.height - ViewHeight(_titleLabel))/2);

        }
            break;
        default:
            break;
    }
   }

- (void)setType:(SelectedButtonType)type
{
    _type = type;
    switch (type) {
        case kSelectedRight:
        {
            SetViewLeftUp(bgSelectedView, -self.frame.size.height, 0);
        }
            break;
        case kSelectedLeft:
        {
             SetViewLeftUp(bgSelectedView, 0, 0);
        }
            break;
        default:
            break;
    }
}
@end
