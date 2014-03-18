//
//  PuumanOutBookCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PuumanOutBookCell : UITableViewCell
{
    UIImageView *out_icon;
    UILabel *label_out;
    UILabel *label_date;
    UILabel *label_title;
    UILabel *label_status;
}
- (void)setBookInfo:(NSDictionary *)bookInfo;
@end
