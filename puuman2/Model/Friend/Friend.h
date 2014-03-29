//
//  Friend.h
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

@protocol FriendDelegate <NSObject>

@optional
//获取小组信息成功
- (void)groupDataReceived;
//获取小组信息失败
- (void)groupDataFailed;

@end

@class Group;

@interface Friend : NSObject <AFRequestDelegate>
{
    NSMutableSet *_requests;
}

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

@end
