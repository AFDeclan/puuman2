//
//  RewardTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardView.h"

@interface RewardTableViewCell : UITableViewCell
{
   
    RewardView *leftReward;
    RewardView *rightReward;
    
}
@property(nonatomic,assign)NSInteger row;
@end
