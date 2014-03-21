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
    [leftBtn addTarget:self action:@selector(preTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    rightBtn = [[TopicSelectButton alloc] init];
    [rightBtn addTarget:self action:@selector(nextTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    rewardBtn = [[ColorButton alloc] init];
    [rewardBtn initWithTitle:@"奖励" andIcon:[UIImage imageNamed:@"icon_prize_topic.png"] andButtonType:kGrayLeftUp];
    [rewardBtn addTarget:self action:@selector(reward) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rewardBtn];
    participateBtn = [[ColorButton alloc] init];
    [participateBtn initWithTitle:@"参与" andIcon:[UIImage imageNamed:@"icon_join_topic.png"] andButtonType:kBlueLeftDown];
    [participateBtn addTarget:self action:@selector(participate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:participateBtn];

    topicAllVC = [[TopicAllTableViewController alloc] initWithNibName:nil bundle:nil];
    [topicAllVC.view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:topicAllVC.view];
  
}

- (void)preTopic
{
  
    
}

- (void)nextTopic
{
   
}

- (void)setVerticalFrame
{
    SetViewLeftUp(rightBtn, 480, 0);
    SetViewLeftUp(rewardBtn, 496, 152);
    SetViewLeftUp(participateBtn, 496, 192);
    [topicAllVC setVerticalFrame];
    
}

- (void)setHorizontalFrame
{
    SetViewLeftUp(rightBtn, 736, 0);
    SetViewLeftUp(rewardBtn, 752, 168);
    SetViewLeftUp(participateBtn, 752, 208);
    [topicAllVC setHorizontalFrame];
}

- (void)reward
{

}

-(void)participate
{
    
}



@end
