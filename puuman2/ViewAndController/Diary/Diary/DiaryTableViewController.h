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


@interface DiaryTableViewController : UITableViewController<TaskClickDelegate,TextDiaryDelegate>
{
    NSIndexPath *selectedPath;
    DiaryCell *_activeCell;
    BOOL dragging;
}
- (void)diaryLoaded;

- (void)tapWithPoint:(CGPoint)pos;
+ (BOOL)needLoadInfo;

@end
