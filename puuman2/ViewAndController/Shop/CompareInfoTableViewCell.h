//
//  CompareInfoTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareInfoTableViewCell : UITableViewCell
{
    UILabel *leftContent;
    UILabel *middleContent;
    UILabel *rightContent;
}
- (void)buildCompareCellWithKeyName:(NSString *)key value1:(NSString *)v1 value2:(NSString *)v2;

@end
