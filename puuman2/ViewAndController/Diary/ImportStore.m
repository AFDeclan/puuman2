//
//  ImportStore.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-2-25.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ImportStore.h"
#import "UniverseConstant.h"
#import "UserInfo.h"
#import "TaskUploader.h"
#import "DiaryModel.h"
#import "DateFormatter.h"
#import <AVFoundation/AVFoundation.h>
#import "ErrorLog.h"
#import "DiaryFileManager.h"
#import "DiaryViewController.h"

static ImportStore * instance;
@implementation ImportStore
+ (ImportStore *)shareImportStore
{
    if (!instance)
    {
        instance = [[ImportStore alloc] init];
        [instance customInit];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)customInit
{
    photosArr= [[NSMutableArray alloc] init];
    progress = 0;
}

-(void)initWithImportData:(NSDictionary *)dataDic
{
   
    photosArr = [dataDic valueForKey:@"photos"];
    title = [dataDic valueForKey:@"title"];
    [[DiaryViewController sharedDiaryViewController] setImportTotalNum:[photosArr count]];
    [self writeAndStoreWithPhotos:photosArr andTitle:title];
}



- (void)writeAndStoreWithPhotos:(NSArray *)photos andTitle:(NSString *)title_
{
    NSString *fileDir = [DiaryFileManager fileDirForDiaryType:vType_Photo];
    if (!fileDir) return ;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSString *filePathAll = nil;
    NSError *error;
    for (int i=0; i<[photos count]; i++)
    {
        NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
        filePath = [filePath stringByAppendingFormat:@"_%d.jpg", i];
        NSData *imageData = UIImageJPEGRepresentation(photos[i], 0);
        if (![imageData writeToFile:filePath atomically:YES])
        {
            [ErrorLog errorLog:@"Save photo failed - 1" fromFile:@"DiaryFileManager.m" error:error];
        }
        if (i == 0) filePathAll = filePath;
        else filePathAll = [filePathAll stringByAppendingFormat:@"#@#%@", filePath];
    }
    NSString *type2 = @"", *filePath2 = @"";
    //buildDiaryInfo
    
    if (title == nil) title = @"";
    NSString *taskDiary = @"";
   diaryInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                               title, kTitleName,
                               vType_Photo, kTypeName,
                               filePathAll, kFilePathName,
                               curDate, kDateName,
                               type2, kType2Name,
                               filePath2, kFilePath2Name,
                               taskDiary, kTaskDiary,
                               nil];

    TaskUploader *uploader = [TaskUploader uploader];
    [uploader addNewTaskWithDiaryInfo:diaryInfo taskInfo:nil];

    
}

- (void)addNewDiary
{
    if (diaryInfo) {
        [[DiaryModel sharedDiaryModel] addNewDiary:diaryInfo];
    }

    
}
- (void)reset
{
    photosArr = nil;
    title = @"";
    diaryInfo = nil;
     progress = 0;
}
@end
