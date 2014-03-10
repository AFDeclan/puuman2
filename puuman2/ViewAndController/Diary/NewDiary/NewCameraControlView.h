//
//  NewCameraControlView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CameraControlDelegate;


@interface NewCameraControlView : UIView
{
    UIImageView *controlBg;
    UIButton *closeBtn;
    UIButton *finishBtn;
    UIButton *frontRareChangeBtn;
    UIButton *modelChangeBtn;
    UIButton *audioBtn;
    UIButton *playCameraBtn;
    //sampleImg
    UIButton *sampleBtn;
    UIImageView *sampleImageView;
    UILabel *photoNumLabel;
    UIImageView *numLabelBgView;
    BOOL recordingVideo;
    BOOL hasEffect;
}
@property (assign,nonatomic)id<CameraControlDelegate> delegate;
@property (assign,nonatomic) BOOL videoMode;
@property (retain, nonatomic) NSDictionary *taskInfo;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
- (void)addPhoto:(UIImage *)photo andNum:(int)num;
- (void)enableControl;


@end
@protocol CameraControlDelegate <NSObject>
- (void)closeBtnPressed;
- (void)finishBtnPressed;
- (void)frontRareChangeBtnPressed;
- (void)takeVideo;
- (void)stopVideo;
- (void)takePhoto;
- (void)toVideoModel;
- (void)toPhotoModel;
- (void)showSampleView;
- (void)showAudioView;
@end