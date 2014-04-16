//
//  NewCameraViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewCameraControlView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TimeView.h"
#import "NewCameraShowPhotosViewController.h"
#import "CameraAudioViewController.h"
#import "VideoPlayerController.h"


@protocol CameraViewDelegate;
@interface NewCameraViewController : UIViewController<CameraControlDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NewCameraShowPhotosDelegate,CameraAudioDelegate,VideoPlayerDelegate>
{
    NewCameraControlView *controlView;
    UIImagePickerController *cameraUI;
    NSString *titleStr;
    NSMutableArray *photoPath;
    NSMutableDictionary *photosStatus;
    NSMutableArray *photos;
    NSURL *movieUrl;
    VideoPlayerController *moviePlayer;
    TimeView *timeView;
    NSURL *audioFileUrl;
   BOOL isVertical;
}
@property(assign,nonatomic) id<CameraViewDelegate> delegate;
@property (retain, nonatomic) NSDictionary *taskInfo;
@property (assign, nonatomic) BOOL isTopic;
@property (assign, nonatomic) BOOL cameraModel;
@end
@protocol CameraViewDelegate <NSObject>
@optional
- (void)cameraViewHidden;
@end