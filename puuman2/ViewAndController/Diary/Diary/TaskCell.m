//
//  TaskCell.m
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-3.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "TaskCell.h"
#import "ColorsAndFonts.h"
#import "AFPageControl.h"
#import "TaskInfoViewController.h"
#import "AppDelegate.h"
#import "DiaryViewController.h"
#import "MainTabBarController+Hud.h"


static TaskCell * instance;

@implementation TaskCell
@synthesize taskFolded = _taskFolded;
@synthesize delegate = _delegate;

+ (TaskCell *)sharedTaskCell
{
    if (!instance)
    {
        instance = [[TaskCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [instance customInit];
    }
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)customInit
{
   
    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_diary.png"]];
    bgImgView =[[UIImageView alloc] initWithFrame:CGRectMake(16, 0, 640, 112)];
    [bgImgView setImage:[UIImage imageNamed:@"paper_task1_diary.png"]];
    [bgImgView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:bgImgView];
    
    taskTitle =[[TaskTitleView alloc] initWithFrame:CGRectMake(16, 0, 640, 112)];
    [self.contentView addSubview:taskTitle];
    
    
    _taskFolded = YES;
    updating = NO;
    notiLabel  = [[UILabel alloc] initWithFrame:CGRectMake(560, 96, 96, 16)];
    [notiLabel setFont:PMFont3];
    [notiLabel setTextColor:PMColor3];
    [notiLabel setText:@"奖励扑满金币"];
    [notiLabel setBackgroundColor:[UIColor clearColor]];
    [notiLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:notiLabel];
    bonusBackView = [[UIImageView alloc] initWithFrame:CGRectMake(576, 120, 64, 64)];
    [bonusBackView setImage:[UIImage imageNamed:@"circle_coin_diary.png"]];
    [self.contentView addSubview:bonusBackView];
    
    bonusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    bonusLabel.backgroundColor = [UIColor clearColor];
    [bonusLabel setText:@"0"];
    [bonusLabel setFont:PMFont(28)];
    [bonusLabel setTextColor:PMColor2];
    [bonusLabel setTextAlignment:NSTextAlignmentCenter];
    [bonusBackView addSubview:bonusLabel];

    
    
    infoButton = [[AFColorButton alloc] init];
    [infoButton.title setText:@"资讯"];
    [infoButton setIconImg:[UIImage imageNamed:@"icon_info_diary.png"]];
    [infoButton setIconSize:CGSizeMake(16, 16)];
    [infoButton setColorType:kColorButtonGrayColor];
    [infoButton setDirectionType:kColorButtonLeftUp];
    [infoButton resetColorButton];
    [infoButton addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:infoButton];
    SetViewLeftUp(infoButton, 544, 224);

    startButton = [[AFColorButton alloc] init];
    [startButton.title setText:@"开始"];
    [startButton setColorType:kColorButtonGrayColor];
    [startButton setDirectionType:kColorButtonLeftDown];
    [startButton resetColorButton];
    [self.contentView addSubview:startButton];
    [startButton addTarget:self action:@selector(toStartTask:) forControlEvents:UIControlEventTouchUpInside];
    SetViewLeftUp(startButton, 544, 264);

    textScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(112, 90, 416, 192)];
    [textScrollView setPagingEnabled:YES];
    [textScrollView setShowsHorizontalScrollIndicator:NO];
    [textScrollView setShowsVerticalScrollIndicator:NO];
    [textScrollView setDelegate:self];
    [textScrollView setContentSize:CGSizeMake([[TaskModel sharedTaskModel] taskCount]*416, 192)];
    [self.contentView addSubview:textScrollView];

    pageControl = [[AFPageControl alloc] initWithFrame:CGRectMake(112, 300, 416, 6)];
    pageControl.pointSize = CGSizeMake(6, 6);
    pageControl.currentPage = taskTitle.taskIndex;
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    pageControl.scrollView = textScrollView;
    [pageControl setBackgroundColor:[UIColor whiteColor]];
    [pageControl setAlpha:0.5];
    [self.contentView addSubview:pageControl];

   
    _toStart = NO;
    [TaskModel sharedTaskModel].delegate = self;
    [self loadAllTasksText];
    [self loadTask];
    [self foldWithAnmate:YES];
}

- (void)foldOrUnfold {
    
    if (!updating) {
        if ([[TaskModel sharedTaskModel] taskCount] == 0)
        {
            if ([[TaskModel sharedTaskModel] nowTasksFailed])
            {
                [[TaskModel sharedTaskModel] updateTasks];
                [taskTitle setTitle:@"任务加载中..."] ;
            }
            return;
        }
        
        if (_taskFolded)
        {
            [self unfold];
        }
        else
        {
            [self foldWithAnmate:YES];
        }
       // [_delegate foldOrUnfold];
    }

}

- (void)foldWithAnmate:(BOOL)animate
{
    [taskTitle foldWithAnmate:animate];
    _taskFolded = YES;
    textScrollView.alpha = 0;
    bonusBackView.alpha = 0;
    bonusLabel.alpha = 0;
    startButton.alpha = 0;
    infoButton.alpha = 0;
    notiLabel.alpha = 0;
    pageControl.alpha = 0;
    self.contentView.frame = CGRectMake(0, 0, kTaskCellWidth, kTaskCellHeight_Folded);
    [bgImgView setImage:[UIImage imageNamed:@"paper_task1_diary.png"]];
    [bgImgView setFrame:CGRectMake(16, 0, 640,112)];
    PostNotification(Noti_ReloadDiaryTable, nil);
}

- (void)unfold
{
    [taskTitle unfold];
    _taskFolded = NO;
    textScrollView.alpha = 1;
    bonusBackView.alpha = 1;
    bonusLabel.alpha = 1;
    startButton.alpha = 1;
    infoButton.alpha = 1;
    notiLabel.alpha = 1;
    self.contentView.frame = CGRectMake(0, 0, kTaskCellWidth, kTaskCellHeight_Unfolded);
    [bgImgView setImage:[UIImage imageNamed:@"paper_task2_diary.png"]];
    [bgImgView setFrame:CGRectMake(16, 0, 640, 320)];
    NSDictionary *taskInfo = [[TaskModel sharedTaskModel] nowTaskAtIndex:taskTitle.taskIndex];
    if ([taskInfo valueForKey:@"info"])
    {
        infoButton.alpha = 1;
    }
    pageControl.alpha = 1;
    pageControl.numberOfPages = [TaskModel sharedTaskModel].taskCount;
    pageControl.currentPage = taskTitle.taskIndex;
    [textScrollView setContentOffset:CGPointMake(taskTitle.taskIndex*416, 0)];
    PostNotification(Noti_ReloadDiaryTable, nil);
}

- (void)buildTextScrollView
{
    if (!_taskTextViewArr) _taskTextViewArr = [[NSMutableArray alloc] init];
    TaskModel *model = [TaskModel sharedTaskModel];
    for (int i = [_taskTextViewArr count]; i <[model taskCount]; i++) {
        UITextView *descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(i *416, 0, 416, 192)];
        [descriptionView setEditable:NO];
        [descriptionView setTextColor:PMColor2];
        [descriptionView setFont:PMFont2];
        [textScrollView addSubview:descriptionView];
        [_taskTextViewArr addObject:descriptionView];
    }
    [textScrollView setContentSize:CGSizeMake([model taskCount]*416, 192)];
}

- (void)loadAllTasksText
{
    [self buildTextScrollView];
    TaskModel *model = [TaskModel sharedTaskModel];
    for (int i=0; i<[model taskCount]; i++)
    {
        NSDictionary *taskInfo = [model nowTaskAtIndex:i];
        UITextView *desView = [_taskTextViewArr objectAtIndex:i];
        desView.text = [taskInfo objectForKey:_task_Description];
    }
    pageControl.numberOfPages = [[TaskModel sharedTaskModel] taskCount];
  
    
}

- (void)loadTask
{
    [taskTitle loadTask];
    TaskModel *model = [TaskModel sharedTaskModel];
    if ([model taskCount] !=0)
    {
        NSDictionary *taskInfo = [model nowTaskAtIndex:taskTitle.taskIndex];
        //[self buildTextScrollView];
        UITextView *desView = [_taskTextViewArr objectAtIndex:taskTitle.taskIndex];
        desView.text = [taskInfo objectForKey:_task_Description];
        bonusLabel.text = [taskInfo objectForKey:_task_Bonus];
        NSString *iconImageName;
        switch ([[taskInfo valueForKey:_task_TaskType] integerValue]) {
            case 1:     // 拍照
            case 4:     // 摄像
            case 6:     // 有声图
                iconImageName = @"icon_camera_diary.png";
                break;
            case 2:     // 文字任务
            case 7:     // 文字加
                iconImageName = @"icon3_task_diary.png";
                break;
            case 3:     // 录音
            case 8:     // 录音加
                iconImageName = @"icon_text_diary.png";
                break;
            default:
                iconImageName = @"";
                break;
        }
        [startButton setIconImg:[UIImage imageNamed:iconImageName]];
        [startButton setIconSize:CGSizeMake(16, 16)];
        [startButton adjustLayout];
        if ([taskInfo valueForKey:@"info"])
        {
            if (!_taskFolded) infoButton.alpha = 1;
        }
        else infoButton.alpha = 0;
    }
}

- (void)toStartTask:(id)sender
{
    TaskModel *model = [TaskModel sharedTaskModel];
    NSDictionary *taskInfo = [model nowTaskAtIndex:taskTitle.taskIndex];
    if ([taskInfo valueForKey:@"bgmfirst"])
    {
        NSData *bgmData = [[AFDataStore sharedStore] getDataFromUrl:[taskInfo valueForKey:@"bgmfirst"] delegate:self];
        _toStart = YES;
        if (bgmData)
        {
            [self playMusicWithData:bgmData];
        }
        else
        {
           // PostNotification(Noti_ShowHudCanCancel, @"音乐加载中...");
            [MainTabBarController showHudCanCancel: @"音乐加载中..."];
            [MyNotiCenter addObserver:self selector:@selector(stopDownMudic) name:Noti_HudCanceled object:nil];
        }
    }
    else [self didStartTask];
    
}


- (void)stopDownMudic
{
    [[AFDataStore sharedStore] removeDelegate:self forURL:[[[TaskModel sharedTaskModel] nowTaskAtIndex:taskTitle.taskIndex] valueForKey:@"bgmfirst"]];
}

- (void)stopPlayMusic
{
    if ([_player isPlaying]) {
        [_player stop];
        _player = nil;
    }
}
- (void)playMusicWithData:(NSData *)data
{
    //PostNotification(Noti_ShowHudCanCancel, @"请和宝宝一起欣赏音乐~");
    [MainTabBarController showHudCanCancel: @"请和宝宝一起欣赏音乐~"];
    [MyNotiCenter removeObserver:self name:Noti_HudCanceled object:nil ];
    [MyNotiCenter addObserver:self selector:@selector(stopPlayMusic) name:Noti_HudCanceled object:nil];
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    _player.delegate = self;
    if (error)
    {
        [ErrorLog errorLog:@"Task Music Download Error" fromFile:@"TaskCell.m" error:error];
        NSLog(@"Task Music Download Error: %@", error.debugDescription);
        PostNotification(Noti_ShowAlert,  @"音乐加载失败...");

        return;
    }
    [_player play];
}

- (void)didStartTask
{
    NSDictionary *taskInfo = [[TaskModel sharedTaskModel] nowTaskAtIndex:taskTitle.taskIndex];
    [[DiaryViewController sharedDiaryViewController] setTaskInfo:taskInfo];
    
}


- (void)nextTask
{
    [taskTitle changeTask:1];
    [self changeTask:1];
    
}

- (void)lastTask
{
    [taskTitle changeTask:-1];
    [self changeTask:-1];
}

- (void)showInfo:(id)sender
{
    
    TaskModel *model = [TaskModel sharedTaskModel];
    NSDictionary *taskInfo = [model nowTaskAtIndex:taskTitle.taskIndex];
    TaskInfoViewController *infoVC  = [[TaskInfoViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:infoVC.view];
    [infoVC setTitle:@"资讯" withIcon:nil];
    [infoVC setControlBtnType:kOnlyCloseButton];
    [infoVC setTaskInfo:taskInfo];
    [infoVC show];
}

- (void)changeTask:(NSInteger)step
{
    NSInteger taskCount = [[TaskModel sharedTaskModel] taskCount];
    if (taskCount == 0)
    {
        [self loadTask];
        return;
    }
    [self loadTask];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
}

//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
    pageControl.currentPage = index;
    if (index != taskTitle.taskIndex) {
        if (index > taskTitle.taskIndex) {
            [self nextTask];
        }else{
            [self lastTask];
        }
        taskTitle.taskIndex = index;
    }
}

- (void)nowTaskDownloadSucceeded
{
    
    updating = NO;
    [taskTitle removeAnimate];
    if ([[TaskModel sharedTaskModel] taskCount] <taskTitle.taskIndex+1) {
        taskTitle.taskIndex = [[TaskModel sharedTaskModel] taskCount]-1;
    }
    
    if (taskTitle.taskIndex <0) {
        taskTitle.taskIndex =0;
    }
    [self loadAllTasksText];
    [self loadTask];
    
    [self foldWithAnmate:YES];
    if (!_taskFolded)
    {
        [_delegate foldOrUnfold];
    }
  
}

- (void)taskReloding
{
    updating = YES;
    [taskTitle setTitle:@"更新中..."];
    if (!_taskFolded)
    {
        [self foldWithAnmate:NO];
        [_delegate foldOrUnfold];
    }

}

- (void)nowTaskDownloadFailed:(NSString *)msg needDismiss:(BOOL)dismiss
{
    
    [taskTitle removeAnimate];
    taskTitle.taskIndex =0;
    [self loadAllTasksText];
    [self loadTask];
    [taskTitle setTitle:msg];
    [self foldWithAnmate:YES];
    
}

- (void)bgmDownloaded:(NSInteger)index
{
   //  PostNotification(Noti_HideHud,nil);
    [MainTabBarController hideHud];
    if (index == taskTitle.taskIndex && _toStart)
     {
          [self playMusicWithData:[[TaskModel sharedTaskModel] bgmData:index]];
     }

    
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (!_toStart) return;
    [MyNotiCenter removeObserver:self name:Noti_HudCanceled object:nil ];
    //PostNotification(Noti_HideHud,nil);
    [MainTabBarController hideHud];
    [self didStartTask];
}

- (void)dataDownloadEnded:(NSData *)data forUrl:(NSString *)url
{
   // PostNotification(Noti_HideHud, nil);
    [MainTabBarController hideHud];
    if (data) {
         [self playMusicWithData:data];
    }
   
}
- (void)reloadPortrait
{
    [taskTitle reloadPortrait];
}
@end
