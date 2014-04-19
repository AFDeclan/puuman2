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
        topicMyVC = [[MyTopicViewController alloc] initWithNibName:nil bundle:nil];
       [topicMyVC.view setBackgroundColor:[UIColor clearColor]];
        [self addSubview:topicMyVC.view];
        
        if([MainTabBarController sharedMainViewController].isVertical)
        {
            [self setVerticalFrame];
        }else
        {
            [self setHorizontalFrame];
        }
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];

    }
    return self;
}

- (void)reloadMyTopic
{
    [topicMyVC reloadMyTopic];
}

- (void)setVerticalFrame
{
    [topicMyVC setVerticalFrame];
    [topicMyVC.view setFrame:CGRectMake(0, 0, 608, 944)];
}

- (void)setHorizontalFrame
{
    [topicMyVC setHorizontalFrame];
    [topicMyVC.view setFrame:CGRectMake(128, 0, 608, 688)];
}

- (void)dealloc
{
    
}

@end
