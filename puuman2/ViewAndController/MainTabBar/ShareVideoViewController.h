//
//  ShareVideoViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopUpViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoManageView.h"

@protocol ShareVideoControllerDelegate;
@interface ShareVideoViewController : PopUpViewController<VideoManageDelegate>
{
    MPMoviePlayerController * moviePlayer;
    UIImageView *finishImgView;
    NSString *path;
    VideoManageView *manageView;

}

@property(nonatomic,assign)id<ShareVideoControllerDelegate>delegate;
@property(nonatomic,retain)UIView *contentView;

- (void)show;
- (void)hidden;
@end
@protocol ShareVideoControllerDelegate <NSObject>
@optional
- (void)babyViewfinished;
@end