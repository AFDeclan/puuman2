//
//  DetailSortTableViewCell.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortCell.h"

@interface DetailSortTableViewCell : UITableViewCell
{
    SortCell *subCell[2];
}
@property(nonatomic,assign)NSInteger row;
@end
