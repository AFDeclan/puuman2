//
//  PuumanInBookCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PuumanInBookCell : UITableViewCell
{
    
    UIImageView *in_icon;
    UILabel *label_in;
    UILabel *label_staus;
    UILabel *label_date;
}
- (void)setBookInfo:(NSDictionary *)bookInfo;
@end
