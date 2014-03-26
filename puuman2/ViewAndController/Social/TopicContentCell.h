//
//  TopicContentCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"
#import "TopicSelectButton.h"
#import "ColorButton.h"
#import "TopicAllTableViewController.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "Forum.h"
#import "AFSelecedTextImgButton.h"

@protocol TopicContentCellDelegate;
@interface TopicContentCell : UITableViewCell<ForumDelegate>
{
    UIImageView *bgImageView;
    UILabel *info_title;
    UILabel *info_num;
    TopicSelectButton *leftBtn;
    TopicSelectButton *rightBtn;
    ColorButton *toNewestBtn;
    ColorButton *rewardBtn;
    ColorButton *participateBtn;
    ColorButton *initiateBtn;
    TopicAllTableViewController *topicAllVC;
    BOOL currentTopicOrAfter;
    TopicStatus status;
    Topic *_topic;
    AFSelecedTextImgButton *left_sortBtn;
    AFSelecedTextImgButton *right_sortBtn;
    BOOL leftSelected;
}
@property(nonatomic,assign)id<TopicContentCellDelegate>delegate;
-(void)setInfoViewWithTopicNum:(NSInteger)topicNum;
- (void)rightSortSelected;
- (void)leftSortSelected;
@end

@protocol TopicContentCellDelegate <NSObject>

- (void)nextTopic;
- (void)preTopic;

@end