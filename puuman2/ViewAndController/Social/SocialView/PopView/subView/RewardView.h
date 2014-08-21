//
//  RewardView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"

@interface RewardView : UIView
{
    AFImageView *bg_rewardView;
    UILabel *info_title;
    UILabel *info_rank;
}

- (void)setRewardWithRanking:(NSInteger)rank andReward:(NSString *)reward andBgUrl:(NSString *)url;
@end
