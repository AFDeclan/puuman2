//
//  Diary.m
//  puuman model
//
//  Created by Declan on 14-5-6.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Diary.h"
#import "DiaryModel.h"
#import "DiaryFileManager.h"
#import "DateFormatter.h"

#define kDateName       @"date"
#define kTypeStr        @"typeStr"
#define kType2Str       @"type2Str"
#define kTypeName       @"type"

#define kType2Name      @"type2"
#define kTitleName      @"title"
#define kFilePathName   @"filePath"
#define kFilePath2Name  @"filePath2"
#define kUrlName        @"url"
#define kUrl2Name       @"url2"
#define kUID            @"UID"
#define kUTID           @"UTID"
#define kDiaryUIdentity @"DiaryUIdentity"
#define kDeletedDiary   @"deletedDiary"
#define kDiaryMeta      @"DiaryMeta"
static NSString * typeStrs[5] = {DiaryTypeStrNone, DiaryTypeStrText, DiaryTypeStrPhoto, DiaryTypeStrAudio, DiaryTypeStrVideo};

@implementation Diary

- (id)init
{
    if (self = [super init]) {
        _sampleDiary = NO;
        _filePaths1 = [[NSArray alloc] init];
        _filePaths2 = [[NSArray alloc] init];
        _urls1 = [[NSArray alloc] init];
        _urls2 = [[NSArray alloc] init];
        _meta = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)setType1:(DiaryContentTypes)type1
{
    _type1 = type1;
    _type1Str = typeStrs[type1];
}

- (void)setType2:(DiaryContentTypes)type2
{
    _type2 = type2;
    _type2Str = typeStrs[type2];
}

- (void)setType1Str:(NSString *)type1Str
{
    _type1Str = type1Str;
    _type1 = DiaryContentTypeNone;
    for (int i=0; i<5; i++) {
        if ([typeStrs[i] isEqualToString:type1Str]) {
            _type1 = (DiaryContentTypes)i;
            break;
        }
    }
}

- (void)setType2Str:(NSString *)type2Str
{
    _type2Str = type2Str;
    _type2 = DiaryContentTypeNone;
    for (int i=0; i<5; i++) {
        if ([typeStrs[i] isEqualToString:type2Str]) {
            _type2 = (DiaryContentTypes)i;
            break;
        }
    }
}

- (void)setFilePaths1:(NSArray *)filePaths1
{
    _filePaths1 = [self fixedFilePath:filePaths1];
}

- (void)setFilePaths2:(NSArray *)filePaths2
{
    _filePaths2 = [self fixedFilePath:filePaths2];
}

- (NSArray *)fixedFilePath:(NSArray *)paths
{
    if (_sampleDiary) {
        return paths;
    }else{
        NSMutableArray *fixed = [[NSMutableArray alloc] init];
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        for (NSString *filePath in paths)
        {
            NSRange range = [filePath rangeOfString:@"Documents/"];
            NSString *subPath = filePath;
            if (range.location != NSNotFound)
            {
                subPath = [subPath substringFromIndex:range.location + range.length];
            }
            NSString *fixed0 = [docDir stringByAppendingPathComponent:subPath];
            [fixed addObject:fixed0];
        }
        return fixed;
    }
    
}

- (BOOL)createdByBabyData
{
    return [[_meta valueForKey:DiaryMetaKeyWhetherBabyData] boolValue];
}

- (void)setCreatedByBabyData:(BOOL)whether
{
    [_meta setValue:[NSNumber numberWithBool:whether] forKey:DiaryMetaKeyWhetherBabyData];
}

- (NSInteger)taskId
{
    return [[_meta valueForKey:DiaryMetaKeyTaskId] integerValue];
}

- (BOOL)rewarded
{
    return [[_meta valueForKey:DiaryMetaKeyRewarded] boolValue];
}

- (BOOL)reward:(CGFloat)cnt
{
   // assert(_UIdentity != [UserInfo sharedUserInfo].identity);
    assert(![self rewarded]);
    PumanRequest * req = [[PumanRequest alloc] init];
    req.urlStr = kUrl_RewardDiary;
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [req setIntegerParam:[UserInfo sharedUserInfo].BID forKey:@"BID"];
    [req setFloatParam:cnt forKey:@"cnt"];
    [req setParam:[DateFormatter timestampStrFromDatetime:_DCreateTime] forKey:@"DCreateTime"];
    [req setTimeOutSeconds:5];
    [req postSynchronous];
    if (req.result == PumanRequest_Succeeded) {
      // [_meta setValue:[NSNumber numberWithBool:YES] forKey:DiaryMetaKeyRewarded];
        BOOL up = [[DiaryModel sharedDiaryModel] updateDiary:self needUpload:YES];
        assert(up);
        return YES;
    }
    return NO;
}

- (void)setRewarded
{
    [_meta setValue:[NSNumber numberWithBool:YES] forKey:DiaryMetaKeyRewarded];
}

- (void)setTaskId:(NSInteger)tid
{
    [_meta setValue:[NSNumber numberWithInteger:tid] forKey:DiaryMetaKeyTaskId];
}

- (void)setUrls1WithMainUrl:(NSString *)url andSubcnt:(NSInteger)cnt
{
    NSMutableArray * urls = [NSMutableArray arrayWithCapacity:cnt];
    for (int i=0; i<cnt; i++) {
        [urls addObject:[NSString stringWithFormat:@"%@/%d", url, i]];
    }
    _urls1 = urls;
}

- (void)setUrls2WithMainUrl:(NSString *)url andSubcnt:(NSInteger)cnt
{
    NSMutableArray * urls = [NSMutableArray arrayWithCapacity:cnt];
    for (int i=0; i<cnt; i++) {
        [urls addObject:[NSString stringWithFormat:@"%@/%d", url, i]];
    }
    _urls2 = urls;
}

- (void)download
{
    FileUploader *downloader = [[FileUploader alloc] init];
    NSMutableArray * path1 = [[NSMutableArray alloc] initWithCapacity:_urls1.count];
    for (NSInteger i=0; i<_urls1.count; i++)
    {
        NSString *url = [_urls1 objectAtIndex:i];
        NSData *fileData;
        NSString *filePath = [NSString stringWithFormat:@"%d",i];
        for (NSInteger j=0; j<100; j++) //尝试100次
        {
            
            fileData = [downloader downloadDataSynchoronusFromUrl:url];
            if (fileData) break;
        }
        if (fileData)
        {
            //save the file
            NSString *fileDir = [DiaryFileManager fileDirForDiaryType:_type1Str];
            NSString *fileName = [DateFormatter stringFromDatetime:_DCreateTime];
            filePath = [filePath stringByAppendingString:fileName];
            filePath = [fileDir stringByAppendingPathComponent:filePath];
            if (_type1 == DiaryContentTypeVideo) {
                filePath = [filePath stringByAppendingPathExtension:@"MOV"];
            }
            [fileData writeToFile:filePath atomically:YES];
            [path1 addObject:filePath];
        }
    }
    _filePaths1 = path1;
    
    if (_type2 != DiaryContentTypeNone)
    {
        NSMutableArray * path2 = [[NSMutableArray alloc] initWithCapacity:_urls2.count];
        for (NSInteger i=0; i<_urls2.count; i++)
        {
            NSString *url = [_urls2 objectAtIndex:i];
            NSData *fileData;
            for (NSInteger j=0; j<100; j++) //尝试100次
            {
                
                fileData = [downloader downloadDataSynchoronusFromUrl:url];
                if (fileData) break;
            }
            if (fileData)
            {
                //save the file
                NSString *fileDir = [DiaryFileManager fileDirForDiaryType:_type2Str];
                NSString *fileName = [DateFormatter stringFromDatetime:_DCreateTime];
                NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
                filePath = [filePath stringByAppendingString:@"_src2"];
                [fileData writeToFile:filePath atomically:YES];
                [path2 addObject:filePath];
            }
        }
        _filePaths2 = path2;
    }
}

- (void)redownloadContent1AtIndex:(NSInteger)index withRecall:(DiaryRecallBlock)block
{
    if (index >= _urls1.count || ![_urls1 objectAtIndex:index]) return;
    if (!_blocks) {
        _blocks = [[NSMutableDictionary alloc] init];
    }
    FileUploader *downloader = [[FileUploader alloc] init];
    downloader.delegate = self;
    downloader.tag = 1;
    [_blocks setValue:block forKey:[_urls1 objectAtIndex:index]];
    [downloader downloadDataFromUrl:[_urls1 objectAtIndex:index]];
}

- (void)redownloadContent2AtIndex:(NSInteger)index withRecall:(DiaryRecallBlock)block
{
    if (index >= _urls2.count || ![_urls2 objectAtIndex:index]) return;
    if (!_blocks) {
        _blocks = [[NSMutableDictionary alloc] init];
    }
    FileUploader *downloader = [[FileUploader alloc] init];
    downloader.delegate = self;
    downloader.tag = 2;
    [_blocks setValue:block forKey:[_urls2 objectAtIndex:index]];
    [downloader downloadDataFromUrl:[_urls2 objectAtIndex:index]];
}

- (void)downloadResult:(NSData *)data downLoader:(FileUploader *)downLoader
{
    NSString * url = downLoader.targetUrl;
    DiaryRecallBlock block = [_blocks valueForKey:url];
    if (data) {
        NSArray * paths, * urls;
        if (downLoader.tag == 1) {
            paths = _filePaths1;
            urls = _urls1;
        } else {
            paths = _filePaths2;
            urls = _urls2;
        }
        for (int i=0; i<urls.count; i++) {
            if ([[urls objectAtIndex:i] isEqualToString:url]) {
                NSString *filePath = [paths objectAtIndex:i];
                [data writeToFile:filePath atomically:YES];
                break;
            }
        }
        block(YES);
    } else {
        block(NO);
    }
}

- (BOOL)uploadDiary
{
    FileUploader *fUploader = [[FileUploader alloc]init];
    NSString *userDir = [NSString stringWithFormat:@"%ld", (long)_UID];

    NSInteger subCnt1 = 1;
    NSInteger subCnt2 = 1;
    NSString *type1 = @"";
    NSString *type2 = @"";
    NSString *name = @"";
    NSString *dir1 = @"";
    NSString *dir2 = @"";
    
    NSString *diaryCreateTime = [DateFormatter stringFromDatetime:_DCreateTime];
    
    NSInteger tid = [self taskId];
    if (tid == 0) tid = 6;
    
    if (!_deleted)
    {
        type1 = _type1Str;
        name = [DateFormatter stringFromDatetime:_DCreateTime];
        NSArray *path1 = _filePaths1;
        BOOL suc;
        
        if (_type1 != DiaryContentTypeNone && path1.count > 0)
        {
            subCnt1 = [path1 count];
            for (int i=0; i<subCnt1; i++)
            {
                NSString *path = [path1 objectAtIndex:i];
                dir1 = [userDir stringByAppendingPathComponent:type1];
                dir1 = [dir1 stringByAppendingPathComponent:name];
                suc = [fUploader uploadFile:path toDir:dir1 fileRename:[NSString stringWithFormat:@"%d", i]];
                if (!suc) return NO;
            }
        }
        
        type2 = _type2Str;
        NSArray * path2 = _filePaths2;
        
        if (_type2 != DiaryContentTypeNone && path2.count > 0)
        {
            subCnt2 = [path2 count];
            for (int i=0; i<subCnt2; i++)
            {
                NSString *path = [path2 objectAtIndex:i];
                dir2 = [userDir stringByAppendingPathComponent:type2];
                dir2 = [dir2 stringByAppendingPathComponent:name];
                suc = [fUploader uploadFile:path toDir:dir2 fileRename:[NSString stringWithFormat:@"%d", i]];
                if (!suc) return NO;
            }
        }
        
    } else {
        tid = -1;
    }
    
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_UploadUserTask;
    [request setIntegerParam:_UID forKey:@"UID"];
    [request setIntegerParam:tid forKey:@"TID"];
    [request setParam:_title forKey:@"title"];
    [request setParam:[NSString stringWithFormat:@"%d", subCnt1] forKey:@"subCnt1"];
    [request setParam:[NSString stringWithFormat:@"%d", subCnt2] forKey:@"subCnt2"];
    [request setParam:type1 forKey:@"type1"];
    [request setParam:type2 forKey:@"type2"];
    NSString *url1 = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@", dir1];
    NSString *url2 = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@", dir2];
    [request setParam:url1 forKey:@"url1"];
    [request setParam:url2 forKey:@"url2"];
    [request setParam:diaryCreateTime forKey:@"DCreateTime"];
    [request setParam:_meta forKey:@"Meta" usingFormat:AFDataFormat_Json];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        return YES;
    }else{
        return NO;
    }

}


@end
