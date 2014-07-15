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
#import "UniverseConstant.h"
#import "MemberCache.h"
#import "Member.h"

@implementation TopicContentCell
@synthesize delegate = _delegate;
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
    
    bgImageView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 144)];
    [self addSubview:bgImageView];
     leftSelected = YES;
    noti_current = [[UILabel alloc] initWithFrame:CGRectMake(208, 24, 320, 28)];
    [noti_current setBackgroundColor:[UIColor clearColor]];
    [noti_current setFont:PMFont2];
    [noti_current setTextColor:PMColor3];
    [noti_current setText:@"本期话题"];
    [self addSubview:noti_current];
    [noti_current setAlpha:0];
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(208, 48, 320, 28)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setFont:PMFont1];
    [info_title setTextColor:PMColor1];
    [self addSubview:info_title];
    info_upload = [[UILabel alloc] initWithFrame:CGRectMake(208, 76, 320, 20)];
    [info_upload setBackgroundColor:[UIColor clearColor]];
    [info_upload setFont:PMFont2];
    [info_upload setTextColor:PMColor3];
    [self addSubview:info_upload];
    rewardBtn = [[AFColorButton alloc] init];
    [rewardBtn.title setText:@"奖励"];
    [rewardBtn setIconImg:[UIImage imageNamed:@"icon_prize_topic.png"]];
    [rewardBtn setIconSize:CGSizeMake(16, 16)];
    [rewardBtn setColorType:kColorButtonGrayColor];
    [rewardBtn setDirectionType:kColorButtonLeftUp];
    [rewardBtn resetColorButton];
    [rewardBtn addTarget:self action:@selector(reward) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rewardBtn];
    participateBtn = [[AFColorButton alloc] init];
    [participateBtn.title setText:@"参与"];
    [participateBtn setIconImg:[UIImage imageNamed:@"icon_join_topic.png"]];
    [participateBtn setIconSize:CGSizeMake(16, 16)];
    [participateBtn setColorType:kColorButtonBlueColor];
    [participateBtn setDirectionType:kColorButtonLeftDown];
    [participateBtn resetColorButton];
    [participateBtn addTarget:self action:@selector(participate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:participateBtn];
    toNewestBtn = [[AFColorButton alloc] init];
    [toNewestBtn.title setText:@"本期"];
    [toNewestBtn setIconImg:[UIImage imageNamed:@"icon_present_topic.png"]];
    [toNewestBtn setIconSize:CGSizeMake(16, 16)];
    [toNewestBtn setColorType:kColorButtonBlueColor];
    [toNewestBtn setDirectionType:kColorButtonLeftDown];
    [toNewestBtn resetColorButton];
    [toNewestBtn addTarget:self action:@selector(currentTopic) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:toNewestBtn];
    initiateBtn = [[AFColorButton alloc] init];
    [initiateBtn.title setText:@"发起"];
    [initiateBtn setIconImg:[UIImage imageNamed:@"icon_start_topic.png"]];
    [initiateBtn setIconSize:CGSizeMake(16, 16)];
    [initiateBtn setColorType:kColorButtonBlueColor];
    [initiateBtn setDirectionType:kColorButtonLeftDown];
    [initiateBtn resetColorButton];
    [initiateBtn addTarget:self action:@selector(initiate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:initiateBtn];
    [initiateBtn setAlpha:0];
    [rewardBtn setAlpha:0];
    [toNewestBtn setAlpha:0];
    [participateBtn setAlpha:0];
    
    topicAllVC = [[TopicAllTableViewController alloc] initWithNibName:nil bundle:nil];
    [topicAllVC.view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:topicAllVC.view];
    
    right_sortBtn = [[AFSelectedTextImgButton alloc] initWithFrame:CGRectMake(304, 0, 304, 24)];
    [right_sortBtn addTarget:self action:@selector(rightSortSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right_sortBtn];
    
    left_sortBtn = [[AFSelectedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 304, 24)];
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

    [rightBtn setVerticalFrame];
    [leftBtn setVerticalFrame];
    self.frame = CGRectMake((_topicNum-1)*608, 0, 608, 944);
    SetViewLeftUp(rightBtn, 480, 0);
    [topicAllVC setVerticalFrame];
    SetViewLeftUp(bgImageView, 0, 0);
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
    [rightBtn setHorizontalFrame];
    [leftBtn setHorizontalFrame];
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


    self.frame = CGRectMake((_topicNum-1)*864, 0, 864, 688);
    SetViewLeftUp(rightBtn, 736, 0);
    [topicAllVC.view setFrame:CGRectMake(128, 168, 608, 520)];
    SetViewLeftUp(right_sortBtn, 432, 144);
    SetViewLeftUp(left_sortBtn, 128, 144);
    SetViewLeftUp(bgImageView, 128, 0);
    [topicAllVC setHorizontalFrame];
    
}

-(void)setInfoViewWithTopicNum:(NSInteger)topicNum
{
//    PostNotification(Noti_RemoveFriendDelegate, nil);
    _topicNum = topicNum;
    [[Forum sharedInstance] addDelegateObject:self];
    [[Friend sharedInstance] addDelegateObject:self];
    if (topicNum == 1 ) {
        [leftBtn setAlpha:0];
    }else{
        [leftBtn setAlpha:1];
    }
    
    if(topicNum > [[Forum sharedInstance] onTopic].TNo)
    {
        [noti_current setAlpha:0];

        status = TopicStatus_Voting;
        [rightBtn setAlpha:0];
        [leftBtn setNoti:@""];
        [leftBtn setTitleName:@"本期话题"];
        [info_title setText:[NSString stringWithFormat:@"第%d期话题征集中",topicNum]];
        [info_title setTextColor:PMColor6];
        [info_upload setText:@"发起或投票选出你最喜欢的话题吧！"];
        [topicAllVC setVoting:YES];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"]];
        [right_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_like2_topic.png"]];
        [right_sortBtn.title setText:@"最多投票"];
        [right_sortBtn adjustLayout];
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"]];
        [left_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_time2_topic.png"]];
        [left_sortBtn.title setText:@"最新发起"];
        [left_sortBtn adjustLayout];
        [self leftSortSelected];
        if([MainTabBarController sharedMainViewController].isVertical)
        {
            [self setVerticalFrame];
        }else
        {
            [self setHorizontalFrame];
        }
        
        [bgImageView setImage:[UIImage imageNamed:@"pic_future_topic.png"]];
        
        
    }else{
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"]];
        [right_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_like2_topic.png"]];
        [right_sortBtn.title setText:@"最多喜欢"];
        [right_sortBtn adjustLayout];
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"]];
        [left_sortBtn setUnSelectedImg:[UIImage imageNamed:@"icon_time2_topic.png"]];
        [left_sortBtn.title setText:@"最新参与"];
        [left_sortBtn adjustLayout];

        [topicAllVC setVoting:NO];
        [info_title setTextColor:PMColor1];
        [rightBtn setAlpha:1];
       
        if ([[Forum sharedInstance] onTopic].TNo == topicNum) {
            [noti_current setAlpha:1];

            _topic = [[Forum sharedInstance] onTopic];
            [rightBtn setAlpha:1];
            [rightBtn setTitleName:@"征集!"];
            [leftBtn setTitleName:@"回顾！"];
            status= TopicStatus_On;
            [info_title setText:[[Forum sharedInstance] onTopic].TTitle];
            [bgImageView getImage:[_topic TImgUrl] defaultImage:nil];
            status = _topic.TStatus;
            [info_title setText:_topic.TTitle];
            [topicAllVC setTopic:_topic];
            [self leftSortSelected];
            
            
        }else{
            [noti_current setAlpha:0];

            [rightBtn setAlpha:1];
            [rightBtn setNoti:@"下期话题"];
            [leftBtn setNoti:@"往期话题"];
              status= TopicStatus_Past;
            [leftBtn setNoti:@""];
            [leftBtn setTitleName:[NSString stringWithFormat:@"第%ld期", (long)topicNum-1]];
            [rightBtn setNoti:@""];
            [rightBtn setTitleName:[NSString stringWithFormat:@"第%ld期", (long)topicNum+1]];
            if ([[Forum sharedInstance] getTopic:topicNum]) {
                
                _topic = [[Forum sharedInstance] getTopic:topicNum];
                [bgImageView getImage:[_topic TImgUrl] defaultImage:nil];
                status = _topic.TStatus;
                [info_title setText:_topic.TTitle];
                [topicAllVC setTopic:_topic];
                [self leftSortSelected];
            }
        }
        [info_upload setText:@""];
        Member *member_upload = [[MemberCache sharedInstance] getMemberWithUID:_topic.TUploadUID];
        if (member_upload) {
            if ([member_upload babyInfo].Nickname && ![[member_upload babyInfo].Nickname isEqualToString:@""]) {
                [info_upload setText:[NSString stringWithFormat:@"该话题由%@发起",[member_upload babyInfo].Nickname]];
            }
        }
        

        if([MainTabBarController sharedMainViewController].isVertical)
        {
            [self setVerticalFrame];
        }else
        {
            [self setHorizontalFrame];
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

    [participateBtn setEnabled:NO];
    TopicType type =[[[Forum sharedInstance] onTopic] TType];
    switch (type) {
        case TopicType_Photo:
        {
            TopicCellSelectedPohosViewController *chooseView = [[TopicCellSelectedPohosViewController alloc] initWithNibName:nil bundle:nil];
            [[MainTabBarController sharedMainViewController].view addSubview:chooseView.view];
           [chooseView setStyle:ConfirmError];
            [chooseView setSelecedDelegate:self];
            [chooseView show];
        }
            break;
        case TopicType_Text:
        {
            NewTextDiaryViewController *textVC = [[NewTextDiaryViewController alloc] initWithNibName:nil bundle:nil];
            [[MainTabBarController sharedMainViewController].view addSubview:textVC.view];
            [textVC setControlBtnType:kCloseAndFinishButton];
            [textVC setTitle:@"文本" withIcon:nil];
            [textVC setIsTopic:YES];
            [textVC setDelegate:self];
            [textVC show];
        }
            break;
        default:
            break;
    }


}

- (void)popViewfinished
{
    [participateBtn setEnabled:YES];
}

- (void)selectedViewhidden
{
    [participateBtn setEnabled:YES];
}

- (void)currentTopic
{
    PostNotification(Noti_GoToCurrentTopic, nil);
}

- (void)initiate
{
    CreateTopicViewController *initiateVC = [[CreateTopicViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:initiateVC.view];
    [initiateVC setControlBtnType:kOnlyCloseButton];
    [initiateVC setTitle:@"发起话题" withIcon:nil];
    [initiateVC showKeyBoard];
    [initiateVC show];
    
}

//往期话题获取成功。
- (void)topicReceived:(Topic *)topic
{
    _topic = topic;
    [bgImageView getImage:[_topic TImgUrl] defaultImage:nil];
    status = _topic.TStatus;
 //   [info_num setText:[NSString stringWithFormat:@"已有%d人参与",_topic.TNo]];
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
    if (status == TopicStatus_Voting) {
        [topicAllVC setVoteOrder:VotingTopicOrder_Time];
    }else{
        [topicAllVC setReplyOrder:TopicReplyOrder_Time];
    }
    [left_sortBtn selected];
    [right_sortBtn unSelected];
    [topicAllVC.tableView reloadData];
}

- (void)rightSortSelected
{
    if (status == TopicStatus_Voting) {
        [topicAllVC setVoteOrder:VotingTopicOrder_Vote];
    }else{
        [topicAllVC setReplyOrder:TopicReplyOrder_Vote];
    
    }
    [right_sortBtn selected];
    [left_sortBtn unSelected];
    [topicAllVC.tableView reloadData];
}

- (void)dealloc
{
}

- (void)memberDownloaded:(Member *)member
{
    if ([member belongsTo:_topic.TUploadUID]) {
        if ([member babyInfo].Nickname && ![[member babyInfo].Nickname isEqualToString:@""]) {
            [info_upload setText:[NSString stringWithFormat:@"该话题由%@发起",[member babyInfo].Nickname]];
        }
    }
    
}
//Member数据下载失败
- (void)memberDownloadFailed
{

}

@end
