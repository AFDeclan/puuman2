//
//  MyTopicView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MyTopicView.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"

@implementation MyTopicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        topicAllVC = [[MyTopicViewController alloc] initWithNibName:nil bundle:nil];
        [topicAllVC.view setBackgroundColor:[UIColor clearColor]];
        [self addSubview:topicAllVC.view];
        if([MainTabBarController sharedMainViewController].isVertical)
        {
            [self setVerticalFrame];
        }else
        {
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)reloadMyTopic
{
    [topicAllVC reloadMyTopic];
}

- (void)setVerticalFrame
{
    [topicAllVC.view setFrame:CGRectMake(0, 0, 608, 800)];
}

- (void)setHorizontalFrame
{
    [topicAllVC.view setFrame:CGRectMake(128, 0, 608, 800)];
}

@end
