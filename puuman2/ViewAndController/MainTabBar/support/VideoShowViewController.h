//
//  VideoShowViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoShowViewDelegate;
@interface VideoShowViewController : UIViewController
{
    UIView *videoView;
    UIView *contentView;

}
- (void)showVideoView;
@end
@protocol VideoShowViewDelegate <NSObject>
- (void)showVideo;
- (void)closeShowVideo;
@end
