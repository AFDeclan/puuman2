//
//  VideoManageView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareSelectedViewController.h"

@protocol VideoManageDelegate;
@interface VideoManageView : UIView<PopViewDelegate>
{
    UIView *closeView;
    UIView *shareView;
    UIView *AnimateView;
    UILabel *mainLab;
}
@property(assign,nonatomic)id<VideoManageDelegate> delegate;
- (void)showAnimate;
@end
@protocol VideoManageDelegate <NSObject>
- (void)shareVideo;
- (void)deleteVideo;
@end