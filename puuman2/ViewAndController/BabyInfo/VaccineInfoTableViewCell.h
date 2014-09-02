//
//  VaccineInfoTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VaccineCellDelegate;
@interface VaccineInfoTableViewCell : UITableViewCell
{
    UIImageView *icon_status;
    UIImageView *time_line;
    UILabel *label_status;
    UILabel *info_date;
    UILabel *info_name;
    UILabel *info_age;
    UIImageView *partLine;
    UIView *dateView;
    UIDatePicker *datePicker;
    BOOL canUnFold;
    UIButton *selectedBtn;

}
@property(nonatomic,assign)id<VaccineCellDelegate> delegate;
@property(nonatomic,assign)NSInteger vacIndex;
@end

@protocol VaccineCellDelegate <NSObject>

- (void)saveBtnClick:(NSInteger)index;
- (void)cancelBtnClick:(NSInteger)index;
- (void)selectedBtnClick:(NSInteger)index withCanUnFold:(BOOL)unFold;

@end