//
//  VideoManageView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoManageDelegate;
@interface VideoManageView : UIView
{
    
    
    UIButton *closeBtn;
    UIButton *shareBtn;
    UIButton *saveBtn;
    UILabel *mainLab;

}

@property(assign,nonatomic)id<VideoManageDelegate> delegate;
- (void)showAnimate;
- (void)saved;
@end
@protocol VideoManageDelegate <NSObject>
- (void)shareVideo;
- (void)deleteVideo;
- (void)saveVideo;
@end