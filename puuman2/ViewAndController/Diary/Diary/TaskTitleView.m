//
//  TaskTitleView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TaskTitleView.h"
#import "ColorsAndFonts.h"
#include "UserInfo.h"
#import "TaskCell.h"
const NSTimeInterval AnimatedInterval = 0.3;
@implementation TaskTitleView
@synthesize folded = _folded;
@synthesize taskIndex = _taskIndex;
@synthesize taskInfo = _taskInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    portraitView =[[AFImageView alloc] initWithFrame:CGRectMake(8, 8, 96, 96)];
    [portraitView setBackgroundColor:[UIColor clearColor]];
    [portraitView getImage:[[UserInfo sharedUserInfo] portraitUrl] defaultImage:@""];
    portraitView.layer.cornerRadius = 48;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius =0.1;
    [self addSubview:portraitView];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(128, 0, 456, 112)];
    [title setFont:PMFont1];
    [title setTextColor:PMColor1];
    [self addSubview:title];
    _taskIndex = 0;
    
    pointView =[[UIImageView alloc] initWithFrame:CGRectMake(596, 48, 28, 16)];
    [pointView setImage:[UIImage imageNamed:@"tri_blue_down.png"]];
    pointView.alpha = 0;
    [self addSubview:pointView];
    
    controlBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 640, 112)];
    [controlBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:controlBtn];
    [controlBtn addTarget:self action:@selector(foldOrUnfold) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)foldOrUnfold
{
    [[TaskCell sharedTaskCell] foldOrUnfold];
}

- (void)reloadPortrait
{
    [portraitView getImage:[[UserInfo sharedUserInfo] portraitUrl] defaultImage:default_portrait_image];
}

- (void)unfold
{
    _folded = NO;
    [controlBtn setFrame:CGRectMake(528, 0, 112, 112)];
    controlBtn.enabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        pointView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        controlBtn.enabled = YES;
        
    }];
    [_timer invalidate];
    _timer = nil;
}

- (void)foldWithAnmate:(BOOL)animate
{
     [controlBtn setFrame:CGRectMake(0, 0, 640, 112)];
    title.text =[_taskInfo objectForKey:_task_Name];
    _folded = YES;
    controlBtn.enabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        pointView.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        controlBtn.enabled = YES;
    }];
    [self loadTask];
    if (!_timer&&animate)
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextTask) userInfo:nil repeats:YES];
    
}

- (void)nextTask
{
    [UIView animateWithDuration:AnimatedInterval animations:^{
        title.alpha = 0;
    }completion:^(BOOL finished){
        [self changeTask:1];
        [UIView animateWithDuration:AnimatedInterval animations:^{
            title.alpha = 1;
        }];
    }];
    
}

- (void)loadTask
{
    TaskModel *model = [TaskModel sharedTaskModel];
    if ([model taskCount] == 0)
    {
        if ([model nowTasksFailed])
        {
            title.text = @"任务加载失败，点此重新加载。";
        }
        else if ([model nowTasksReady])
        {
            title.text = @"您已完成本阶段所有任务，真棒~";
        }
        else if ([model updating])
        {
            title.text = @"任务加载中...";
        }
        else {
            title.text = @"未登录";
        }
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            pointView.alpha = 1;
        }];
        NSDictionary *taskInfo = [model nowTaskAtIndex:_taskIndex];
        title.text = [taskInfo objectForKey:_task_Name];
    }
    [self reloadPortrait];
}

- (void)setTitle:(NSString *)title_
{
    [title setText:title_];
}

- (void)changeTask:(NSInteger)step
{
    NSInteger taskCount = [[TaskModel sharedTaskModel] taskCount];
    if (taskCount == 0)
    {
        [self loadTask];
        return;
    }
    _taskIndex = _taskIndex + step + taskCount;
    _taskIndex = _taskIndex % taskCount;
    [self loadTask];
}
@end
