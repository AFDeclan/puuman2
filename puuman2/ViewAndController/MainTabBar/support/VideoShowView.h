//
//  VideoShowView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoManageView.h"
//#import "Reachability.h"

@protocol VideoShowViewDelegate;

@interface VideoShowView : UIView<VideoManageDelegate>
{
    UIView *videoView;
    UIView *contentView;
    MPMoviePlayerController * moviePlayer;
    UIImageView *finishView;
    NSString *videoPath;
    VideoManageView *manageView;
    NSTimer *timer;
    UIImage *finishImg;
    NSInteger index;
    NSMutableArray *animates;
    NSString *_filePath;
    
}

@property(assign,nonatomic)id<VideoShowViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withVideoPath:(NSString *)filePath;

- (void)showVideoView;
- (void)playVideo;

@end
@protocol VideoShowViewDelegate <NSObject>
- (void)deleteVideo;

@end

