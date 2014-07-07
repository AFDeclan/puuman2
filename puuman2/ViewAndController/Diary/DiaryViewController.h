//
//  DiaryViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryNewButton.h"
#import "DiaryTableViewController.h"
#import "JoinView.h"
#import "CalenderControlView.h"
#import "ToolsView.h"

@interface DiaryViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIButton *newDiaryBtn[5];
    DiaryNewButton *newBtn;
    BOOL isFirst;
    NSTimer *timer;
    JoinView *joinView;
    CalenderControlView *calenderView;
    DiaryTableViewController *diaryTableVC;
    ToolsView *toolsView;
}
@property (assign,nonatomic) BOOL cameraModel;

+ (DiaryViewController *)sharedDiaryViewController;
- (void)showDiaryAtIndex:(NSInteger) index;
- (void)hideNewDiaryBtns;
- (void)showNewDiaryBtns;
- (void)showNewDiaryBtnPressed;
- (void)hideNewDiaryBtnPressed;
- (void)showNewDiaryViewWithType:(NewButtonType)type withTaskInfo:(NSDictionary *)info;
- (void)setTaskInfo:(NSDictionary *)taskInfo;
- (void)refresh;
- (void)diaryLoaded;
- (void)refreshTable;
- (void)setImportTotalNum:(NSInteger)num;
- (void)autoImportShowed;
@end
