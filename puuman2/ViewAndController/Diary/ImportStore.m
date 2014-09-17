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
#import "DiaryModel.h"
#import "DateFormatter.h"
#import <AVFoundation/AVFoundation.h>
#import "ErrorLog.h"
#import "DiaryFileManager.h"
#import "DiaryViewController.h"

static ImportStore * instance ;
@implementation ImportStore
+ (ImportStore *)shareImportStore
{
    if (!instance)
    {
        instance = [[ImportStore alloc] init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self customInit];

    }
    return self;
}

- (void)customInit
{
    photosArr= [[NSMutableArray alloc] init];
    diaryArrs = [[NSMutableArray alloc] init];
    progress = 0;
}

-(void)initWithImportData:(NSDictionary *)dataDic
{
    photosArr = [dataDic valueForKey:@"photos"];
    title = [dataDic valueForKey:@"title"];
    total = [[dataDic valueForKey:@"count"] integerValue];
    timeArrs = [dataDic valueForKey:@"createTime"];
    for (NSArray *arr in photosArr) {
        [self writeAndStoreWithPhotos:arr andTitle:title andCreateTime:[timeArrs objectAtIndex:[photosArr indexOfObject:arr]]];

    }
}



- (void)writeAndStoreWithPhotos:(NSArray *)photos andTitle:(NSString *)title_ andCreateTime:(NSDate *)createTime
{
    NSString *fileDir = [DiaryFileManager fileDirForDiaryType:DiaryTypeStrPhoto];
    if (!fileDir) return ;
    NSString *fileName = [DateFormatter stringFromDatetime:createTime];
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
        
        if (i == 0) {
            PostNotification(Noti_Imported, [NSNumber numberWithBool:YES]);
        }
      
    
        [paths addObject:filePath];
    }

    if (title == nil) title = @"";
    Diary *diary = [[Diary alloc] init];
    diary.title = title;
    diary.DCreateTime = createTime;
    diary.type1Str = DiaryTypeStrPhoto;
    diary.type1 = DiaryContentTypePhoto;
    diary.filePaths1 = paths;
    diary.UIdentity = [UserInfo sharedUserInfo].identity;
    diary.UID = [UserInfo sharedUserInfo].UID;
    diary.type2 = DiaryContentTypeNone;
    diary.deleted = NO;
    diary.uploaded = NO;
    [diaryArrs addObject:diary];
    [self performSelector:@selector(finishImport) withObject:nil afterDelay:0];
}

- (void)finishImport
{
    PostNotification(Noti_Imported, [NSNumber numberWithBool:NO]);
    [self addNewDiary];

}


- (void)addNewDiary
{
    for (Diary *dy in diaryArrs) {
        if (dy) {
            [[DiaryModel sharedDiaryModel] addNewDiary:dy];
        }
    }
}

- (void)reset
{
    [photosArr removeAllObjects];
    title = @"";
    [diaryArrs removeAllObjects];
     progress = 0;
}
@end
