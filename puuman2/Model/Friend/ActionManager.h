//
//  ActionManager.h
//  puuman2
//
//  Created by Declan on 14-3-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

@class Action;

@interface ActionManager : NSObject
{
    FMDatabase *_db;
}

+ (ActionManager *)sharedInstance;

- (void)clear;

//从数据库中读取某组的action
- (NSArray *)actionsForGroup:(NSInteger)GID;
- (NSArray *)msgsForGroup:(NSInteger)GID;
- (Action *)latestActionForGroup:(NSInteger)GID;

//写数据库
- (void)addAction:(Action *)act forGroup:(NSInteger)GID;

@end
