//
//  HeightPartnerDataCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyPartnerDataCell : UITableViewCell
{
    UIView *histogram;
    UILabel *date_info;
    UILabel *data_info;
    UIView *mask;
}

- (void)setBodyData:(float)body andTheDate:(NSDate *)date andHighest:(float)highest andLowest:(float)lowest;
@end
