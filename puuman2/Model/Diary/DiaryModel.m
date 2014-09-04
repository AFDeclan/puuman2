//
//  DiaryModel.m
//  try
//
//  Created by 陈晔 on 13-3-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryModel.h"
#import "UserInfo.h"
#import <FMDatabase.h>
#import <FMResultSet.h>
#import "UniverseConstant.h"
#import "DateFormatter.h"
#import <Reachability.h>
#import "ErrorLog.h"
#import "DiaryFileManager.h"
#import "DiaryCell.h"
#import "Diary.h"
#import "TaskModel.h"
#import <JSONKit.h>

#define kDateName       @"date"
#define kTypeName       @"type"
#define kType2Name      @"type2"
#define kTitleName      @"title"
#define kFilePathName   @"filePath"
#define kFilePath2Name  @"filePath2"
#define kUrlName        @"url"
#define kUrl2Name       @"url2"
#define kDiaryUIdentity @"DiaryUIdentity"
#define kDeletedDiary   @"deletedDiary"
#define kUploaded       @"uploaded"
#define kDiaryMeta      @"DiaryMeta"

static DiaryModel * instance;

@implementation DiaryModel

@synthesize updateCnt = _updateCnt;
@synthesize downloadedCnt = _downloadedCnt;

+ (DiaryModel *)sharedDiaryModel
{
    if (!instance)
        instance = [[DiaryModel alloc] init];
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _diaries = [[NSMutableArray alloc] init];
        _deletedDiaries = [[NSMutableArray alloc] init];
        _toUploadDiaries = [[NSMutableArray alloc] init];
        _updateCnt = 0;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *dbPath = [documents stringByAppendingPathComponent:DBNAME];
        db= [FMDatabase databaseWithPath:dbPath] ;
        if (![db open]) {
            [ErrorLog errorLog:@"Could not open db." fromFile:@"DiaryModel.m" error:nil];
            NSLog(@"Could not open db.");
        }
        
    }
    return self;
}

- (void)reloadData
{
    NSString *tableName = [self sqliteTableName];
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY, %@ TEXT, %@ REAL, %@ INTEGER, %@ BLOB, %@ BLOB, %@ INTEGER, %@ BLOB, %@ BLOB, %@ INTEGER, %@ BLOB, %@ INTEGER, %@ INTEGER)", tableName, kTitleName, kDateName, kTypeName, kFilePathName, kUrlName, kType2Name, kFilePath2Name, kUrl2Name, kDiaryUIdentity, kDiaryMeta, kDeletedDiary, kUploaded];
    if (![db executeUpdate:sqlCreateTable])
    {
        [ErrorLog errorLog:@"Create table failed!" fromFile:@"DiaryModel.m" error:nil];
        NSLog(@"Create table failed!");
    }
    [_diaries removeAllObjects];
    [_deletedDiaries removeAllObjects];
    [_toUploadDiaries removeAllObjects];
    NSString *sqlSelect = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ DESC", tableName, kDateName];
    FMResultSet *rs = [db executeQuery: sqlSelect];
    while ([rs next])
    {
        Diary * diary = [[Diary alloc] init];
        NSString *title = [rs stringForColumn:kTitleName];
        if (title == nil) title = @"";
        diary.title = title;
        NSDate *date = [rs dateForColumn:kDateName];
        if (date == nil) date = [NSDate date];
        diary.DCreateTime = date;
        diary.type1 = [rs intForColumn:kTypeName];
        diary.type2 = [rs intForColumn:kType2Name];
        diary.filePaths1 = [[rs dataForColumn:kFilePathName] objectFromJSONData];
        if (diary.filePaths1.count == 0) continue;
        diary.filePaths2 = [[rs dataForColumn:kFilePath2Name] objectFromJSONData];
        if (diary.type2 != DiaryContentTypeNone && diary.filePaths2.count == 0) continue;
        diary.urls1 = [[rs dataForColumn:kUrlName] objectFromJSONData];
        diary.urls2 = [[rs dataForColumn:kUrl2Name] objectFromJSONData];
        diary.UIdentity = [rs intForColumn:kDiaryUIdentity];
        diary.deleted = [rs boolForColumn:kDeletedDiary];
        diary.uploaded = [rs intForColumn:kUploaded];
        NSData * metaData = [rs dataForColumn:kDiaryMeta];
        id info = [metaData objectFromJSONData];
        if (info) {
            diary.meta = [[NSMutableDictionary alloc] initWithDictionary:info];
        }
        
        if (diary.deleted)
        {
            [_deletedDiaries addObject:diary];
        }
        else
        {
            [_diaries addObject:diary];
        }
        if (diary.uploaded != 1) {
            [_toUploadDiaries insertObject:diary atIndex:0];
        }
    }
    [rs close];
    
    _sampleDiary = NO;
    if ([_diaries count] > 0) return;
    _sampleDiary = YES;
    
    //sample diary
    NSString *filePath;
    NSString *filePath2;
    NSDate *date = [MyUserDefaults valueForKey:kUDK_FirstEnterDate];
    if (!date) {
        date = [NSDate date];
        [MyUserDefaults setValue:date forKey:kUDK_FirstEnterDate];
    }
    
    //sample diary - text
    
    NSString *fileDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *typeDir = DiaryTypeStrText;
    NSString *fileDirText = [fileDir stringByAppendingPathComponent:typeDir];
    filePath = [fileDirText stringByAppendingPathComponent:sampleTextDiary1_fileName];
    NSString *content = @"Puu～Puu。你好^^，看你风尘仆仆的样子，找到这里很辛苦吧。不过在充满爱的这里你可以找到很多贴心好用的小工具哦，它们可以帮助您建立一段专属于你和宝宝之间非凡的记忆。再次欢迎你有缘人，尽情体验吧。";
    NSError *error;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:fileDirText withIntermediateDirectories:YES attributes:nil error:&error])
    {
        [ErrorLog errorLog: @"Create fileDir failed" fromFile:@"AppDelegate.m" error:error];
    }
    else if (![content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error])
    {
        [ErrorLog errorLog:  @"Write to file failed!" fromFile:@"AppDelegate.m" error:error];
    }
    Diary *d = [[Diary alloc] init];
    d.title = @"展开扑满日记，积累爱的奇迹。";
    d.DCreateTime = date;
    d.type1 = DiaryContentTypeText;
    d.type2 = DiaryContentTypeNone;
    d.sampleDiary = YES;
    d.filePaths1 = [NSArray arrayWithObject:filePath];
    [_diaries addObject:d];
    
    //sample diary - auphoto
    filePath = [[NSBundle mainBundle] pathForResource:@"sampleDiary_auphoto" ofType:@"jpg" ];
    filePath2 = [[NSBundle mainBundle] pathForResource:@"sampleDiary_auphoto" ofType:@"mp3" ];
    d = [[Diary alloc] init];
    d.title = @"";
    d.DCreateTime = date;
    d.type1 = DiaryContentTypePhoto;
    d.type2 = DiaryContentTypeAudio;
    d.sampleDiary = YES;
    d.filePaths1 = [NSArray arrayWithObject:filePath];
    d.filePaths2 = [NSArray arrayWithObject:filePath2];
    [_diaries addObject:d];
    
    _downloadedDiaries = [[NSMutableArray alloc] init];
    
    if (!_uploading) {
        [self performSelectorInBackground:@selector(uploadDiaries) withObject:nil];
    }
}

- (NSUInteger)diaryNotSampleNum
{
    if (!_sampleDiary) return [_diaries count];
    else
    {
        return 0;
    }
}

//新增日记，更新数据库以及model的数组
- (BOOL)addNewDiary:(Diary *)d
{
    NSString *tableName = [self sqliteTableName];
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0)", tableName, kTitleName, kDateName, kTypeName, kFilePathName, kUrlName, kType2Name, kFilePath2Name, kUrl2Name, kDiaryUIdentity, kDiaryMeta, kDeletedDiary, kUploaded];
    if (![db executeUpdate: sqlInsert,
          d.title,
          d.DCreateTime,
          [NSNumber numberWithInteger:d.type1],
          [d.filePaths1 JSONData],
          [d.urls1 JSONData],
          [NSNumber numberWithInteger:d.type2],
          [d.filePaths2 JSONData],
          [d.urls2 JSONData],
          [NSNumber numberWithInteger:[UserInfo sharedUserInfo].identity],
          [d.meta JSONData]])
        return NO;
    d.UIdentity = [UserInfo sharedUserInfo].identity;
    if (_sampleDiary)
        [_diaries removeAllObjects];
    _sampleDiary = NO;
    [_diaries addObject:d];
    if ( [[UserInfo sharedUserInfo] addCorns:0.1]) {
        PostNotification(Noti_AddCorns, nil);

    }
    [self performSelectorInBackground:@selector(uploadDiary:) withObject:d];
    return YES;
}

- (BOOL)deleteDiary:(Diary *)d
{
    //delete sqlite data
    NSDate *date = d.DCreateTime;
    if (date == nil) return  NO;
    NSString *tableName = [self sqliteTableName];
    NSString *sqlDel = [NSString stringWithFormat:@"UPDATE %@ SET %@ = 1 , %@ = 0 WHERE %@ = ?", tableName, kDeletedDiary, kUploaded, kDateName];
    if (![db executeUpdate:sqlDel, date]) return NO;
    //delete file
    for (NSString *filePath in d.filePaths1) {
        if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath])
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    for (NSString *filePath in d.filePaths2) {
        if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath])
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    //update model
    
    for (int i = 0; i<[_diaries count]; i++)
    {
        Diary *diaryInfo = [_diaries objectAtIndex:i];
        NSDate *theDate = diaryInfo.DCreateTime;
        if ([date isEqualToDate:theDate])
        {
            [_deletedDiaries addObject:[_diaries objectAtIndex:i]];
            [_diaries removeObjectAtIndex:i];
            break;
        }
    }
    if ([_diaries count] <=1) {
        [self reloadData];
    } else {
        [self performSelectorInBackground:@selector(uploadDiary:) withObject:d];
    }
    return YES;
}

- (BOOL)updateDiary:(Diary *)d needUpload:(BOOL)toUp
{
    NSString *tableName = [self sqliteTableName];
    NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ?, %@ = ? WHERE %@ = ?", tableName, kTitleName, kTypeName, kFilePathName, kUrlName, kType2Name, kFilePath2Name, kUrl2Name, kDiaryUIdentity, kDiaryMeta, kDeletedDiary, kUploaded, kDateName];
    NSInteger uploaded = toUp ? 2 : 1;
    if (![db executeUpdate: sqlUpdate,
          d.title,
          [NSNumber numberWithInteger:d.type1],
          [d.filePaths1 JSONData],
          [d.urls1 JSONData],
          [NSNumber numberWithInteger:d.type2],
          [d.filePaths2 JSONData],
          [d.urls2 JSONData],
          [NSNumber numberWithInteger:d.UIdentity],
          [d.meta JSONData],
          [NSNumber numberWithBool:d.deleted],
          [NSNumber numberWithInteger:uploaded],
          d.DCreateTime])
        return NO;
    return YES;
}


//关键字搜索
- (NSUInteger)indexForDiarySearchedWithKeyword:(NSString *)keyword
{
    NSUInteger i;
    NSArray *diaries = _diaries;
    for (i = 0; i<[diaries count]; i++)
    {
        Diary * diaryInfo = [diaries objectAtIndex:i];
        NSString * title = diaryInfo.title;
        NSRange range = [title rangeOfString:keyword];
        if (range.location != NSNotFound)
            return i;
    }
    for (i = 0; i<[diaries count]; i++)
    {
        Diary * diaryInfo = [diaries objectAtIndex:i];
        if (diaryInfo.type1 == DiaryContentTypeText)
        {
            NSString *filePath = [diaryInfo.filePaths1 objectAtIndex:0];
            NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            NSRange range = [content rangeOfString:keyword];
            if (range.location != NSNotFound)
                return i;
        }
    }
    return NSUIntegerMax;
}

- (NSString*)sqliteTableName
{
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    NSString *tableName;
    if (userInfo.UID > -1) tableName = [NSString stringWithFormat:@"diaryTableForBaby%d_Version2", userInfo.BID];
    else tableName = @"diaryTableForUnloginedUser_Version2";
    return tableName;
}

- (NSInteger)indexForDiaryInDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:unit fromDate:date];
    NSArray *diaries = _diaries;
    for (NSUInteger i = 0; i < [diaries count]; i++)
    {
        Diary *diaryInfo = [diaries objectAtIndex:i];
        NSDate *diaryDate = diaryInfo.DCreateTime;
        NSDateComponents *dComp = [calendar components:unit fromDate:diaryDate];
        if ([comp year] == [dComp year] && [comp month] == [dComp month] && [comp day] == [dComp day])
        {
            return i;
        }
        else if ([diaryDate compare:date] == NSOrderedAscending) return -1;
    }
    return -1;
}

- (NSArray *)diariesInDay:(NSDate *)date
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:unit fromDate:date];
    NSArray *diaries = _diaries;
    for (NSUInteger i = 0; i < [diaries count]; i++)
    {
        Diary *diaryInfo = [diaries objectAtIndex:i];
        NSDate *diaryDate = diaryInfo.DCreateTime;
        NSDateComponents *dComp = [calendar components:unit fromDate:diaryDate];
        if ([comp year] == [dComp year] && [comp month] == [dComp month] && [comp day] == [dComp day])
        {
            [array addObject:diaryInfo];
        }
        else if ([diaryDate compare:date] == NSOrderedAscending) break;
    }
    return array;
}


- (Diary *)diaryAtDate:(NSDate *)createDate
{
    for (Diary * d in _diaries) {
        NSDate *date = d.DCreateTime;
        NSTimeInterval dt = [date timeIntervalSinceDate:createDate];
        if (dt >= 0 && dt < 1)
            return d;
    }
    return nil;
}

#pragma mark - download diaries

- (void)updateDiaryFromServer
{
    _updateCnt = 0;
    _downloadedCnt = 0;
    UserInfo * userInfo = [UserInfo sharedUserInfo];
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_UpdateDiary;
    [request setTimeOutSeconds:20];
    [request setDelegate:self];
    [request setParam:[NSString stringWithFormat:@"%d", userInfo.BID] forKey:@"BID"];
    [request setParam:[NSString stringWithFormat:@"%d", [self diaryUpdateID]] forKey:@"UTID_local"];
    request.resEncoding = PumanRequestRes_JsonEncoding;
    request.tag = 0;
    [request postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.result == PumanRequest_Succeeded && [afRequest.resObj isKindOfClass:[NSArray class]])
    {
        _toDownloadDiaries = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in afRequest.resObj)
        {
            NSString *createDateStr = [dic objectForKey:@"DCreateTime"];
            NSDate *createDate = [DateFormatter datetimeFromString:createDateStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
            if (![self diaryExistAtDate:createDate])
            {
                if ([[dic valueForKey:@"TID"] integerValue] == -1) {
                    for (NSInteger i=0; i<[_toDownloadDiaries count]; i++)
                    {
                        Diary * d = [_toDownloadDiaries objectAtIndex:i];
                        if ([d.DCreateTime isEqualToDate:createDate])
                        {
                            [_toDownloadDiaries removeObjectAtIndex:i];
                            break;
                        }
                    }
                    [self deleteDiaryByServer:createDate];
                } else {
                    Diary * d = [[Diary alloc] init];
                    d.title = [dic valueForKey:@"title"];
                    d.type1Str = [dic valueForKey:@"type1"];
                    d.type2Str = [dic valueForKey:@"type2"];
                    d.UIdentity = [[dic valueForKey:@"Identity"] isEqualToString:kUserIdentity_Father] ? Father : Mother;
                    d.DCreateTime = createDate;
                    [d setUrls1WithMainUrl:[dic valueForKey:@"url1"] andSubcnt:[[dic valueForKey:@"subCnt1"] integerValue]];
                    [d setUrls2WithMainUrl:[dic valueForKey:@"url2"] andSubcnt:[[dic valueForKey:@"subCnt2"] integerValue]];
                    d.UTID = [[dic valueForKey:@"UTID"] integerValue];
                    id info = [[dic valueForKey:@"Meta"] objectFromJSONString];
                    if (info) {
                        d.meta = [[NSMutableDictionary alloc] initWithDictionary:info];
                    }
                    [_toDownloadDiaries addObject:d];
                }
            }
        }
        _updateCnt = [_toDownloadDiaries count];
        if (_updateCnt > 0)
        {
            PostNotification(Noti_UpdateDiaryStateRefreshed, nil);
            _downloadedDiaries = [[NSMutableArray alloc] init];
            [self performSelectorInBackground:@selector(downloadUpdateDiary) withObject:nil];
        }
        
    }
}

- (void)downloadUpdateDiary
{
    Reachability *rechability = [Reachability reachabilityForInternetConnection];
    for (Diary *d in _toDownloadDiaries)
    {
        while (![rechability isReachable]) sleep(10);
        [d download];
        [self addDownloadedDiary:d];
        [self setDiaryUpdateID:d.UTID];
        _downloadedCnt ++;
        PostNotification(Noti_UpdateDiaryStateRefreshed, nil);
    }
    _downloadedCnt = _updateCnt;
}

- (BOOL)diaryExistAtDate:(NSDate *)createDate
{
    for (Diary * d in _diaries) {
        NSDate *date = d.DCreateTime;
        NSTimeInterval dt = [date timeIntervalSinceDate:createDate];
        if (dt >= 0 && dt < 1)
            return YES;
    }
    for (Diary * d in _deletedDiaries) {
        NSDate *date = d.DCreateTime;
        NSTimeInterval dt = [date timeIntervalSinceDate:createDate];
        if (dt >= 0 && dt < 1)
            return YES;
    }
    for (Diary * d in _downloadedDiaries) {
        NSDate *date = d.DCreateTime;
        NSTimeInterval dt = [date timeIntervalSinceDate:createDate];
        if (dt >= 0 && dt < 1)
            return YES;
    }
    return NO;
}

- (NSInteger)diaryUpdateID
{
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUserDefault_DiaryUpdateID, [UserInfo sharedUserInfo].BID];
    return [[MyUserDefaults valueForKey:key] integerValue];
}

- (void)setDiaryUpdateID:(NSInteger)ID
{
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUserDefault_DiaryUpdateID, [UserInfo sharedUserInfo].BID];
    [MyUserDefaults setValue:[NSNumber numberWithInteger:ID] forKey:key];
    [MyUserDefaults synchronize];
}

//新增日记，更新数据库
- (BOOL)addDownloadedDiary:(Diary *)d
{
    NSString *tableName = [self sqliteTableName];
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 1)", tableName, kTitleName, kDateName, kTypeName, kFilePathName, kUrlName, kType2Name, kFilePath2Name, kUrl2Name, kDiaryUIdentity, kDiaryMeta, kDeletedDiary, kUploaded];
    if (![db executeUpdate: sqlInsert,
          d.title,
          d.DCreateTime,
          [NSNumber numberWithInteger:d.type1],
          [d.filePaths1 JSONData],
          [d.urls1 JSONData],
          [NSNumber numberWithInteger:d.type2],
          [d.filePaths2 JSONData],
          [d.urls2 JSONData],
          [NSNumber numberWithInteger:d.UIdentity],
          [d.meta JSONData]])
        return NO;
    [_downloadedDiaries addObject:d];
    return YES;
}

- (BOOL)deleteDiaryByServer:(NSDate *)createDate
{
    if (createDate == nil) return NO;
    NSString *tableName = [self sqliteTableName];
    NSString *sqlDel = [NSString stringWithFormat:@"UPDATE %@ SET %@ = 1 WHERE %@ = ?", tableName, kDeletedDiary, kDateName];
    if (![db executeUpdate:sqlDel, createDate]) return NO;
    return YES;
}

- (void)resetUpdateDiaryCnt
{
    _updateCnt = _updateCnt - _downloadedCnt;
    _downloadedCnt = 0;
}


#pragma mark - upload diaries

- (BOOL)uploadDiary:(Diary *)d
{
    BOOL suc = NO;
    if (d.uploaded == 2) {
        suc = [d uploadDiaryInfo];
    } else {
        suc = [d uploadDiary];
    }
    if (suc) {
        if (d.taskId > 0 && d.taskId != 6) {
            TaskModel *taskModel = [TaskModel sharedTaskModel];
            if (!taskModel.updating)
                [taskModel updateTasks];
        }
        NSString *tableName = [self sqliteTableName];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = 1 WHERE %@ = ?", tableName, kUploaded, kDateName];
        [db executeUpdate:sql, d.DCreateTime];
        return YES;
    }
    return NO;
}

- (void)uploadDiaries
{
    _uploading = YES;
    while (1) {
        NSMutableArray * failed = [[NSMutableArray alloc] init];
        for (Diary * d in _toUploadDiaries) {
            if (![self uploadDiary:d]) {
                [failed addObject:d];
            }
        }
        if (failed.count == 0) break;
        _toUploadDiaries = failed;
        sleep(60);
    }
    _uploading = NO;
}

- (NSArray *)diaryInfoRelateArray
{
    int num = 3;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    UserIdentity findIdentity;
    switch ([UserInfo sharedUserInfo].identity) {
        case Mother:
            findIdentity = Father;
            break;
        default:
            findIdentity = Mother;
            break;
    }
    for (Diary *d in _downloadedDiaries) {
        if(d.UIdentity == findIdentity) {
            [array addObject:d];
            num --  ;
            if (num <= 0) {
                break;
            }
        }
    }
    if (num > 0)
        for (Diary * d in _diaries) {
            if(d.UIdentity == findIdentity) {
                [array addObject:d];
                num --  ;
                if (num <= 0) {
                    break;
                }
            }
        }
    return array;
}


- (void)dealloc
{
    [db close];
}

@end
