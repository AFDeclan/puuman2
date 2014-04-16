//
//  CameraAudioViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AudioViewController.h"
@protocol CameraAudioDelegate ;
@interface CameraAudioViewController : AudioViewController


@property (assign,nonatomic)id<CameraAudioDelegate>delegate;
- (void)setRecordUrl:(NSURL *)audioUrl;
@end
@protocol CameraAudioDelegate <NSObject>
- (void)getAudioWithUrl:(NSURL *)audioUrl;
@end