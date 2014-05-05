//
//  BabyPropView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyPropView.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"


@implementation BabyPropView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // SetViewLeftUp(showAndHiddenBtn, 216, 350);
        [self initWithLeftView];
        [self initWithRightView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }

    }
    return self;
}

- (void)initWithLeftView
{
    
}

- (void)initWithRightView
{
    babyPropView = [[PropView alloc] initWithFrame:CGRectMake(0, 0, 544, 448)];
    [rightView addSubview:babyPropView];
}
- (void)refresh
{

}
-(void)setVerticalFrame
{
    [super setVerticalFrame];
    [leftView setFrame:CGRectMake(-216, 0, 256, 832)];
    [showAndHiddenBtn setAlpha:1];
    SetViewLeftUp(babyPropView, 32, 192);
   
}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [leftView setFrame:CGRectMake(0, 0, 216, 576)];
    [showAndHiddenBtn setAlpha:0];
    SetViewLeftUp(babyPropView, 160, 64);
    
}
@end
