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

typedef enum{
    kDiaryTextType,
    kDiaryPhotoType,
    kDiaryAudioType,
    kDiaryPhotoAudioType,
    kDiaryVideoType
} DiaryType;

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
    UIButton  *_shareBtn;
    BOOL delConfirm;
    UIView *_content;
    UIView *bg;
    BOOL delCanShow;
    BOOL shareCanShow;
}
@property (assign, nonatomic)DiaryType diaryType;
@property (strong, nonatomic)UIButton *delBtn;
@property (strong, nonatomic)UIScrollView *delScrollView;
@property (retain,nonatomic) NSDictionary* diaryInfo;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (assign,nonatomic) BOOL controlCanHidden;
+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr;
- (void)share:(id)sender;
- (void)delBtnReset;
- (void)showAndHideControlBtnWithHidden:(BOOL)isHidden;
- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr;
@end
