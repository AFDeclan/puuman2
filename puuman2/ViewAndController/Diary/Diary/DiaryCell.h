//
//  DiaryCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsAndFonts.h"
#import "DiaryModel.h"
#import "UniverseConstant.h"
#import "DateFormatter.h"
#import "BabyData.h"
#import "NSDate+Compute.h"
#import "UILabel+AdjustSize.h"
#include "UserInfo.h"

#define kHeaderHeight    36
#define kFooterHeight    24
#define ContentWidth  512
@interface DiaryCell : UITableViewCell
{
    UILabel *_fromLabel;
    UILabel *_dateLabel;
    UIView *_timeLine;
    UIImageView *_icon_from;
    UIImageView *dividingLine;
    //age
    UILabel *_ageLabel1;
    UILabel *_ageLabel2;
    UILabel *_ageLabel3;
    UIButton *_delBtn, *_shareBtn;
    UIScrollView *_delScrollView;
    BOOL delConfirm;
    UIView *_content;
    UIView *bg;
}

@property (retain,nonatomic) NSDictionary* diaryInfo;
@property (strong,nonatomic) NSIndexPath *indexPath;
+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr;
- (void)share:(id)sender;
- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr;
@end
