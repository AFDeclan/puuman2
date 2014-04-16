//
//  CameraAudioViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CameraAudioViewController.h"

@interface CameraAudioViewController ()

@end

@implementation CameraAudioViewController
@synthesize delegate = _delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [titleTextField removeFromSuperview];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)finishBtnPressed
{
    [_delegate getAudioWithUrl:[record recordUrl]];
    [super finishBtnPressed];
}

- (void)closeBtnPressed
{
  
    [_delegate getAudioWithUrl:nil];
    [super closeBtnPressed];
    
}

- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}

- (void)finishOut
{
    [self.view removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRecordUrl:(NSURL *)audioUrl
{
    
    if (audioUrl) {
        [_finishBtn setAlpha:1];
        [_finishBtn setEnabled:YES];
        [play setPlayFile:audioUrl];
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

@end
