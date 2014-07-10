//
//  AgeBornPreTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgeBornPreTableViewCell : UITableViewCell
{
    
    UILabel *labels[7];
    UITapGestureRecognizer *gestureRecognizer[7];
    NSInteger weekNum;
}
- (void)buildWeekWithCurrentIndex:(NSInteger)index;
@end
