//
//  MemberCache.h
//  puuman2
//
//  Created by Declan on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "PumanRequest.h"

@class Member;
@interface MemberCache : NSObject <AFRequestDelegate>
{
    FMDatabase * _db;
}

+ (MemberCache *)sharedInstance;
- (void)cacheMember:(Member *)mem;

//若返回nil，说明没有缓存，将从服务器获取，异步返回，（见Friend中的回调）
- (Member *)getMemberWithUID:(NSInteger)uid;
- (Member *)getMemberWithBID:(NSInteger)bid;
- (void)removeMemberWithBID:(NSInteger)bid;

@end
