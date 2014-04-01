//
//  RewardView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RewardView.h"
#import "ColorsAndFonts.h"

static NSString *ranks[5] = {@"一等奖",@"二等奖",@"三等奖",@"四等奖",@"五等奖"};

@implementation RewardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        bg_rewardView = [[AFImageView alloc] init];
        [bg_rewardView setAlpha:0.5];
        [bg_rewardView setBackgroundColor:PMColor6];
        [self addSubview:bg_rewardView];
        info_title = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 0)];
        [info_title setBackgroundColor:[UIColor clearColor]];
        [self addSubview:info_title];
        info_rank= [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 0)];
        [info_rank setBackgroundColor:[UIColor clearColor]];
        [self addSubview:info_rank];

        
    }
    return self;
}

- (void)setRewardWithRanking:(NSInteger)rank andReward:(NSString *)reward  andBgUrl:(NSString *)url
{
    [bg_rewardView getImage:url defaultImage:@""];
    [info_title setTextColor:PMColor2];
    [info_rank setTextColor:PMColor3];
    [info_rank setFont:PMFont2];
    [info_rank setText:ranks[rank-1]];
    [info_title setText:reward];
    if (rank == 1) {
        [info_title setFont:PMFont1];
    }else{
        [info_title setFont:PMFont2];
    }
    
    if (rank == 1) {
        [info_title setFrame:CGRectMake(0, 48, self.frame.size.width-16, 24)];
        [info_title setTextAlignment:NSTextAlignmentRight];
        [info_rank setFrame:CGRectMake(0, 84, self.frame.size.width-16, 16)];
        [info_rank setTextAlignment:NSTextAlignmentRight];
    }else if (rank == 4 ||rank == 5) {
        [info_title setFrame:CGRectMake(0, 24, self.frame.size.width, 16)];
        [info_title setTextAlignment:NSTextAlignmentCenter];
        [info_rank setFrame:CGRectMake(0, 48, self.frame.size.width, 16)];
        [info_rank setTextAlignment:NSTextAlignmentCenter];
    }else{
        [info_title setFrame:CGRectMake(0, 24, self.frame.size.width-16, 24)];
        [info_title setTextAlignment:NSTextAlignmentRight];
        [info_rank setFrame:CGRectMake(0, 48, self.frame.size.width-16, 16)];
        [info_rank setTextAlignment:NSTextAlignmentRight];
    }
    
    [bg_rewardView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    

}
@end
