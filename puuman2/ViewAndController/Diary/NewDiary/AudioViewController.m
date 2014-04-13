//
//  AudioViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AudioViewController.h"

#import "DiaryFileManager.h"
@interface AudioViewController ()

@end

@implementation AudioViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    titleTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 112, 640, 48)];
    titleTextField.placeholder = @"这个声音是......";
    // [titleTextField setDelegate:self];
    [_content addSubview:titleTextField];
    
    record  = [[NewAudioRecordView alloc] initWithFrame:CGRectMake(240, 240, 224, 224)];
    [record setDelegate:self];
    [_content addSubview:record];
    
    play = [[NewAudioPlayView alloc] initWithFrame:CGRectMake(240, 240, 224, 224)];
    [play setDelegate:self];
    [play setAlpha:0];
    [_content addSubview:play];
    
    label_start = [[UILabel alloc] initWithFrame:CGRectMake(240, 464, 224, 76)];
    [label_start setText:@"点击开始录音"];
    [label_start setFont:PMFont3];
    [label_start setTextColor:PMColor3];
    [label_start setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:label_start];
    
    label_restart = [[UILabel alloc] initWithFrame:CGRectMake(80, 464, 224, 76)];
    [label_restart setText:@"重新录制"];
    [label_restart setFont:PMFont3];
    [label_restart setTextColor:PMColor3];
    [label_restart setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:label_restart];
    
    label_stop = [[UILabel alloc] initWithFrame:CGRectMake(240, 464, 224, 76)];
    [label_stop setText:@"点击停止录音"];
    [label_stop setFont:PMFont3];
    [label_stop setTextColor:PMColor3];
    [label_stop setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:label_stop];
    
    label_play = [[UILabel alloc] initWithFrame:CGRectMake(400, 464, 224, 76)];
    [label_play setText:@"试听"];
    [label_play setFont:PMFont3];
    [label_play setTextColor:PMColor3];
    [label_play setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:label_play];
    
    label_stopPlay = [[UILabel alloc] initWithFrame:CGRectMake(400, 464, 224, 76)];
    [label_stopPlay setText:@"点击停止"];
    [label_stopPlay setFont:PMFont3];
    [label_stopPlay setTextColor:PMColor3];
    [label_stopPlay setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:label_stopPlay];
    [label_stopPlay setAlpha:0];
    [label_play setAlpha:0];
    [label_stop setAlpha:0];
    [label_restart setAlpha:0];
    [label_start setAlpha:1];
}

- (void)setControlBtnType:(ControlBtnType)controlBtnType
{
    [super setControlBtnType:controlBtnType];
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)restartRecord
{
    [play setPlayFile:nil];
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(record, 240, 240);
        [label_start setAlpha:1];
        [label_restart setAlpha:0];
        SetViewLeftUp(play, 240, 240);
        [play setAlpha:0];
        [label_play setAlpha:0];
        [label_stopPlay setAlpha:0];
    }];
}

- (void)stopRecord
{
    NSURL *url = [record recordUrl];
    if (url) {
        [_finishBtn setAlpha:1];
        [_finishBtn setEnabled:YES];
        [play setPlayFile:url];
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(record, 80, 240);
            [label_restart setAlpha:1];
            [label_stop setAlpha:0];
            SetViewLeftUp(play, 400, 240);
            [play setAlpha:1];
            [label_play setAlpha:1];
        }];
    }else{
        [record restartRecord];
    }
}

- (void)startRecord
{
    [UIView animateWithDuration:0.5 animations:^{
        [label_stop setAlpha:1];
        [label_start setAlpha:0];
    }];
    
}

- (void)stopPlay
{
    
    [UIView animateWithDuration:0.5 animations:^{
        [label_stopPlay setAlpha:0];
        [label_play setAlpha:1];
    }];
}

- (void)startPlay
{
    [UIView animateWithDuration:0.5 animations:^{
        [label_stopPlay setAlpha:1];
        [label_play setAlpha:0];
    }];
}

- (void)finishBtnPressed
{
    
    [super finishBtnPressed];
}

- (void)closeBtnPressed
{
    [play removePlay];
    [record removeRecord];
    [super closeBtnPressed];
    
}

@end
