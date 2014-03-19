//
//  AllTopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllTopicView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation AllTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    leftBtn = [[TopicSelectButton alloc] init];
    [self addSubview:leftBtn];
    rightBtn = [[TopicSelectButton alloc] init];
    [self addSubview:rightBtn];
}

- (void)setVerticalFrame
{
    SetViewLeftUp(rightBtn, 480, 0);
}

- (void)setHorizontalFrame
{
    SetViewLeftUp(rightBtn, 736, 0);
}


@end
