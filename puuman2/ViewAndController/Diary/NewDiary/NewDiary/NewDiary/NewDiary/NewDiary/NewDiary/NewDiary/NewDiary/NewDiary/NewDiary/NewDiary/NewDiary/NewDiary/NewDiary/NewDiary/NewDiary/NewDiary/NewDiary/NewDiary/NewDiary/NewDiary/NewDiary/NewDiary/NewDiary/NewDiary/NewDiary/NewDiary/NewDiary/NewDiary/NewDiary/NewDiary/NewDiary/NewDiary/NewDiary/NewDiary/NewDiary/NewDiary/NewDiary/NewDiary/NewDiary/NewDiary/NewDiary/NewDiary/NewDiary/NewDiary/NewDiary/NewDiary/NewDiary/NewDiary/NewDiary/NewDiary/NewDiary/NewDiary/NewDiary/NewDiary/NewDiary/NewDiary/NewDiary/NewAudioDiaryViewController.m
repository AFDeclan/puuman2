//
//  NewAudioDiaryViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewAudioDiaryViewController.h"
#import "DiaryFileManager.h"

@interface NewAudioDiaryViewController ()

@end

@implementation NewAudioDiaryViewController
@synthesize taskInfo = _taskInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)finishBtnPressed
{
    [DiaryFileManager saveAudio:[record recordUrl] withTitle:titleTextField.text andTaskInfo:_taskInfo];
    [super finishBtnPressed];
}

- (void)closeBtnPressed
{
    [super closeBtnPressed];
   
}

@end
