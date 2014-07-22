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
#import "ShareVideoDeleteViewController.h"

@protocol ShareVideoControllerDelegate;
@interface ShareVideoViewController : PopUpViewController<VideoManageDelegate,ShareViewDelegate,PopViewDelegate,ShareVideoDeleteDelegate>
{
    MPMoviePlayerController * moviePlayer;
    UIImageView *finishImgView;
    VideoManageView *manageView;
    SocialType shareType;
    BOOL saved;

}

@property(nonatomic,assign)id<ShareVideoControllerDelegate>delegate;
@property(nonatomic,retain)UIView *contentView;
@property(nonatomic,retain)NSString *filePath;

- (void)show;
- (void)hidden;
@end
@protocol ShareVideoControllerDelegate <NSObject>
@optional
- (void)shareViewfinished;
@end