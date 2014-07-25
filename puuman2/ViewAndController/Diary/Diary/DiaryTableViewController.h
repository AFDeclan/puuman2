//
//  DiaryTableViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCell.h"
#import "DiaryCell.h"
#import "TextDiaryCell.h"
#import "AuPhotoDiaryCell.h"
#import "AudioDiaryCell.h"
#import "VideoDiaryCell.h"
#import "PhotoSingleDiaryCell.h"
#import "PhotoMoreDiaryCell.h"
#import "DiaryProgressHeaderView.h"

@interface DiaryTableViewController : UITableViewController<TaskClickDelegate,TextDiaryDelegate>
{
    NSIndexPath *selectedPath;
    DiaryCell *_activeCell;
    int importNum;
    int importTotalNum;
    DiaryProgressHeaderView *importProgress;
    DiaryProgressHeaderView *headerview;
    BOOL dragging;
    BOOL show;
}
- (void)diaryLoaded;
- (void)setImportTotalNum:(NSInteger)num;
- (void)tapWithPoint:(CGPoint)pos;
- (void)autoImportShowed;
+ (BOOL)needLoadInfo;

@end
