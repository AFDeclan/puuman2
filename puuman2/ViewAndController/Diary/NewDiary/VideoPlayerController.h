//
//  VideoPlayerController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "TimeView.h"
#import "CustomTextField.h"
@protocol VideoPlayerDelegate;
@interface VideoPlayerController : MPMoviePlayerController
{
    TimeView *timeView;
    CustomTextField *titleTextField;
    UIButton *finishBtn;
    UIButton *closeBtn;
    UIButton *playBtn;
    
}
@property(assign,nonatomic)id<VideoPlayerDelegate> delegate;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
@protocol VideoPlayerDelegate <NSObject>

- (void)videoClosed;
- (void)videoFinished;

@end