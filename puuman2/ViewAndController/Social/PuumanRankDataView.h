//
//  PuumanRankDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PuumanRankDataView : UIView
{
    UIImageView *rank_icon;
    UILabel *puuman_label;
}

- (void)setPumanWithNum:(float)puumanNum andRank:(NSInteger)rank;
@end
