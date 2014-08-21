//
//  RankTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "Rank.h"
#import "Friend.h"
#import "AFTextImgButton.h"

@interface RankTableViewCell : UITableViewCell<FriendDelegate>
{
    UIImageView *rank_icon;
    AFImageView *portrait;
    UILabel *info_name;
    UIScrollView *info_scroll;
    UIImageView *icon_sex;
    UIImageView *icon_reply;
    UIImageView *icon_like;
    UILabel *info_reply;
    UILabel *info_like;
    UILabel *total;
    NSTimer *timer;
    BOOL scrollDir;
}

@property(nonatomic,assign)NSInteger row;

@end
