//
//  PuumanPartnerDataCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PuumanPartnerDataCell : UITableViewCell
{
    UIImageView *rank_icon;
    UILabel *puuman_label;
    UIView *line;
}
@property(nonatomic,assign)BOOL showLine;
- (void)setPumanWithNum:(float)puumanNum andRank:(NSInteger)rank;
@end
