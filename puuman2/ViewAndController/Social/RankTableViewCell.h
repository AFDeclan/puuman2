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

@interface RankTableViewCell : UITableViewCell
{
    UIImageView *rank_icon;
    AFImageView *portrait;
    UILabel *info_name;
    UIImageView *icon_sex;
    UIImageView *icon_reply;
    UIImageView *icon_like;
    UILabel *info_reply;
    UILabel *info_like;
    
}

- (void)buildWithRankInfo:(Rank *)rank;

@end
