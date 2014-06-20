//
//  TaskModel.h
//  puman
//
//  Created by 陈晔 on 13-5-7.
//  Copyright (c) 2013年 ÂàõÂßã‰∫∫Âõ¢Èòü. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DiaryModel.h"
#import "UserInfo.h"
#import "FileUploader.h"
#import "PumanRequest.h"

#define kTaskMeta               @"TaskMeta"

#define kUserID                 @"UserID"
#define kUserTaskID             @"UserTaskID"
#define kUserTaskStatus         @"UserTaskStatus"
#define kUserTaskCreateTime     @"UserTaskCreateTime"

#define kMaxTaskCount   5

@protocol TaskShowDelegate <NSObject>

- (void)nowTaskDownloadSucceeded;
- (void)nowTaskDownloadFailed:(NSString *)msg needDismiss:(BOOL)dismiss;
- (void)bgmDownloaded:(NSInteger)index;

@end

@class PumanTask;

@interface TaskModel : NSObject <AFRequestDelegate, UploaderDelegate>
{
    NSMutableArray *nowTasks;
    NSData *bgmData[kMaxTaskCount];
    PumanTask *pumanTask;
    BOOL nowTasksReady;
    BOOL nowTasksFailed;
    BOOL updating;
}

@property (assign, nonatomic) NSObject<TaskShowDelegate> *delegate;


+ (TaskModel *)sharedTaskModel;

//正在进行任务
- (NSDictionary*)nowTaskAtIndex:(NSUInteger)index;
- (NSData *)bgmData:(NSUInteger)index;
- (NSInteger)taskCount;
- (void)updateTasks;
- (BOOL)nowTasksReady; //是否已和服务器交互完毕
- (BOOL)nowTasksFailed;
- (BOOL)updating;

- (void)removeDoneTask:(NSDictionary *)taskInfo;



@end
