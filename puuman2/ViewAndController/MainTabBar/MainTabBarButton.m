//
//  MainTabBarButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarButton.h"
#import "UniverseConstant.h"

@implementation MainTabBarButton
@synthesize selected = _selected;
@synthesize selectedImage = _selectedImage;
@synthesize normalImage = _normalImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _normalImage = nil;
        _selectedImage = nil;
        flag = [[UIImageView alloc] initWithFrame:CGRectMake(7, 31, 37, 18)];
        [self addSubview:flag];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        self.enabled = NO;
        if (_selectedImage) [flag setImage:_selectedImage];
        [UIView animateWithDuration:animateTime animations:^{
            SetViewLeftUp(flag, 14, 31);
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        if (_normalImage) [flag setImage:_normalImage];
        [UIView animateWithDuration:animateTime animations:^{
            SetViewLeftUp(flag, 7, 31);
        } completion:^(BOOL finished) {
            self.enabled = YES;
        }];
        
    }
}

- (void)setSelected:(BOOL)selected withAnimate:(BOOL)animate
{
    if (animate) {
        [self setSelected:selected];
    }else{
        _selected = selected;
        if (selected) {
            self.enabled = NO;
            SetViewLeftUp(flag, 14, 31);
            [flag setImage:_selectedImage];
        }else{
            
            SetViewLeftUp(flag, 7, 31);
            [flag setImage:_normalImage];
            self.enabled = YES;

        }
    }
 
}

@end
