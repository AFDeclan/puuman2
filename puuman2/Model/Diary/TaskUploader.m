//
//  TaskUploader.m
//  puman
//
//  Created by 陈晔 on 13-7-10.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "UniverseConstant.h"
#import "TaskUploader.h"
#import "AppDelegate.h"
#import "FileUploader.h"
#import "DiaryModel.h"
#import "MD5.h"
#import "TaskModel.h"
#import "DateFormatter.h"
#import "PumanRequest.h"

static TaskUploader *instance = nil;

@implementation TaskUploader

@synthesize uploadList = _uploadList;

+ (void)init
{
    instance = [[TaskUploader alloc] init];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self readWaitForUploadTasks];
        if ([_uploadList count] > 0)
            [self performSelectorInBackground:@selector(startUpload) withObject:nil];
    }
    return self;
}

- (void)readWaitForUploadTasks
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _uploadList = [[NSMutableArray alloc] initWithArray:[defaults valueForKey:tasks_wait_for_upload]];
}

- (void)writeWaitForUploadTasks
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_uploadList forKey:tasks_wait_for_upload];
}

- (void)addNewTask:(NSDictionary *)info
{
    if (![[info valueForKey:taskIDKey] isEqualToString:@"6"])
    {
        for (NSDictionary *old in _uploadList)
        {
            if ([[old valueForKey:userIDKey]isEqualToString: [info valueForKey:userIDKey]] &&
                [[old valueForKey:taskIDKey]isEqualToString: [info valueForKey:taskIDKey]])
                return;
        }
    }
    [_uploadList addObject:info];
    if (![[info valueForKey:taskIDKey] isEqualToString:@"6"])
        [[TaskModel sharedTaskModel] removeDoneTasks];
    [self writeWaitForUploadTasks];
    if (!uploading)
        [self performSelectorInBackground:@selector(startUpload) withObject:nil];
}


- (void)addNewTaskWithDiaryInfo:(NSDictionary *)diaryInfo taskInfo:(NSDictionary *)taskInfo
{
    if (![UserInfo sharedUserInfo].logined) return;
    NSString *tid;
    if (taskInfo != nil) //taskDiary
    {
        tid = [taskInfo valueForKey:_task_ID];
    }
    else
    {
        tid = @"6";
    }
    NSString *uid = [NSString stringWithFormat:@"%d", [UserInfo sharedUserInfo].UID];
    NSDate *date = [diaryInfo valueForKey:kDateName];
    NSString *name = [DateFormatter stringFromDatetime:date];
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:name, renameKey, tid, taskIDKey, diaryInfo, diaryInfoKey, uid, userIDKey, nil];
    [self addNewTask:info];
}

- (void)addNewTaskToDeleteDiary:(NSDictionary *)diaryInfo
{
    if (![UserInfo sharedUserInfo].logined) return;
    NSString *uid = [NSString stringWithFormat:@"%d", [UserInfo sharedUserInfo].UID];
    NSDate *date = [diaryInfo valueForKey:kDateName];
    NSString *name = [DateFormatter stringFromDatetime:date];
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:name, renameKey, @"-1", taskIDKey, uid, userIDKey, diaryInfo, diaryInfoKey, nil];
    [self addNewTask:info];
}

- (BOOL)uploadTask:(NSDictionary *)info
{
    FileUploader *fUploader = [[FileUploader alloc]init];
    NSString *userID = [info valueForKey:userIDKey];
    NSString *userDir = userID;//[MD5 md5:userID];
    NSDictionary *diaryInfo = [info valueForKey:diaryInfoKey];
    NSInteger subCnt1 = 1;
    NSInteger subCnt2 = 1;
    NSString *type1 = @"";
    NSString *type2 = @"";
    NSString *name = @"";
    NSString *dir1 = @"";
    NSString *dir2 = @"";
    NSString *diaryCreateTime = [DateFormatter stringFromDatetime:[diaryInfo valueForKey:kDateName]];
    if (diaryInfo && ![[info valueForKey:taskIDKey] isEqualToString:@"-1"])
    {
        type1 = [diaryInfo valueForKey:kTypeName];
        name = [info valueForKey:renameKey];
        NSString *path1 = [diaryInfo valueForKey:kFilePathName];
        //if ([[diaryInfo valueForKey:kTypeName] isEqualToString:vType_Audio])
        //    name = [name stringByAppendingPathExtension:@"aac"];
        BOOL suc;
        
        if (type1 && path1)
        {
            
            NSArray *pathArray = [path1 componentsSeparatedByString:@"#@#"];
            subCnt1 = [pathArray count];
            for (int i=0; i<subCnt1; i++)
            {
                NSString *path = [pathArray objectAtIndex:i];
                dir1 = [userDir stringByAppendingPathComponent:type1];
                dir1 = [dir1 stringByAppendingPathComponent:name];
                suc = [fUploader uploadFile:path toDir:dir1 fileRename:[NSString stringWithFormat:@"%d", i]];
                if (!suc) return NO;
            }
        }
        
        type2 = [diaryInfo valueForKey:kType2Name];
        NSString *path2 = [diaryInfo valueForKey:kFilePath2Name];
        
        if (type2 && path2 && ![path2 isEqualToString:@""])
        {
            NSArray *pathArray = [path2 componentsSeparatedByString:@"#@#"];
            subCnt2 = [pathArray count];
            for (int i=0; i<subCnt2; i++)
            {
                NSString *path = [pathArray objectAtIndex:i];
                dir2 = [userDir stringByAppendingPathComponent:type2];
                dir2 = [dir2 stringByAppendingPathComponent:name];
                suc = [fUploader uploadFile:path toDir:dir2 fileRename:[NSString stringWithFormat:@"%d", i]];
                if (!suc) return NO;
            }
        }
        
    }


    
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_UploadUserTask;
    [request setParam:[MobClick getConfigParams:umeng_onlineConfig_authKey] forKey:@"authCode"];
    [request setParam:userID forKey:@"UID"];
    [request setParam:[info valueForKey:taskIDKey] forKey:@"TID"];
    [request setParam:[diaryInfo valueForKey:kTitleName] forKey:@"title"];
    [request setParam:[NSString stringWithFormat:@"%d", subCnt1] forKey:@"subCnt1"];
    [request setParam:[NSString stringWithFormat:@"%d", subCnt2] forKey:@"subCnt2"];
    [request setParam:type1 forKey:@"type1"];
    [request setParam:type2 forKey:@"type2"];
    NSString *url1 = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@", dir1];
    NSString *url2 = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@", dir2];
    [request setParam:url1 forKey:@"url1"];
    [request setParam:url2 forKey:@"url2"];
    [request setParam:diaryCreateTime forKey:@"createTime"];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
        return YES;
    else return NO;
}

- (void)startUpload
{
    uploading = YES;
    while ([_uploadList count] > 0) {
        NSDictionary *info = [_uploadList objectAtIndex:0];
        if (info)
        {
            if ([self uploadTask:info])
            {
                [_uploadList removeObjectAtIndex:0];
                [self writeWaitForUploadTasks];
            }
            else sleep(5000);
        }
    }
    TaskModel *taskModel = [TaskModel sharedTaskModel];
    if (!taskModel.updating)
        [taskModel updateTasks];
    [[UserInfo sharedUserInfo] updateUserInfo];
    uploading = NO;
}

+ (TaskUploader *)uploader
{
    if (!instance)
        instance = [[TaskUploader alloc] init];
    return instance;
}

@end
