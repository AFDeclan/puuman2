//
//  NewCameraControlView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewCameraControlView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "UIImage+CroppedImage.h"

@implementation NewCameraControlView
@synthesize delegate = _delegate;
@synthesize videoMode =_videoMode;

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
    recordingVideo = NO;
    hasEffect = NO;
    _videoMode = NO;
    controlBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:controlBg];
    
    closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close1.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:closeBtn];
    
    finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [finishBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [finishBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:finishBtn];
    
    frontRareChangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [frontRareChangeBtn setBackgroundColor:[UIColor clearColor]];
    [frontRareChangeBtn addTarget:self action:@selector(frontRareChangeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [frontRareChangeBtn setImage:[UIImage imageNamed:@"btn_change_diary.png"] forState:UIControlStateNormal];
    [self addSubview:frontRareChangeBtn];
    
    modelChangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [modelChangeBtn setBackgroundColor:[UIColor clearColor]];
    [modelChangeBtn addTarget:self action:@selector(changeModel) forControlEvents:UIControlEventTouchUpInside];
    [modelChangeBtn setImage:[UIImage imageNamed:@"btn_video_diary.png"] forState:UIControlStateNormal];
    [self addSubview:modelChangeBtn];
    
    audioBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [audioBtn setBackgroundColor:[UIColor clearColor]];
    [audioBtn addTarget:self action:@selector(recordAudio) forControlEvents:UIControlEventTouchUpInside];
    [audioBtn setImage:[UIImage imageNamed:@"btn_auphoto_diary.png"] forState:UIControlStateNormal];
    [self addSubview:audioBtn];
    [audioBtn setAlpha:0];
    
    playCameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [playCameraBtn setBackgroundColor:[UIColor clearColor]];
    [playCameraBtn addTarget:self action:@selector(startCamera) forControlEvents:UIControlEventTouchUpInside];
    [playCameraBtn setImage:[UIImage imageNamed:@"btn_photo_diary.png"] forState:UIControlStateNormal];
    [self addSubview:playCameraBtn];
    [playCameraBtn setEnabled:NO];
    //sampleImg
    sampleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [sampleBtn setBackgroundColor:[UIColor clearColor]];
    [sampleBtn addTarget:self action:@selector(showSamplePhotos) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sampleBtn];
    [sampleBtn setAlpha:0];
    
    sampleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    sampleImageView.layer.cornerRadius = 24;
    sampleImageView.layer.masksToBounds = YES;
    [sampleBtn addSubview:sampleImageView];
   
    
    numLabelBgView = [[UIImageView alloc] initWithFrame:CGRectMake(32, 0, 16, 16)];
    [numLabelBgView setImage:[UIImage imageNamed:@"dot_number_diary.png"]];
    [sampleBtn addSubview:numLabelBgView];
    
    photoNumLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [photoNumLabel setFont:PMFont4];
    [photoNumLabel setTextColor:[UIColor whiteColor]];
    [photoNumLabel setBackgroundColor:[UIColor clearColor]];
    [photoNumLabel setText:@"0"];
    [numLabelBgView addSubview:photoNumLabel];
    [photoNumLabel setTextAlignment:NSTextAlignmentCenter];

    [closeBtn setEnabled:NO];
    [finishBtn setEnabled:NO];
    [frontRareChangeBtn setEnabled:NO];
    [modelChangeBtn setEnabled:NO];
    [audioBtn setEnabled:NO];
    [playCameraBtn setEnabled:NO];
    [sampleBtn setEnabled:NO];
    
    
   
}



- (void)setVerticalFrame
{

    SetViewLeftUp(frontRareChangeBtn, 64, 320);
    SetViewLeftUp(modelChangeBtn, 64, 384);
    SetViewLeftUp(closeBtn, 64, 16);
    SetViewLeftUp(sampleBtn, 64, 664);
    SetViewLeftUp(audioBtn, 64, 600);
    SetViewLeftUp(playCameraBtn, 16, 472);
    SetViewLeftUp(finishBtn, 64, 960);
    
    [controlBg setImage:[UIImage imageNamed:@"block_photo_diary.png"]];
    [controlBg setFrame:CGRectMake(0, 0, 128, 1024)];

}
- (void)setHorizontalFrame
{
    SetViewLeftUp(frontRareChangeBtn, 64, 192);
    SetViewLeftUp(modelChangeBtn, 64, 256);
    SetViewLeftUp(closeBtn, 64, 16);
    SetViewLeftUp(sampleBtn, 64, 528);
    SetViewLeftUp(audioBtn, 64, 464);
    SetViewLeftUp(playCameraBtn, 16, 344);
    SetViewLeftUp(finishBtn, 64, 704);
    [controlBg setImage:[UIImage imageNamed:@"block_photo__h_diary.png"]];
    [controlBg setFrame:CGRectMake(0, 0,128, 768)];

}

- (void)addPhoto:(UIImage *)photo andNum:(int)num
{
    photo = [UIImage croppedImage:photo WithHeight:96 andWidth:96];
    [sampleImageView setImage:photo];
    [photoNumLabel setText:[NSString stringWithFormat:@"%d",num]];
    if (num == 1)
    {
        [sampleBtn setAlpha:1];
        [audioBtn setAlpha:1];
        
        if (self.taskInfo && ([[self.taskInfo valueForKey:_task_TaskType] integerValue] == 6 || [[self.taskInfo valueForKey:_task_ID] integerValue] == 2))
        {   //有声图任务
           [self recordAudio];
        }
    }else if (num == 2){
        
        [audioBtn setAlpha:0];
    }else if (num == 0){
        [sampleBtn setAlpha:0];
    }
    

}

- (void)enableControl
{
    [closeBtn setEnabled:YES];
    [finishBtn setEnabled:YES];
    [frontRareChangeBtn setEnabled:YES];
    [modelChangeBtn setEnabled:YES];
    [audioBtn setEnabled:YES];
    [playCameraBtn setEnabled:YES];
    [sampleBtn setEnabled:YES];
    [closeBtn setAdjustsImageWhenDisabled:NO];
    [finishBtn setAdjustsImageWhenDisabled:NO];
    [frontRareChangeBtn setAdjustsImageWhenDisabled:NO];
    [modelChangeBtn setAdjustsImageWhenDisabled:NO];
    [audioBtn setAdjustsImageWhenDisabled:NO];
    [playCameraBtn setAdjustsImageWhenDisabled:NO];
    [sampleBtn setAdjustsImageWhenDisabled:NO];
}

- (void)startCamera
{
    [modelChangeBtn setAlpha:0];
    if (_videoMode) {
        if (!recordingVideo)
        {
            recordingVideo = YES;
            hasEffect = NO;
            [frontRareChangeBtn setAlpha:0];
            [playCameraBtn setEnabled:NO];
            [_delegate takeVideo];
            [self performSelector:@selector(canStopVideo) withObject:nil afterDelay:1];
            
        }else if(hasEffect)
        {
            [_delegate stopVideo];
            recordingVideo = NO;
            hasEffect = NO;
            [playCameraBtn setEnabled:NO];
        }
        
      
        
    }else{
        [_delegate takePhoto];
        [playCameraBtn setEnabled:NO];
        [playCameraBtn setAlpha:0.5];
        [self performSelector:@selector(cameraEnable) withObject:nil afterDelay:0.2];
    }
}

- (void)canStopVideo
{
    hasEffect = YES;
    [playCameraBtn setEnabled:YES];
}

- (void)recordAudio
{
    [_delegate showAudioView];
}

- (void)changeModel
{
    _videoMode = !_videoMode;
    [self setVideoMode:_videoMode];
}

- (void)setVideoMode:(BOOL)videoMode
{
    _videoMode = videoMode;
    if (videoMode) {
        [_delegate toVideoModel];
        [modelChangeBtn setImage:[UIImage imageNamed:@"btn_photo2_diary.png"] forState:UIControlStateNormal];
        [playCameraBtn setImage:[UIImage imageNamed:@"btn_video2_diary.png"] forState:UIControlStateNormal];
    }else{
        [_delegate toPhotoModel];
        [modelChangeBtn setImage:[UIImage imageNamed:@"btn_video_diary.png"] forState:UIControlStateNormal];
        [playCameraBtn setImage:[UIImage imageNamed:@"btn_photo_diary.png"] forState:UIControlStateNormal];

    }
    
}
- (void)frontRareChangeBtnPressed
{
    [_delegate frontRareChangeBtnPressed];
}

- (void)closeBtnPressed
{
    [_delegate closeBtnPressed];
    
}

- (void)finishBtnPressed
{
    [_delegate finishBtnPressed];
}

- (void)showSamplePhotos
{
    [_delegate showSampleView];
}



- (void)cameraEnable
{
    [playCameraBtn setEnabled:YES];
    [playCameraBtn setAlpha:1];
}



@end
