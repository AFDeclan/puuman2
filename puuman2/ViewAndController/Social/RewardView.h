//
//  RewardView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardView : UIView
{
    UIImageView *bg_rewardView;
    UILabel *info_title;
    UILabel *info_rank;
}

- (void)setRewardWithRanking:(NSInteger)rank andReward:(NSString *)reward;
@end
