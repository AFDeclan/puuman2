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
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(128, 0, 608, 144)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:NO];
    [self addSubview:_showColumnView];
    [_showColumnView setContentOffset:CGPointMake(608*4, 0)];
    
}

- (void)preTopic
{
   CGPoint point = _showColumnView.contentOffset;
    
}

- (void)nextTopic
{
    CGPoint point = _showColumnView.contentOffset;
}

- (void)setVerticalFrame
{
    SetViewLeftUp(rightBtn, 480, 0);
    SetViewLeftUp(rewardBtn, 496, 152);
    SetViewLeftUp(participateBtn, 496, 192);
}

- (void)setHorizontalFrame
{
    SetViewLeftUp(rightBtn, 736, 0);
    SetViewLeftUp(rewardBtn, 752, 168);
    SetViewLeftUp(participateBtn, 752, 208);
}

- (void)reward
{

}

-(void)participate
{
    
}


#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{

    
}



- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 608;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return 10;
    
}



- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
        NSString * cellIdentifier = @"topicShowedCell";
        TopicShowedCell *cell = (TopicShowedCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[TopicShowedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        return cell;
}

@end
