//
//  Friend.h
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

@class Group;
@class ActionForUpload;

@protocol FriendDelegate <NSObject>

@optional
//获取小组信息成功
- (void)groupDataReceived;
//获取小组信息失败
- (void)groupDataFailed;
//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action;
//Group Action 上传失败
- (void)actionUploadFailed:(ActionForUpload *)action;
//Group Action 更新成功
- (void)actionUpdated:(Group *)group;

@end

@interface Friend : NSObject <AFRequestDelegate>
{
    NSMutableSet *_requests;
}

//小组信息是否以获取成功。
@property (assign, nonatomic, readonly) BOOL dataReady;
//是否在某个小组中
@property (assign, nonatomic, readonly) BOOL inGroup;
//所在的小组
@property (retain, nonatomic, readonly) Group * myGroup;
//收到邀请的小组 Array of Group
@property (retain, nonatomic, readonly) NSMutableArray * invitedGroup;
//邀请者   Array of Member
@property (retain, nonatomic, readonly) NSMutableArray * inviteFrom;

@property (retain, nonatomic, readonly) NSMutableSet * delegates;

+ (Friend *)sharedInstance;

+ (void)releaseInstance;

- (void)addDelegateObject:(id<FriendDelegate>)object;

- (void)removeDelegateObject:(id<FriendDelegate>)object;

//获取小组数据（我的小组或我收到的邀请）
- (void)getGroupData;



- (void)informDelegates:(SEL)sel withObject:(id)obj;


@end
