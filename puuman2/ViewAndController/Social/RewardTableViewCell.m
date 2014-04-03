//
//  RewardTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RewardTableViewCell.h"
#import "Forum.h"
#import "Award.h"

@implementation RewardTableViewCell
@synthesize row = _row;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        leftReward = [[RewardView alloc] init];
        [self addSubview:leftReward];
        rightReward = [[RewardView alloc] init];
        [self addSubview:rightReward];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRow:(NSInteger)row
{
    _row = row;
    Award *myAward =  [[[Forum sharedInstance] awards] objectAtIndex:row];
    
//    if (row == 3) {
//        [rightReward setAlpha:1];
//        [leftReward setFrame:CGRectMake(0, 10, 188, 86)];
//        [rightReward setFrame:CGRectMake(196, 10, 188, 86)];
//        [leftReward setRewardWithRanking:4 andReward:@"扑满存钱罐"];
//        [rightReward setRewardWithRanking:5 andReward:@"扑满存钱罐"];
//        
//    }else{
        [rightReward setAlpha:0];
        if (row == 0) {
              [leftReward setFrame:CGRectMake(0, 0, 384, 160)];
        }else{
              [leftReward setFrame:CGRectMake(0, 10, 384, 86)];
        }
        [leftReward setRewardWithRanking:[myAward ALevel] andReward:[myAward AName] andBgUrl:[myAward AImgUrl]];
  //  }
  
}



@end
