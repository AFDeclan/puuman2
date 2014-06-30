//
//  JoinView.m
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "JoinView.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "ColorsAndFonts.h"
#import "ErrorLog.h"
#import <Reachability.h>
#import "UserInfo.h"
#import "ErrorLog.h"


static JoinView * instance;
@implementation JoinView
+ (JoinView *)sharedJoinView;
{
    if (!instance)
        instance = [[JoinView alloc] initWithFrame:CGRectMake(0, 0, 240, 304)];
    
    return instance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
     
    }
    return self;
}
- (void)initialization
{
    contentView =[[UIView alloc] initWithFrame:CGRectMake(0,64, 240, 240)];
    [self addSubview:contentView];
}
- (void)resign
{
   if(invite)
   {
       [invite resign];
   }
}
- (void)refreshStaus
{
    
    switch ([UserInfo sharedUserInfo].inviteState) {
        case noInvite:
            [self initInviteView];
            break;
        case waitForAccept:
            [self initWaitView];
            break;
        case done:
            [self initDynamicView];
            break;
        default:
            break;
    }

}
- (void)initInviteView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:0];
                     }];
    for (UIView *view in [contentView subviews]) {
        [view removeFromSuperview];
    }
    invite = [[InviteView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    [contentView addSubview:invite];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:1];
                     }];
}
- (void)initWaitView
{  [UIView animateWithDuration:0.5
                    animations:^{
                        [contentView setAlpha:0];
                    }];
    for (UIView *view in [contentView subviews]) {
        [view removeFromSuperview];
    }
    WaitView *wait = [[WaitView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    [contentView addSubview:wait];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:1];
                     }];
}
-(void)initDynamicView
{  [UIView animateWithDuration:0.5
                    animations:^{
                        [contentView setAlpha:0];
                    }];
    for (UIView *view in [contentView subviews]) {
        [view removeFromSuperview];
    }
    DynamicView *dynamic = [[DynamicView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    [contentView addSubview:dynamic];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:1];
                     }];
    
}







@end
