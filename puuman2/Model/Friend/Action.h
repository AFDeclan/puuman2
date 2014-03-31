//
//  Action.h
//  puuman2
//
//  Created by Declan on 14-3-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ActionType {
    //邀请
    ActionType_Invite = 0,
    //加入
    ActionType_Join = 1,
    //移除
    ActionType_Remove = 2,
    //退出
    ActionType_Quit = 3,
    //重命名组
    ActionType_Rename = 4,
    //发消息
    ActionType_Msg = 5
} ActionType;


@interface Action : NSObject

@property (assign, nonatomic) NSInteger AID;
@property (assign, nonatomic) NSInteger GID;
@property (assign, nonatomic) NSInteger ASourceUID;
@property (assign, nonatomic) NSInteger ATargetBID;
@property (assign, nonatomic) ActionType AType;
@property (retain, nonatomic) NSString * AMeta;
@property (retain, nonatomic) NSDate * ACreateTime;

@property (retain, nonatomic) NSDictionary * data;

@end
