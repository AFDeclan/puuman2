//
//  VotingCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicInfoView.h"
#import "ColorButton.h"

@interface VotingCell : UITableViewCell
{
    BasicInfoView *infoView;
    UILabel *votingTopic;
    UILabel *votedNum;
    ColorButton *voteBtn;
    UIView *bgView;
}
@end
