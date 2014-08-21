//
//  Group.h
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

@class ActionForUpload;
@class Member;
@class Action;

@interface Group : NSObject <AFRequestDelegate>
{
    NSMutableSet * _actionForUps;
    NSTimer * _updateTimer;
    PumanRequest * _req;
}

//是否为我的组
@property (assign, nonatomic, readonly) BOOL isMy;
//组的GID
@property (assign, nonatomic, readonly) NSInteger GID;
//组名
@property (retain, nonatomic, readonly) NSString * GName;
//组创立时间
@property (retain, nonatomic, readonly) NSDate * GCreateTime;
//成员
@property (retain, nonatomic, readonly) NSMutableArray * GMember;
@property (retain, nonatomic, readonly) Member * MyMember;
@property (retain, nonatomic, readonly) NSMutableArray * GAction;
@property (retain, nonatomic, readonly) NSMutableArray * GMsgs;
@property (retain, nonatomic, readonly) Action * GLatestAction; //非msg类的最新action

@property (retain, nonatomic) NSDictionary * data;

- (Member *)memberWithBid:(NSInteger)bid;

//生成actions
//邀请action
- (ActionForUpload *)actionForInvite:(NSInteger)bid;
//接受邀请加入小组的action  inviteIndex:在inviteGroup,inviteFrom数组中的index
- (ActionForUpload *)actionForJoin;
//发送消息的Action
- (ActionForUpload *)actionForSendMsg:(NSString *)msg;
//修改组名的Action
- (ActionForUpload *)actionForRenameGroup:(NSString *)newName;
//移除的Action
- (ActionForUpload *)actionForRemove:(NSInteger)bid;
//退出的Action
- (ActionForUpload *)actionForQuit;

- (void)startUpdateAction;
- (void)stopUpdateAction;

#pragma mark --
- (void)actionUploadSuc:(ActionForUpload *)action;
- (void)actionUploadFail:(ActionForUpload *)action;

@end
