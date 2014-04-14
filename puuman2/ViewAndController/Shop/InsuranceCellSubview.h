//
//  InsuranCellSubview.h
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceInfoViewController.h"

@interface InsuranceCellSubview : UIView<PopViewDelegate>
{
    UIImageView *_insuranceImageView;
    UIImageView *_maskView;
    UILabel *_nameLabel;
    NSDictionary *_insurance;
}
- (void)setInsurance:(NSDictionary *)insurance;
@end
