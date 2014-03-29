//
//  Group.h
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member;

@interface Group : NSObject

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

@property (retain, nonatomic) NSDictionary * data;

- (Member *)memberWithBid:(NSInteger)bid;

@end
