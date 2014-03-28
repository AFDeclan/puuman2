//
//  InsuranceCell.h
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsuranceCellSubview;
@interface InsuranceCell : UITableViewCell
{
    NSArray *_insurances;
    InsuranceCellSubview *_insuranceView[3];
}

- (void)setInsurances:(NSArray *)insurances;
@end
