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

@interface DiaryViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIButton *newDiaryBtn[5];
    DiaryNewButton *newBtn;
    BOOL isFirst;
    NSTimer *timer;
    JoinView *joinView;
    UIView *activeNewestView;
    DiaryTableViewController *diaryTableVC;
}
@property (assign,nonatomic) BOOL cameraModel;
+ (DiaryViewController *)sharedDiaryViewController;
- (void)hideNewDiaryBtns;
- (void)showNewDiaryBtns;
- (void)showNewDiaryBtnPressed;
- (void)hideNewDiaryBtnPressed;
- (void)showNewDiaryViewWithType:(NewButtonType)type withTaskInfo:(NSDictionary *)info;
- (void)setTaskInfo:(NSDictionary *)taskInfo;

@end
