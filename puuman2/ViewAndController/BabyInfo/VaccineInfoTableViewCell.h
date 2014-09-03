//
//  VaccineInfoTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VaccineInfoTableViewCell : UITableViewCell 
{
    UIImageView *icon_status;
    UIImageView *time_line;
    UILabel *label_status;
    UILabel *info_date;
    UILabel *info_name;
    UILabel *info_age;
    UIImageView *partLine;
}
- (void)setVaccineIndex:(NSInteger)index;


@end
