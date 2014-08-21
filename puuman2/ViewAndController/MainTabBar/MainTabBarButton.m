//
//  MainTabBarButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarButton.h"
#import "UniverseConstant.h"

static NSString *selectedBtnSelectedImageName[4] = {@"btn_diary1_diary.png",@"btn_look1_diary.png", @"btn_shop1_diary.png", @"btn_set2_diary.png" };
static NSString *unselectedBtnImageName[4] = {@"btn_diary2_diary.png",@"btn_look2_diary.png", @"btn_shop2_diary.png", @"btn_set2_diary.png" };

@implementation MainTabBarButton
@synthesize selected = _selected;
@synthesize delegate = _delegate;
@synthesize flagTag = _flagTag;
@synthesize  animate = _animate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _animate = YES;
        _flagTag = kTypeTabBarOfSkip;
        flagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 31, 37, 18)];
        [self addSubview:flagImageView];
        [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)pressed
{
    [_delegate clickAFButtonWithButton:self];
}

- (void)setSelected:(BOOL)selected
{
    [super selected];
    if (_animate) {
        if (selected) {
            self.enabled = NO;
            //if (_selectedImage)
            [flagImageView setImage:[UIImage imageNamed:selectedBtnSelectedImageName[_flagTag-1]]];
            [UIView animateWithDuration:MainTabBarButtonanimateTime animations:^{
                SetViewLeftUp(flagImageView, 14, 31);
            } completion:^(BOOL finished) {
            
            }];
            
        }else{
            //if (_normalImage)
            [flagImageView setImage:[UIImage imageNamed:unselectedBtnImageName[_flagTag-1]]];
            [UIView animateWithDuration:MainTabBarButtonanimateTime animations:^{
                SetViewLeftUp(flagImageView, 7, 31);
            } completion:^(BOOL finished) {
                self.enabled = YES;
            }];
            
        }

    }else{
        if (selected) {
            self.enabled = NO;
            SetViewLeftUp(flagImageView, 14, 31);
            [flagImageView setImage:[UIImage imageNamed:selectedBtnSelectedImageName[_flagTag-1]]];
        }else{
            SetViewLeftUp(flagImageView, 7, 31);
            [flagImageView setImage:[UIImage imageNamed:unselectedBtnImageName[_flagTag-1]]];
            self.enabled = YES;
            
        }

    }
}




@end
