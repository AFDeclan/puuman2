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
    NSString *fileDir = [DiaryFileManager fileDirForDiaryType:DiaryTypeStrPhoto];
    if (!fileDir) return ;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSMutableArray * paths = [[NSMutableArray alloc] initWithCapacity:photos.count];
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
        PostNotification(Noti_Imported, [NSNumber numberWithInt:i+1]);
        [paths addObject:filePath];
    }
    
    if (title == nil) title = @"";
    diary = [[Diary alloc] init];
    diary.title = title;
    diary.DCreateTime = [NSDate date];
    diary.type1Str = DiaryTypeStrPhoto;
    diary.type1 = DiaryContentTypePhoto;
    diary.filePaths1 = paths;
    diary.UIdentity = [UserInfo sharedUserInfo].identity;
    diary.type2 = DiaryContentTypeNone;
    diary.deleted = NO;
    TaskUploader *uploader = [TaskUploader uploader];
    [uploader addNewTaskWithDiaryInfo:diary taskInfo:nil];

    
}

- (void)addNewDiary
{
    if (diary) {
        [[DiaryModel sharedDiaryModel] addNewDiary:diary];
    }

    
}

- (void)reset
{
    photosArr = nil;
    title = @"";
    //diaryInfo = nil;
     progress = 0;
}
@end
