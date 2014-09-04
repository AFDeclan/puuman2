//
//  VaciPopoverContentViewController.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-9-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VaccineDateDelegate;

@interface VaciPopoverContentViewController : UIViewController
{
    UIDatePicker *datePicker;
}

@property(nonatomic,assign)id<VaccineDateDelegate> vaccineDelegate;
@property(nonatomic,assign)NSInteger vacIndex;

@end
@protocol VaccineDateDelegate <NSObject>

- (void)saveVacBtnClick:(NSInteger)index;
- (void)cancelVacBtnClick;
@end
