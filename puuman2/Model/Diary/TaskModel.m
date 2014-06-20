//
//  TaskModel.m
//  puman
//
//  Created by 陈晔 on 13-5-7.
//  Copyright (c) 2013年 ÂàõÂßã‰∫∫Âõ¢Èòü. All rights reserved.
//

#import "TaskModel.h"
#import "UniverseConstant.h"
#import <ASIFormDataRequest.h>
#import "DateFormatter.h"
#import "NSDate+Compute.h"
#import "ErrorLog.h"

static TaskModel *instance;

@implementation TaskModel

+ (TaskModel *)sharedTaskModel
{
    if (!instance)
    {
        instance = [[TaskModel alloc] init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        nowTasks = [[NSMutableArray alloc] init];

        updating = NO;
        nowTasksReady = NO;
        nowTasksFailed = NO;
    }
    return self;
}

- (NSDictionary*)nowTaskAtIndex:(NSUInteger)index
{
    if (index < [nowTasks count]) return [nowTasks objectAtIndex:index];
    else return nil;
}

- (NSData *)bgmData:(NSUInteger)index
{
    if (index >= kMaxTaskCount) return nil;
    else return bgmData[index];
}

- (NSInteger)taskCount
{
    return [nowTasks count];
}

- (BOOL)nowTasksReady
{
    return nowTasksReady;
}

- (BOOL)nowTasksFailed
{
    return nowTasksFailed;
}

- (BOOL)updating
{
    return updating;
}


- (void)updateTasks
{
    nowTasksReady = NO;
    nowTasksFailed = NO;
    if ([[UserInfo sharedUserInfo] logined])
    {
        updating = YES;
        [self getNowTask];
    }
}

- (void)getNowTask
{
    NSInteger day = -99999, week = -99999, month = -99999;
    NSDate *birthDay = [[[UserInfo sharedUserInfo] babyInfo] Birthday];
    if (birthDay)
    {
        NSDate *curDate = [NSDate date];
        day = [birthDay daysToDate:curDate];
        week = day / 7;
        month = [birthDay monthsToDate:curDate];
    }
    
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_GetUserTask;
    [request setParam:[NSString stringWithFormat:@"%d", [UserInfo sharedUserInfo].BID] forKey:@"BID"];
    [request setParam:[NSString stringWithFormat:@"%d", day] forKey:@"DAY"];
    [request setParam:[NSString stringWithFormat:@"%d", week] forKey:@"WEEK"];
    [request setParam:[NSString stringWithFormat:@"%d", month] forKey:@"MONTH"];
    [request setDelegate:self];
    [request setResEncoding:PumanRequestRes_JsonEncoding];
    [request postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    switch (afRequest.result) {
        case PumanRequest_Succeeded:
        {
            nowTasks = afRequest.resObj;
            nowTasksReady = YES;
            updating = NO;
            for (int i=0; i<[nowTasks count]; i++)
            {
                if (i >= kMaxTaskCount) break;
                NSDictionary *taskInfo = [nowTasks objectAtIndex:i];
                NSString *bgm = [taskInfo valueForKey:@"bgmfirst"];
                if (bgm)
                {
                    FileUploader *downloader = [[FileUploader alloc] init];
                    downloader.tag = i;
                    downloader.delegate = self;
                    [downloader downloadDataFromUrl:bgm];
                }
            }
            [self.delegate nowTaskDownloadSucceeded];
        }
            return;
        case PumanRequest_TimeOut:
            [self.delegate nowTaskDownloadFailed:@"任务加载失败，您当前的网络不太给力，点击重试。" needDismiss:YES];
            break;
        case 2:
        {
            nowTasksReady = YES;
            nowTasks = afRequest.resObj;
            updating = NO;
            [self.delegate nowTaskDownloadFailed:@"您已完成现阶段所有任务，真棒~" needDismiss:NO];
        }
            return;
        default:
            [self.delegate nowTaskDownloadFailed:@"任务加载失败，连接服务器出错。。。" needDismiss:YES];
            nowTasksFailed = YES;
            updating = NO;
            break;
    }
}

- (void)removeDoneTask:(NSDictionary *)taskInfo
{
    NSInteger tid = [[taskInfo valueForKey:_task_ID] integerValue];
    if (tid <= 6) return;
    for (NSInteger i=0; i<[nowTasks count]; i++)
    {
        NSDictionary *task = [nowTasks objectAtIndex:i];
        if ([[task valueForKey:_task_ID] integerValue] == tid)
        {
            [nowTasks removeObjectAtIndex:i];
            break;
        }
    }
    [self.delegate nowTaskDownloadSucceeded];
}

#pragma mark - downloader delegate

- (void)downloadResult:(NSData *)data downLoader:(FileUploader *)downLoader
{
    NSInteger index = downLoader.tag;
    if (index >= kMaxTaskCount) return;
    bgmData[index] = data;
}

@end
