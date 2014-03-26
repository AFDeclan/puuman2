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
#import "RewardViewController.h"
#import "CreateTopicViewController.h"


@implementation TopicContentCell
@synthesize delegate = _delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[Forum sharedInstance] addDelegateObject:self];
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
     leftSelected = YES;
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(208, 48, 320, 28)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setFont:PMFont1];
    [info_title setTextColor:PMColor1];
    [self addSubview:info_title];
    info_num = [[UILabel alloc] initWithFrame:CGRectMake(208, 76, 320, 20)];
    [info_num setBackgroundColor:[UIColor clearColor]];
    [info_num setFont:PMFont2];
    [info_num setTextColor:PMColor3];
    [self addSubview:info_num];
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
    [initiateBtn addTarget:self action:@selector(initiate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:initiateBtn];
    topicAllVC = [[TopicAllTableViewController alloc] initWithNibName:nil bundle:nil];
    [topicAllVC.view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:topicAllVC.view];
    right_sortBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 24)];
    [right_sortBtn addTarget:self action:@selector(rightSortSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right_sortBtn];
    
    left_sortBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 304, 24)];
    [left_sortBtn addTarget:self action:@selector(leftSortSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left_sortBtn];
    
    leftBtn = [[TopicSelectButton alloc] init];
    [leftBtn addTarget:self action:@selector(preTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    [leftBtn setDirection:NO];
    rightBtn = [[TopicSelectButton alloc] init];
    [rightBtn addTarget:self action:@selector(nextTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn setDirection:YES];
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
            [topicAllVC.view setFrame:CGRectMake(0, 264, 608, 688)];
            SetViewLeftUp(right_sortBtn, 304, 240);
            SetViewLeftUp(left_sortBtn, 0, 240);
        }
            break;
        case TopicStatus_Past:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:1];
            [initiateBtn setAlpha:0];
            SetViewLeftUp(toNewestBtn, 496, 152);
             [topicAllVC.view setFrame:CGRectMake(0, 224, 608, 728)];
            SetViewLeftUp(right_sortBtn, 304, 200);
            SetViewLeftUp(left_sortBtn, 0, 200);
        }
            break;
        case TopicStatus_Voting:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:0];
            [initiateBtn setAlpha:1];
            SetViewLeftUp(initiateBtn, 496, 152);
            [topicAllVC.view setFrame:CGRectMake(0, 224, 608, 728)];
            SetViewLeftUp(right_sortBtn, 304, 200);
            SetViewLeftUp(left_sortBtn, 0, 200);
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
            
            
        }
            break;
        case TopicStatus_Past:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:1];
            [initiateBtn setAlpha:0];
            [rightBtn setNoti:@""];
            [leftBtn setNoti:@""];
            SetViewLeftUp(toNewestBtn,752, 168);
           
        }
            break;
        case TopicStatus_Voting:
        {
            [rewardBtn setAlpha:0];
            [participateBtn setAlpha:0];
            [toNewestBtn setAlpha:0];
            [initiateBtn setAlpha:1];
            [rightBtn setAlpha:0];
            [leftBtn setNoti:@""];
            SetViewLeftUp(initiateBtn,752, 168);
         
        }
            break;
        default:
            break;
    }


    self.frame = CGRectMake(0, 0, 864, 688);
    SetViewLeftUp(rightBtn, 736, 0);
    [topicAllVC.view setFrame:CGRectMake(128, 168, 608, 520)];
    SetViewLeftUp(right_sortBtn, 432, 144);
    SetViewLeftUp(left_sortBtn, 128, 144);
    [topicAllVC setHorizontalFrame];
    
}

-(void)setInfoViewWithTopicNum:(NSInteger)topicNum
{
    
    if (topicNum == 1 ) {
        [leftBtn setAlpha:0];
    }else{
        [leftBtn setAlpha:1];
    }
    
 
    
    if(topicNum > [[Forum sharedInstance] onTopic].TNo)
    {
        status = TopicStatus_Voting;
        [rightBtn setAlpha:0];
        [leftBtn setNoti:@""];
        [leftBtn setTitleName:@"本期话题"];
        [info_title setText:[NSString stringWithFormat:@"第%d期话题征集中",topicNum]];
        [info_title setTextColor:PMColor6];
        [info_num setText:@"发起或投票选出你最喜欢的话题吧！"];
        [topicAllVC setVoting:YES];
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_like2_topic.png"] andTitle:@"最多投票" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_time2_topic.png"] andTitle:@"最新发起" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [self leftSortSelected];
        if([MainTabBarController sharedMainViewController].isVertical)
        {
            [self setVerticalFrame];
        }else
        {
            [self setHorizontalFrame];
        }
        
        
        
        
    }else{
        
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_like2_topic.png"] andTitle:@"最多喜欢" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_time2_topic.png"] andTitle:@"最新参与" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
         [topicAllVC setVoting:NO];
        [info_title setTextColor:PMColor1];
         [rightBtn setAlpha:1];
        if ([[Forum sharedInstance] getTopic:topicNum]) {
            _topic = [[Forum sharedInstance] getTopic:topicNum];
            status = _topic.TStatus;
            [info_num setText:[NSString stringWithFormat:@"已有%d人参与",_topic.TNo]];
            [info_title setText:_topic.TTitle];
            [topicAllVC setTopic:_topic];
            [self leftSortSelected];
            if([MainTabBarController sharedMainViewController].isVertical)
            {
                [self setVerticalFrame];
            }else
            {
                [self setHorizontalFrame];
            }
            
        }
        
       
        if ([[Forum sharedInstance] onTopic].TNo == topicNum) {
            [rightBtn setAlpha:1];
            [rightBtn setNoti:@"下期话题"];
            [leftBtn setNoti:@"往期话题"];
            [rightBtn setTitleName:@"征集!"];
            [leftBtn setTitleName:@"回顾！"];
            status= TopicStatus_On;
            [info_title setText:[[Forum sharedInstance] onTopic].TTitle];
            [info_num setText:[NSString stringWithFormat:@"已有%d人参与",[[Forum sharedInstance] onTopic].TNo]];
            
        }else{
            
            
            [info_num setText:[NSString stringWithFormat:@"第%d期",topicNum]];
            [leftBtn setNoti:@""];
            [leftBtn setTitleName:[NSString stringWithFormat:@"第%d期",topicNum-1]];
            [rightBtn setNoti:@""];
            [rightBtn setTitleName:[NSString stringWithFormat:@"第%d期",topicNum+1]];
            
        }
  
       

    }


   
    
}



- (void)preTopic
{
    [_delegate preTopic];
    
}

- (void)nextTopic
{
    [_delegate nextTopic];
}


- (void)reward
{
    RewardViewController *rewardVC = [[RewardViewController alloc] initWithNibName:nil bundle:nil];
    [rewardVC setTitle:@"本月奖励" withIcon:nil];
    [rewardVC setControlBtnType:kOnlyCloseButton];
    [[MainTabBarController sharedMainViewController].view addSubview:rewardVC.view];
    [rewardVC show];
    
}




-(void)participate
{

}


- (void)currentTopic
{
 
    

}

- (void)initiate
{
    CreateTopicViewController *initiateVC = [[CreateTopicViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:initiateVC.view];
    [initiateVC setControlBtnType:kOnlyCloseButton];
    [initiateVC setTitle:@"发起话题" withIcon:nil];
    [initiateVC show];
    
}

//往期话题获取成功。
- (void)topicReceived:(Topic *)topic
{
    _topic = topic;
    status = _topic.TStatus;
    [info_num setText:[NSString stringWithFormat:@"已有%d人参与",_topic.TNo]];
    [info_title setText:_topic.TTitle];
    [topicAllVC setTopic:_topic];
    [self leftSortSelected];
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
    
}

//往期话题获取失败
- (void)topicFailed:(NSString *)TNo
{

}


- (void)leftSortSelected
{
    
    [left_sortBtn selected];
    [right_sortBtn unSelected];
}

- (void)rightSortSelected
{
    [right_sortBtn selected];
    [left_sortBtn unSelected];
}

@end
