//
//  TopicCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "BasicInfoView.h"
#import "Reply.h"
#import "AFSelecedTextImgButton.h"
#import "ChatInputViewController.h"
#import "Forum.h"

@interface TopicCell : UITableViewCell<ForumDelegate>
{
    BasicInfoView *infoView;
    UILabel *info_time;
    UIView *headerView;
    UIView *contentView;
    UIView *footerView;
    AFSelecedTextImgButton *likeBtn;
    AFTextImgButton *replayBtn;
    UILabel *relayExample;
    AFTextImgButton *scanMoreReplay;
    UILabel *title_label;
    Reply *_replay;
    
}
- (void)buildWithReply:(Reply *)replay;
+ (CGFloat)heightForReplay:(Reply *)replay;
@end
