//
//  VaccineDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccineDataView : UIView
{
    UILabel *label_vaccine_should;
    UILabel *label_vaccine_finished;
}

- (void)setVaccineDoneNum:(NSInteger)doneNum andShouldDoneNum:(NSInteger)shouldDoneNum;
@end
