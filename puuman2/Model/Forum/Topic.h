//
//  Topic.h
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"

typedef enum TopicStatus {
    TopicStatus_Voting = 0,
    TopicStatus_On = 1,
    TopicStatus_Past = 2,
} TopicStatus;

@class Reply;
@class PumanRequest;

@interface Topic : NSObject <AFRequestDelegate>
{
    NSInteger _roffset;
    PumanRequest *_request;
}

@property (assign, nonatomic, readonly) NSInteger   TID;
@property (assign, nonatomic, readonly) NSInteger   TNo;
@property (retain, nonatomic, readonly) NSString *  TTitle;
@property (retain, nonatomic, readonly) NSString *  TDetail;
@property (assign, nonatomic, readonly) TopicStatus TStatus;
@property (retain, nonatomic, readonly) NSDate *    TCreateTime;
@property (retain, nonatomic, readonly) NSMutableDictionary *meta;

@property (retain, nonatomic) NSDictionary * data;

//以获取的话题回复的列表
@property (retain, nonatomic, readonly) NSMutableArray * replies;
//是否获取了全部的回复列表
@property (assign, nonatomic, readonly) bool noMore;

- (void)getMoreReplies:(NSInteger)cnt;

@end
