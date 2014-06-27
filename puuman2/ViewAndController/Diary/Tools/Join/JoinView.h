//
//  JoinView.h
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteView.h"
#import "WaitView.h"
#import "DynamicView.h"
@interface JoinView : UIView
{
    UIView  *contentView;
    NSString *intString;
    InviteView *invite;
 
}
+ (JoinView *)sharedJoinView;
- (void)initWaitView;
- (void)initInviteView;
- (void)initDynamicView;
- (void)refreshStaus;
- (void)resign;
@end
