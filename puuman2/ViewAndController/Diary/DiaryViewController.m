//
//  DiaryViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryViewController.h"
#import "UniverseConstant.h"
#import "UserInfo.h"
#import "MainTabBarController.h"
#import "NewTextDiaryViewController.h"
#import "NewImportDiaryViewController.h"
#import "NewAudioDiaryViewController.h"
#import "NewCameraViewController.h"


NSString * newDiaryBtnImageName[5] = {@"btn_input_newdiary.png",@"btn_text_newdiary.png", @"btn_audio_newdiary.png", @"btn_photo_newdiary.png",@"btn_video_newdiary.png"};

NSString * newDiaryBtnSelectedImageName[5] = { @"btn_input2_newdiary.png",@"btn_text2_newdiary.png",@"btn_audio2_newdiary.png",@"btn_photo_newdiary.png",@"btn_video_newdiary.png"};


@interface DiaryViewController ()

@end

static DiaryViewController * instance;
@implementation DiaryViewController


+ (DiaryViewController *)sharedDiaryViewController
{
    if (!instance)
        instance = [[DiaryViewController alloc] initWithNibName:nil bundle:nil];
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)initContent
{
    
    diaryTableVC = [[DiaryTableViewController alloc] init];
    [self.view addSubview:diaryTableVC.view];

    
    newBtn = [[DiaryNewButton alloc] initWithFrame:CGRectMake(0, 0, 56, 88)];
    [self.view addSubview:newBtn];
    [newBtn setCommonBtnType:[self newBtnType]];
    //new Diary Btns
    for (int i=0; i<5; i++)
    {
       // newDiaryBtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        newDiaryBtn[i] = [[UIButton alloc] init];
        [newDiaryBtn[i] setImage:[UIImage imageNamed:newDiaryBtnImageName[i]] forState:UIControlStateNormal];
        [newDiaryBtn[i] addTarget:self action:@selector(showNewDiaryView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:newDiaryBtn[i]];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self initContent];
	// Do any additional setup after loading the view.
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
}

//竖屏
-(void)setVerticalFrame
{
    [diaryTableVC.view setFrame:CGRectMake(80, 0, 672, 1024)];
    [newBtn setFrame:CGRectMake(680, 904, 56, 88)];
    
    if ([newBtn directionChangedWithVertical:YES] &&isFirst == NO) {
        isFirst = YES;
        [newBtn setShowStatus];
        [newBtn setNewBtnShowed:YES];
        
        for (int i=0; i<5; i++)
        {
            if (newBtn.commonBtnType >i ) {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - i*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else if(newBtn.commonBtnType < i )
            {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - (i-1)*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else{
                newDiaryBtn[i].alpha = 0;
            }
            
        }
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideNewBtns) userInfo:nil repeats:NO];

        
    }
    if (newBtn.newBtnShowed) {
        for (int i=0; i<5; i++)
        {
            if (newBtn.commonBtnType >i ) {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - i*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else if(newBtn.commonBtnType < i )
            {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - (i-1)*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else{
                newDiaryBtn[i].alpha = 0;
            }
            
        }
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideNewBtns) userInfo:nil repeats:NO];

        
    }else{
        for (int i=0; i<5; i++)
        {
            newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x, newBtn.frame.origin.y, 56,56);
            [newDiaryBtn[i] setAlpha:0];
            
        }
    }

}

//横屏
-(void)setHorizontalFrame
{
    [diaryTableVC.view setFrame:CGRectMake(80, 0, 672, 768)];
    [newBtn setFrame:CGRectMake(936, 648, 56, 88)];
    
    if ([newBtn directionChangedWithVertical:NO]&&isFirst == NO) {
        [newBtn setShowStatus];
        isFirst = YES;
        [newBtn setNewBtnShowed:YES];
        for (int i=0; i<5; i++)
        {
            if (newBtn.commonBtnType >i ) {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - i*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else if(newBtn.commonBtnType < i )
            {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - (i-1)*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else{
                newDiaryBtn[i].alpha = 0;
            }
            
        }
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
         timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideNewBtns) userInfo:nil repeats:NO];

        
    }
    if (newBtn.newBtnShowed) {
        for (int i=0; i<5; i++)
        {
            if (newBtn.commonBtnType >i ) {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - i*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else if(newBtn.commonBtnType < i )
            {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - (i-1)*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else{
                newDiaryBtn[i].alpha = 0;
            }
            
        }
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideNewBtns) userInfo:nil repeats:NO];

        
    }else{
        for (int i=0; i<5; i++)
        {
            newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x, newBtn.frame.origin.y, 56,56);
            [newDiaryBtn[i] setAlpha:0];
            
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - show and hide btns

- (NewButtonType)newBtnType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [UserInfo sharedUserInfo].UID;
    NSString *importkey = [NSString stringWithFormat:@"%@%d",kDiaryNewImportNum,uid];
    int importnum  =[userDefaults integerForKey:importkey];
    NSString *textkey = [NSString stringWithFormat:@"%@%d",kDiaryNewTextNum,uid];
    int textnum  =[userDefaults integerForKey:textkey];
    NSString *audiokey = [NSString stringWithFormat:@"%@%d",kDiaryNewAudioNum,uid];
    int audionum  =[userDefaults integerForKey:audiokey];
    NSString *camerakey = [NSString stringWithFormat:@"%@%d",kDiaryNewCameraNum,uid];
    int cameranum  =[userDefaults integerForKey:camerakey];
    NSString *videokey = [NSString stringWithFormat:@"%@%d",kDiaryNewVideoNum,uid];
    int videonum  =[userDefaults integerForKey:videokey];
    
    int num[5] = {importnum,textnum,audionum,cameranum,videonum};
    int temp = cameranum;
    int maxNumPoint = 3;
    for (int  i = 1; i < 5;  i ++) {
        if (temp < num [i]) {
            temp = num [i];
            maxNumPoint = i;
        }
    }
    
    return maxNumPoint;
}

- (void)showNewDiaryView:(UIButton *)sender
{
    
    
    [MobClick event:umeng_event_click label:@"NewShowDiary_DiaryViewController"];
   // [[NSNotificationCenter defaultCenter] postNotificationName:kPauseMultiMediaMessage object:nil];
    int p = -1;
    for (int i=0; i<5; i++)
        if (sender == newDiaryBtn[i])
        {
            p = i; break;
        }
    
    [sender setImage:[UIImage imageNamed:newDiaryBtnSelectedImageName[p]] forState:UIControlStateNormal];
    [self showNewDiaryViewWithType:p];
    
}

- (void)showNewDiaryViewWithType:(NewButtonType)type
{
    

    

    
    

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [UserInfo sharedUserInfo].UID;
    [newBtn hiddenBtns];

 
    switch (type) {
        case ImportDiary:
        {
            NSString *importkey = [NSString stringWithFormat:@"%@%d",kDiaryNewImportNum,uid];
            int num  =[userDefaults integerForKey:importkey];
            [userDefaults setInteger:num+1 forKey:importkey];
            NewImportDiaryViewController  *popView = [[NewImportDiaryViewController alloc] initWithNibName:nil bundle:nil];
            [[MainTabBarController sharedMainViewController].view addSubview:popView.view];
            [popView setControlBtnType:kCloseAndFinishButton];
            [popView setTitle:@"传照片" withIcon:[UIImage imageNamed:@"icon_input_diary.png"]];
            [popView show];
        }
            break;
            
        case TextDiary:
        {
            NSString *textkey = [NSString stringWithFormat:@"%@%d",kDiaryNewTextNum,uid];
            int num  =[userDefaults integerForKey:textkey];
            [userDefaults setInteger:num+1 forKey:textkey];
            NewTextDiaryViewController *popView = [[NewTextDiaryViewController alloc] initWithNibName:nil bundle:nil];
            [[MainTabBarController sharedMainViewController].view addSubview:popView.view];
            [popView setControlBtnType:kCloseAndFinishButton];
            [popView setTitle:@"写日记" withIcon:[UIImage imageNamed:@"icon_text2_diary.png"]];
            [popView show];
        }
            break;
        case AudioDiary:
        {
            NSString *audiokey = [NSString stringWithFormat:@"%@%d",kDiaryNewAudioNum,uid];
            int num  =[userDefaults integerForKey:audiokey];
            [userDefaults setInteger:num+1 forKey:audiokey];
            NewAudioDiaryViewController *popView = [[NewAudioDiaryViewController alloc] initWithNibName:nil bundle:nil];
            [[MainTabBarController sharedMainViewController].view addSubview:popView.view];
            [popView setControlBtnType:kCloseAndFinishButton];
            [popView setTitle:@"录声音" withIcon:[UIImage imageNamed:@"icon_audio2_diary.png"]];
            [popView show];
            
        }
            break;
        case CameraDiary:
        {
            NSString *camerakey = [NSString stringWithFormat:@"%@%d",kDiaryNewCameraNum,uid];
            int num  =[userDefaults integerForKey:camerakey];
            [userDefaults setInteger:num+1 forKey:camerakey];
            NewCameraViewController  *popView = [[NewCameraViewController alloc] initWithNibName:nil bundle:nil];
            self.cameraModel = YES;
            [self presentModalViewController:popView animated:YES];
        }
            return;
        case VideoDiary:
        {
            NSString *videokey = [NSString stringWithFormat:@"%@%d",kDiaryNewVideoNum,uid];
            int num  =[userDefaults integerForKey:videokey];
            [userDefaults setInteger:num+1 forKey:videokey];
            NewCameraViewController  *popView = [[NewCameraViewController alloc] initWithNibName:nil bundle:nil];
            self.cameraModel = NO;
            [self presentModalViewController:popView animated:YES];
        }
            return;
        default:
            return;
    }
}

- (void)hideNewDiaryBtns
{
    [UIView animateWithDuration:0.3 animations:^{
        
        for (int i=0; i<5; i++)
        {
            newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x, newBtn.frame.origin.y, 56,56);
            [newDiaryBtn[i] setAlpha:0];
            
        }
        
    }];
    
}

- (void)showNewDiaryBtns
{
    [UIView animateWithDuration:0.3 animations:^{
        
        for (int i=0; i<5; i++)
        {
            [newDiaryBtn[i]  setImage:[UIImage imageNamed:newDiaryBtnImageName[i]] forState:UIControlStateNormal];
            if (newBtn.commonBtnType >i ) {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - i*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else if(newBtn.commonBtnType < i )
            {
                newDiaryBtn[i].frame = CGRectMake(newBtn.frame.origin.x,newBtn.frame.origin.y - (i-1)*80-44, 56, 56);
                newDiaryBtn[i].alpha = 1;
            }else{
                newDiaryBtn[i].alpha = 0;
            }
        }
        
    }completion:^(BOOL finished) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideNewBtns) userInfo:nil repeats:NO];
    }];
   
}


- (void)showNewDiaryBtnPressed
{
    [newBtn showBtns];
}

- (void)hideNewDiaryBtnPressed
{
    [newBtn hiddenBtns];
}

- (void)hideNewBtns
{
    [newBtn hiddenBtns];
}

@end
