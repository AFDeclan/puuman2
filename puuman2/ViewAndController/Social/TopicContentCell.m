//
//  TopicContentCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicContentCell.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"

@implementation TopicContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initialization
{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 144)];
    [self addSubview:bgImageView];
    
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(208, 48, 320, 28)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setFont:PMFont1];
    [self addSubview:info_title];
    info_num = [[UILabel alloc] initWithFrame:CGRectMake(208, 76, 320, 20)];
    [info_num setBackgroundColor:[UIColor clearColor]];
    [info_num setFont:PMFont2];
    [info_num setTextColor:PMColor3];
    [self addSubview:info_num];
    [info_title setText:@"宝宝都有哪些糗事？"];
    [info_num setText:@"已有2035人参与"];
       rewardBtn = [[ColorButton alloc] init];
    [rewardBtn initWithTitle:@"奖励" andIcon:[UIImage imageNamed:@"icon_prize_topic.png"] andButtonType:kGrayLeftUp];
    [rewardBtn addTarget:self action:@selector(reward) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rewardBtn];
    participateBtn = [[ColorButton alloc] init];
    [participateBtn initWithTitle:@"参与" andIcon:[UIImage imageNamed:@"icon_join_topic.png"] andButtonType:kBlueLeftDown];
    [participateBtn addTarget:self action:@selector(participate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:participateBtn];
    toNewestBtn = [[ColorButton alloc] init];
    [toNewestBtn initWithTitle:@"本期" andIcon:[UIImage imageNamed:@"icon_present_topic.png"] andButtonType:kBlueLeftDown];
    [toNewestBtn addTarget:self action:@selector(currentTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:toNewestBtn];
    initiateBtn = [[ColorButton alloc] init];
    [initiateBtn initWithTitle:@"发起" andIcon:[UIImage imageNamed:@"icon_start_topic.png"] andButtonType:kBlueLeftDown];
    [initiateBtn addTarget:self action:@selector(currentTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:initiateBtn];
    topicAllVC = [[TopicAllTableViewController alloc] initWithNibName:nil bundle:nil];
    [topicAllVC.view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:topicAllVC.view];
    
    leftBtn = [[TopicSelectButton alloc] init];
    [leftBtn addTarget:self action:@selector(preTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    rightBtn = [[TopicSelectButton alloc] init];
    [rightBtn addTarget:self action:@selector(nextTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    status = TopicStatus_On;
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

- (void)setVerticalFrame
{
    self.frame = CGRectMake(0, 0, 608, 944);
    SetViewLeftUp(rightBtn, 480, 0);
    [topicAllVC setVerticalFrame];
   
    switch (status) {
        case TopicStatus_On:
        {
            [rewardBtn setAlpha:1];
            [participateBtn setAlpha:1];
            [toNewestBtn setAlpha:0];
            [initiateBtn setAlpha:0];
           
            SetViewLeftUp(rewardBtn, 496, 152);
            SetViewLeftUp(participateBtn, 496, 192);
            [topicAllVC.view setFrame:CGRectMake(0, 240, 608, 800)];
            
        }
            break;
        case TopicStatus_Past:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:1];
            [initiateBtn setAlpha:0];
            SetViewLeftUp(toNewestBtn, 496, 152);
             [topicAllVC.view setFrame:CGRectMake(0, 200, 608, 800)];
        }
            break;
        case TopicStatus_Voting:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:0];
            [initiateBtn setAlpha:1];
            SetViewLeftUp(initiateBtn, 496, 152);
            [topicAllVC.view setFrame:CGRectMake(0, 200, 608, 800)];
        }
            break;
        default:
            break;
    }
    
    self.contentView.frame = CGRectMake(0, 0, 864, 688);
    
   
    
    
}

- (void)setHorizontalFrame
{
    switch (status) {
        case TopicStatus_On:
        {
            [rewardBtn setAlpha:1];
            [participateBtn setAlpha:1];
            [toNewestBtn setAlpha:0];
            [initiateBtn setAlpha:0];
            SetViewLeftUp(rewardBtn, 752, 168);
            SetViewLeftUp(participateBtn, 752, 208);
            [topicAllVC.view setFrame:CGRectMake(0, 240, 608, 800)];
            
        }
            break;
        case TopicStatus_Past:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:1];
            [initiateBtn setAlpha:0];
            SetViewLeftUp(toNewestBtn,752, 168);
            [topicAllVC.view setFrame:CGRectMake(0, 200, 608, 800)];
        }
            break;
        case TopicStatus_Voting:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:0];
            [initiateBtn setAlpha:1];
            SetViewLeftUp(initiateBtn,752, 168);
            [topicAllVC.view setFrame:CGRectMake(0, 200, 608, 800)];
        }
            break;
        default:
            break;
    }


    self.frame = CGRectMake(0, 0, 864, 688);
    SetViewLeftUp(rightBtn, 736, 0);
    [topicAllVC.view setFrame:CGRectMake(128, 144, 608, 544)];
    [topicAllVC setHorizontalFrame];
    
}

-(void)setTitleViewWithTopic:(Topic *)topic
{
    status = topic.TStatus;
    [info_title setText:topic.TTitle];
    [info_num setText:[NSString stringWithFormat:@"已有%d人参与",topic.TNo]];
    
}
- (void)preTopic
{
    
    
}

- (void)reward
{
    
}

-(void)participate
{
    
}

- (void)nextTopic
{
    
}

- (void)currentTopic
{
 
    
}
@end
