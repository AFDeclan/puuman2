//
//  NewCameraControlView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewCameraControlView.h"
#import "ColorsAndFonts.h"

@implementation NewCameraControlView

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
    [modelChangeBtn setBackgroundColor:[UIColor clearColor]];
    [modelChangeBtn addTarget:self action:@selector(recordAudio) forControlEvents:UIControlEventTouchUpInside];
    [modelChangeBtn setImage:[UIImage imageNamed:@"btn_auphoto_diary.png"] forState:UIControlStateNormal];
    [self addSubview:modelChangeBtn];
    
    playCameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [modelChangeBtn setBackgroundColor:[UIColor clearColor]];
    [modelChangeBtn addTarget:self action:@selector(startCamera) forControlEvents:UIControlEventTouchUpInside];
    [modelChangeBtn setImage:[UIImage imageNamed:@"btn_photo_diary.png"] forState:UIControlStateNormal];
    [self addSubview:modelChangeBtn];
    
    //sampleImg
    sampleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [self addSubview:sampleImageView];
   
    numLabelBgView = [[UIImageView alloc] initWithFrame:CGRectMake(32, 32, 16, 16)];
    [sampleImageView addSubview:numLabelBgView];
    
    photoNumLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [photoNumLabel setFont:PMFont4];
    [photoNumLabel setTextColor:[UIColor whiteColor]];
    [numLabelBgView addSubview:photoNumLabel];
    [photoNumLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    
}

- (void)startCamera
{

}

- (void)recordAudio
{

}

- (void)changeModel
{

}

- (void)frontRareChangeBtnPressed
{
    
}

- (void)closeBtnPressed
{
    
    
}

- (void)finishBtnPressed
{
    
}

@end
