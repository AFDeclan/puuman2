//
//  TopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicView.h"
#import "MainTabBarController.h"

@implementation TopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)selectedAll
{
    if (!allTopic) {
        allTopic = [[AllTopicView alloc] initWithFrame:CGRectZero];
        [self addSubview:allTopic];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    [allTopic setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [allTopic setAlpha:1];
        if (myTopic) {
            [myTopic setAlpha:0];
        }
    }];
}

- (void)selectedMine
{
    if (!myTopic) {
        myTopic = [[MyTopicView alloc] initWithFrame:CGRectZero];
        [self addSubview:myTopic];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    [myTopic setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [myTopic setAlpha:1];
        if (allTopic) {
            [allTopic setAlpha:0];
        }
    }];
    
}

- (void)setVerticalFrame
{
    if (myTopic) {
        [myTopic setFrame:CGRectMake(0, 0, 608, 944)];
        [myTopic setVerticalFrame];
    }
    
    if (allTopic) {
        [allTopic setFrame:CGRectMake(0, 0, 608, 944)];
        [allTopic setVerticalFrame];
    }
}

- (void)setHorizontalFrame
{
    if (myTopic) {
        [myTopic setFrame:CGRectMake(0, 0, 864, 688)];
        [myTopic setHorizontalFrame];
    }
    
    if (allTopic) {
        [allTopic setFrame:CGRectMake(0, 0, 864, 688)];
        [allTopic setHorizontalFrame];
    }
}

@end
