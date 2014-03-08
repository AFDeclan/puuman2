//
//  TaskCell.h
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-3.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTitleView.h"
#import "TaskModel.h"
#import <MBProgressHUD.h>
#import <AVFoundation/AVFoundation.h>
#import "AFDataStore.h"
#import "ColorButton.h"

@protocol TaskClickDelegate;
@class AFPageControl;
#define kTaskCellHeight_Unfolded 352
#define kTaskCellHeight_Folded 144
#define kTaskCellWidth 672
@interface TaskCell : UITableViewCell<TaskShowDelegate,AVAudioPlayerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,AFDataStoreDelegate>
{
    TaskTitleView *taskTitle;
    UIImageView *bgImgView;

   
    UIImageView *bonusBackView;
    ColorButton *startButton;
    ColorButton *infoButton;
    UILabel *bonusLabel;
    UILabel *notiLabel;
    MBProgressHUD *_hud;
    BOOL _toStart;
    AVAudioPlayer *_player;
    NSMutableArray *_taskTextViewArr;
    UIScrollView *textScrollView;
    AFPageControl *pageControl;
    BOOL updating;
    
}
@property(nonatomic,assign)id <TaskClickDelegate> delegate;
@property(nonatomic,assign) BOOL taskFolded;
+ (TaskCell *)sharedTaskCell;

- (void)loadTask;
- (void)toStartTask:(id)sender;
- (void)nextTask;
- (void)lastTask;
- (void)showInfo:(id)sender;
- (void)reloadPortrait;
- (void)foldOrUnfold;
@end
@protocol TaskClickDelegate <NSObject>
- (void)foldOrUnfold;

@end