//
//  BodyInfoTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyInfoTableViewCell : UITableViewCell
{
    UIImageView *icon;
    UILabel *info_age;
    UILabel *info_height;
    UILabel *info_weight;
    UILabel *label_weight;
    UILabel *label_height;
    UILabel *info_date;
}

@property(nonatomic,assign) NSInteger infoIndex;
@end
