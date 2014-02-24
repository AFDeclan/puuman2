//
//  TaskUploader.h
//  puman
//
//  Created by 陈晔 on 13-7-10.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

#define diaryInfoKey        @"DiaryInfo"
#define taskIDKey           @"TaskID"
#define userIDKey           @"UserID"
#define renameKey           @"FileRename"

@interface TaskUploader : NSObject
{
    BOOL uploading;
}

@property (retain, readonly) NSMutableArray * uploadList;

- (void)addNewTask:(NSDictionary *)info;

- (void)addNewTaskWithDiaryInfo:(NSDictionary *)diaryInfo taskInfo:(NSDictionary *)taskInfo;

- (void)addNewTaskToDeleteDiary:(NSDictionary *)diaryInfo;

+ (void)init;

+ (TaskUploader *)uploader;

@end
