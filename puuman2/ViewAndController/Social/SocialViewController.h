//
//  SocialViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"
#import "AFSelectedImgButton.h"
#import "SocialContentView.h"
#import "TopicCellSelectedPohosViewController.h"
#import "NewCameraViewController.h"

@interface SocialViewController : UIViewController<SelectPhotoDelegate,PopViewDelegate>
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;
    AFColorButton *leftBtn;
    AFColorButton *rightBtn;
    AFSelectedImgButton *topicBtn;
    AFSelectedImgButton *partnerBtn;
    SocialContentView *contnetView;
    BOOL selectedTopic;
    
    UIButton *rewardBtn;
    UIButton *participateBtn;
    UIButton *toCurrentTopic;
    UIButton *voteBtn;
}

+ (SocialViewController *)sharedViewController;

- (void)showNewestTopic;
- (void)showPreTopic;
- (void)showVoteTopic;
@end
