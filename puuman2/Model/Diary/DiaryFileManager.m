
//
//  FileManager.m
//  puman
//
//  Created by 陈晔 on 13-11-9.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryFileManager.h"
#import "UserInfo.h"
#import "ErrorLog.h"
#import "UIImage+CroppedImage.h"
#import <AVFoundation/AVFoundation.h>
#import "DiaryModel.h"
#import "DateFormatter.h"
#import "Forum.h"
#import "ReplyForUpload.h"
#import "Diary.h"
#import "TaskModel.h"

@implementation DiaryFileManager

+ (NSString *)fileDirForDiaryType:(NSString *)type
{
    NSString *fileDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    NSString *userDir;
    if (!userInfo.logined)
    {
        userDir = @"UnLogined";
    }
    else
    {
        userDir = [NSString stringWithFormat:@"Baby%d", [UserInfo sharedUserInfo].BID];
    }
    
    fileDir = [fileDir stringByAppendingPathComponent:userDir];
    fileDir = [fileDir stringByAppendingPathComponent:type];
    NSError *error;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:&error])
    {
        
        [ErrorLog errorLog:@"Create fileDir failed" fromFile:@"DiaryFileManager.m" error:nil];
//        return nil;
    }
    return fileDir;
}

+ (NSString *)tmpDir
{
    NSString *fileDir = NSTemporaryDirectory();
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    NSString *userDir;
    if (!userInfo.logined)
    {
        userDir = @"UnLogined";
    }
    else
    {
        userDir = [NSString stringWithFormat:@"Baby%d", [UserInfo sharedUserInfo].BID];
    }
    
    fileDir = [fileDir stringByAppendingPathComponent:userDir];
    NSError *error;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:&error])
    {
        
        [ErrorLog errorLog:@"Create fileDir failed" fromFile:@"DiaryFileManager.m" error:nil];
        return nil;
    }
    return fileDir;

}

+ (UIImage *)imageForVideo:(NSString *)filePath
{
    if (!filePath) return nil;
    NSString *cutImagePath = [filePath stringByAppendingString:@"_cutImage"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cutImagePath])
    {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:cutImagePath];
        if (image) return image;
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef cgImage = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *image = [[UIImage alloc] initWithCGImage:cgImage];
    if (image)
    {
        [UIImageJPEGRepresentation(image, 0) writeToFile:cutImagePath atomically:YES];
    }
    else
        image = [[UIImage alloc] init];
    return image;
}

+ (UIImage *)imageForVideo:(NSString *)filePath withDuraTion:(NSTimeInterval)duration
{
    if (!filePath) return nil;
    NSString *cutImagePath = [filePath stringByAppendingString:@"_cutImage"];
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cutImagePath])
//    {
//        UIImage *image = [[UIImage alloc] initWithContentsOfFile:cutImagePath];
//        if (image) return image;
//    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(duration, 600);
    NSError *error = nil;
    CMTime actualTime  =time;
    CGImageRef cgImage = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *image = [[UIImage alloc] initWithCGImage:cgImage];
    if (image)
    {
        [UIImageJPEGRepresentation(image, 0) writeToFile:cutImagePath atomically:YES];
    }
    else
        image = [[UIImage alloc] init];
    return image;
}

+ (UIImage *)thumbImageForPath:(NSString *)filePath
{
    NSString *thumbPath = [self thumbImagePathForPath:filePath];
    NSData *data = [[AFDataStore sharedStore] getDataFromPath:thumbPath needCache:YES];
    if (data)
        return [UIImage imageWithData:data];
    else
    {
        data = [[AFDataStore sharedStore] getDataFromPath:filePath needCache:YES];
        if (data) {
            UIImage *thumbImage = [UIImage croppedImage:[UIImage imageWithData:data] WithHeight:464 andWidth:464];
            [UIImageJPEGRepresentation(thumbImage, 0) writeToFile:thumbPath atomically:YES];
            return thumbImage;
        }
        
    }
    return nil;
}

+ (UIImage *)imageForPath:(NSString *)filePath
{
    NSData *data = [[AFDataStore sharedStore] getDataFromPath:filePath needCache:NO];
    if (data) return [UIImage imageWithData:data];
    else return nil;
}

+ (NSString *)thumbImagePathForPath:(NSString *)filePath
{
    return [NSString stringWithFormat:@"%@%@", filePath, @"_thumb464"];
}

+ (NSString *)fixedFilePath:(NSString *)filePathAll
{
    if([filePathAll isEqualToString:@""])
    {
        return filePathAll;
    }
    NSArray *filePaths = [filePathAll componentsSeparatedByString:@"#@#"];
    NSString *fixed;
    BOOL first = YES;
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    for (NSString *filePath in filePaths)
    {
        NSRange range = [filePath rangeOfString:@"Documents/"];
        NSString *subPath = filePath;
        if (range.location != NSNotFound)
        {
            subPath = [subPath substringFromIndex:range.location + range.length];
        }
        NSString *fixed0 = [docDir stringByAppendingPathComponent:subPath];
        if (first)
        {
            first = NO;
            fixed = fixed0;
        }
        else fixed = [fixed stringByAppendingFormat:@"#@#%@", fixed0];
    }
    return fixed;
}

+ (Diary *)saveText:(NSString *)text withPhoto:(UIImage *)photo withTitle:(NSString *)title  andIsTopic:(BOOL)isTopic andBabyData:(BOOL)babyData andTaskInfo:(NSDictionary *)taskInfo createDate:(NSDate *)date
{
    //save the file
    if (isTopic) {
        ReplyForUpload *upload = [[Forum sharedInstance] createReplyForUpload];
        [upload setTexts:[NSArray arrayWithObject:text]];
        if (!title) {
            title = @"";
        }
        [upload setRTitle:title];
        [upload upload];
    }
    
    NSString *fileDir = [self fileDirForDiaryType:DiaryTypeStrText];
    if (!fileDir) return nil;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
    NSString *filePath2 = [filePath stringByAppendingString:@"_src2"];
    filePath = [filePath stringByAppendingPathExtension:@"txt"];
    filePath2 = [filePath2 stringByAppendingPathExtension:@"jpg"];
    NSError *error;
    if (![text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error])
    {
        
        [ErrorLog errorLog:  @"Save text failed!"fromFile:@"DiaryFileManager.m" error:error];
        return nil;
    }
    DiaryContentTypes type2 = DiaryContentTypeNone;
    if (photo)
    {
        type2 = DiaryContentTypePhoto;
        NSData *imageData = UIImageJPEGRepresentation(photo, 0);
        if (![imageData writeToFile:filePath2 atomically:YES])
        {
            [ErrorLog errorLog:  @"Save photo failed - 0"fromFile:@"DiaryFileManager.m" error:error];
            filePath2 = @"";
        }
    }
    else filePath2 = @"";
    //buildDiaryInfo
    if (!title) title = @"";
    Diary * d = [[Diary alloc] init];
    d.title = title;
    if (date) {
        d.DCreateTime = date;
    }else{
        d.DCreateTime = curDate;
    }
    d.UIdentity = [UserInfo sharedUserInfo].identity;
    d.UID = [UserInfo sharedUserInfo].UID;
    d.type1 = DiaryContentTypeText;
    d.type2 = type2;
    d.filePaths1 = [NSArray arrayWithObject:filePath];
    d.filePaths2 = [NSArray arrayWithObject:filePath2];
    d.deleted = NO;
    [d setCreatedByBabyData:babyData];
    if (taskInfo) {
        [d setTaskId:[[taskInfo valueForKey:_task_ID] integerValue]];
    }
    [[DiaryModel sharedDiaryModel] addNewDiary:d];
    [[TaskModel sharedTaskModel] removeDoneTask:taskInfo];
    [MobClick endEvent:umeng_event_newdiary label:@"TextDiary"];
    return d;
}

+ (Diary *)savePhotos:(NSArray *)photos withAudio:(NSURL *)audioUrl withTitle:(NSString *)title  andTaskInfo:(NSDictionary *)taskInfo andIsTopic:(BOOL)isTopic
{
    //save the file
    NSString *fileDir = [self fileDirForDiaryType:DiaryTypeStrPhoto];
    if (!fileDir) return nil;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSMutableArray * paths = [[NSMutableArray alloc] initWithCapacity:photos.count];
    NSError *error;
    if (isTopic) {
        ReplyForUpload *upload = [[Forum sharedInstance] createReplyForUpload];
        [upload setPhotos:photos];
        if (!title) {
            title = @"";
        }
        [upload setRTitle:title];
        [upload upload];
    }
    for (int i=0; i<[photos count]; i++)
    {
        NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
        filePath = [filePath stringByAppendingFormat:@"_%d.jpg", i];
        NSData *imageData = UIImageJPEGRepresentation(photos[i], 0);
        if (![imageData writeToFile:filePath atomically:YES])
        {
            [ErrorLog errorLog:@"Save photo failed - 1" fromFile:@"DiaryFileManager.m" error:error];
        }
        [paths addObject:filePath];
    }
    DiaryContentTypes type2 = DiaryContentTypeNone;
    NSString * filePath2 = @"";
    if (audioUrl)
    {
        filePath2 = [fileDir stringByAppendingPathComponent:fileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager moveItemAtURL:audioUrl toURL:[NSURL fileURLWithPath:filePath2] error:&error])
        {
            [ErrorLog errorLog:@"Save audio failed - 1"fromFile:@"DiaryFileManager.m" error:error];
        }
        else type2 = DiaryContentTypeAudio;
    }
    //buildDiaryInfo
    Diary * d = [[Diary alloc] init];
    d.title = title;
    d.DCreateTime = curDate;
    d.UIdentity = [UserInfo sharedUserInfo].identity;
    d.UID = [UserInfo sharedUserInfo].UID;
    d.type1 = DiaryContentTypePhoto;
    d.type2 = type2;
    d.filePaths1 = paths;
    d.filePaths2 = [NSArray arrayWithObject:filePath2];
    d.deleted = NO;
    if (taskInfo) {
        [d setTaskId:[[taskInfo valueForKey:_task_ID] integerValue]];
    }
    [[DiaryModel sharedDiaryModel] addNewDiary:d];
    [[TaskModel sharedTaskModel] removeDoneTask:taskInfo];
    [MobClick endEvent:umeng_event_newdiary label:@"PhotoDiary"];
    return d;
}

+ (Diary *)savePhotoWithPaths:(NSArray *)photoPaths withAudio:(NSURL *)audioUrl withTitle:(NSString *)title  andTaskInfo:(NSDictionary *)taskInfo andIsTopic:(BOOL)isTopic
{
   
    //save the file
    NSString *fileDir = [self fileDirForDiaryType:DiaryTypeStrPhoto];
    if (!fileDir) return nil;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (title == nil) title = @"";
    if (isTopic) {
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        for (int i = 0;i < [photoPaths count]; i ++) {
            NSData *data = [NSData dataWithContentsOfFile:[photoPaths objectAtIndex:i]];
            [photos addObject:[UIImage imageWithData:data]];
        }
        ReplyForUpload *upload = [[Forum sharedInstance] createReplyForUpload];
        [upload setPhotos:photos];
        if (!title) {
            title = @"";
        }
        [upload setRTitle:title];
        [upload upload];
        
    }
    NSMutableArray * paths = [[NSMutableArray alloc] initWithCapacity:photoPaths.count];
    for (int i=0; i<[photoPaths count]; i++)
    {
        NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
        filePath = [filePath stringByAppendingFormat:@"_%d.jpg", i];
        NSString *tmpPath = [photoPaths objectAtIndex:i];
        if (![fileManager moveItemAtPath:tmpPath toPath:filePath error:&error])
        {
            [ErrorLog errorLog:@"Save photo failed - 2" fromFile:@"DiaryFileManager.m" error:error];
        }
        [paths addObject:filePath];
    }
    DiaryContentTypes type2 = DiaryContentTypeNone;
    NSString *filePath2 = @"";
    if (audioUrl)
    {
        filePath2 = [fileDir stringByAppendingPathComponent:fileName];
        if (![fileManager moveItemAtURL:audioUrl toURL:[NSURL fileURLWithPath:filePath2] error:&error])
        {
            [ErrorLog errorLog:@"Save audio failed - 2" fromFile:@"DiaryFileManager.m" error:error];
        }
        else type2 = DiaryContentTypeAudio;
    }
    //buildDiaryInfo
    Diary * d = [[Diary alloc] init];
    d.title = title;
    d.DCreateTime = curDate;
    d.UIdentity = [UserInfo sharedUserInfo].identity;
    d.UID = [UserInfo sharedUserInfo].UID;
    d.type1 = DiaryContentTypePhoto;
    d.type2 = type2;
    d.filePaths1 = paths;
    d.filePaths2 = [NSArray arrayWithObject:filePath2];
    d.deleted = NO;
    if (taskInfo) {
        [d setTaskId:[[taskInfo valueForKey:_task_ID] integerValue]];
    }
    [[DiaryModel sharedDiaryModel] addNewDiary:d];
    [[TaskModel sharedTaskModel] removeDoneTask:taskInfo];
    [MobClick endEvent:umeng_event_newdiary label:@"PhotoDiary"];
    return d;
}

+ (Diary *)saveVideo:(NSURL *)tempUrl withTitle:(NSString *) title  andTaskInfo:(NSDictionary *)taskInfo
{
    //save the file
    NSString *fileDir = [self fileDirForDiaryType:DiaryTypeStrVideo];
    if (!fileDir) return nil;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    fileName = [fileName stringByAppendingPathExtension:@"Mov"];
    NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
    NSError *error;
    if (![[NSFileManager defaultManager] moveItemAtPath:[tempUrl path] toPath:filePath error:&error])
    {
        [ErrorLog errorLog: @"Save video failed!" fromFile:@"DiaryFileManager.m" error:error];
        return nil;
    }
    //save cutImage
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    CMTime actualTime;
    CGImageRef cgImage = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *image = [[UIImage alloc] initWithCGImage:cgImage];
    NSString *cutImagePath = [filePath stringByAppendingString:@"_cutImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0);
    if (![imageData writeToFile:cutImagePath atomically:YES])
    {
        
        [ErrorLog errorLog:@"Save movie Image cut failed!" fromFile:@"DiaryFileManager.m" error:error];
    }
    //buildDiaryInfo
    if (!title) title = @"";
    Diary * d = [[Diary alloc] init];
    d.title = title;
    d.DCreateTime = curDate;
    d.UIdentity = [UserInfo sharedUserInfo].identity;
    d.UID = [UserInfo sharedUserInfo].UID;
    d.type1 = DiaryContentTypeVideo;
    d.type2 = DiaryContentTypeNone;
    d.filePaths1 = [NSArray arrayWithObject:filePath];
    d.deleted = NO;
    if (taskInfo) {
        [d setTaskId:[[taskInfo valueForKey:_task_ID] integerValue]];
    }
    [[DiaryModel sharedDiaryModel] addNewDiary:d];
    [[TaskModel sharedTaskModel] removeDoneTask:taskInfo];
    [MobClick endEvent:umeng_event_newdiary label:@"VideoDiary"];
    return d;
}

+ (Diary *)saveAudio:(NSURL *)audioUrl withTitle:(NSString *)title  andTaskInfo:(NSDictionary *)taskInfo
{
    //save file
    NSString *fileDir = [self fileDirForDiaryType:DiaryTypeStrAudio];
    if (!fileDir) return nil;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
    NSError *error;
    if (![[NSFileManager defaultManager] moveItemAtURL:audioUrl toURL:[NSURL fileURLWithPath:filePath] error:&error])
    {
        [ErrorLog errorLog:  @"Save audio failed - 3" fromFile:@"DiaryFileManager.m" error:error];
        return nil;
    }
    //buildDiaryInfo
    if (!title) title = @"";
    Diary * d = [[Diary alloc] init];
    d.title = title;
    d.DCreateTime = curDate;
    d.UIdentity = [UserInfo sharedUserInfo].identity;
    d.UID = [UserInfo sharedUserInfo].UID;
    d.type1 = DiaryContentTypeAudio;
    d.type2 = DiaryContentTypeNone;
    d.filePaths1 = [NSArray arrayWithObject:filePath];
    d.deleted = NO;
    if (taskInfo) {
        [d setTaskId:[[taskInfo valueForKey:_task_ID] integerValue]];
    }
    [[DiaryModel sharedDiaryModel] addNewDiary:d];
    [[TaskModel sharedTaskModel] removeDoneTask:taskInfo];
    [MobClick endEvent:umeng_event_newdiary label:@"AudioDiary"];
    return d;
}

+ (NSString *)saveTmpPhoto:(UIImage *)photo
{
    static int tempNum = 0;
    NSString *tmpDir = [self tmpDir];
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    fileName = [NSString stringWithFormat:@"%@_%d", fileName, tempNum++];
    NSString *filePath = [tmpDir stringByAppendingPathComponent:fileName];
    filePath = [filePath stringByAppendingPathExtension:@"jpg"];
    if (![UIImageJPEGRepresentation(photo, 0) writeToFile:filePath atomically:YES])
    {
        [ErrorLog errorLog:  @"Save tmp photo failed" fromFile:@"DiaryFileManager.m" error:nil];
        return nil;
    }
    return filePath;
}


@end
