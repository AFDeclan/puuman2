//
//  RewardViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFColorButton.h"
#import "Forum.h"
#import "TopicCellSelectedPohosViewController.h"
#import "NewTextDiaryViewController.h"
#import "NewCameraViewController.h"

@interface RewardViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate,ForumDelegate,SelectPhotoDelegate,PopViewDelegate>
{
    AFColorButton *instructionBtn;
    AFColorButton *createBtn;
    UITableView *rewardTable;
    UITableView *rankTable;
    UILabel *empty_rank;
    UILabel *noti_label;
    UILabel *timeLabel1, *timeLabel2;
    NSTimer * timer;
}


@end