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
#import "TaskUploader.h"
#import "DiaryFileManager.h"

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
        diaryInfoArray = [[NSMutableArray alloc] init];
        downloadedDiaryInfo = [[NSMutableArray alloc] init];
        NSMutableArray *allDiaryInfo = [[NSMutableArray alloc] init];
        NSMutableArray *deletedDiaryInfo = [[NSMutableArray alloc] init];
        [diaryInfoArray addObject:allDiaryInfo];
        [diaryInfoArray addObject:deletedDiaryInfo];
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
- (NSArray *)diaryInfoRelateArraywithFilter:(NSUInteger) filter
{
    int num = 3;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *findIdentity;
    switch ([UserInfo sharedUserInfo].identity) {
        case Mother:
            findIdentity = kUserIdentity_Father;
            break;
        default:
            findIdentity = kUserIdentity_Mother;
            break;
    }
    for (NSDictionary *dic in downloadedDiaryInfo) {
        NSString *fromIdentity = [dic valueForKey:kDiaryUIdentity];
        if([fromIdentity isEqualToString:findIdentity]) {
            [array addObject:dic];
            num --  ;
            if (num <= 0) {
                break;
            }
        }
    }
    if (num > 0)
        for (NSDictionary *dic in [diaryInfoArray objectAtIndex:filter]) {
            NSString *fromIdentity = [dic valueForKey:kDiaryUIdentity];
            if([fromIdentity isEqualToString:findIdentity]) {
                [array addObject:dic];
                num --  ;
                if (num <= 0) {
                    break;
                }
            }
      }
    return array;
}
- (void)reloadData
{

    NSString *tableName = [self sqliteTableName];
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY, %@ TEXT, %@ REAL, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INT)", tableName, kTitleName, kDateName, kTypeName, kFilePathName, kType2Name, kFilePath2Name, kDiaryUIdentity, kDeletedDiary];
    if (![db executeUpdate:sqlCreateTable])
    {
         [ErrorLog errorLog:@"Create table failed!" fromFile:@"DiaryModel.m" error:nil];
        NSLog(@"Create table failed!");
    }
    for (int i=0; i<=1; i++)
        [[diaryInfoArray objectAtIndex:i] removeAllObjects];
    NSString *sqlSelect = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ DESC", tableName, kDateName];
    FMResultSet *rs = [db executeQuery: sqlSelect];
    while ([rs next])
    {
        NSString *title = [rs stringForColumn:kTitleName];
        if (title == nil) title = @"";
        NSDate *date = [rs dateForColumn:kDateName];
        if (date == nil) date = [NSDate date];
        NSString *type = [rs stringForColumn:kTypeName];
        if (type == nil) type = vType_Text;
        NSString *filePath = [rs stringForColumn:kFilePathName];
        if (filePath == nil) filePath = @"";
        else
        {
            filePath = [DiaryFileManager fixedFilePath:filePath];
        }
        NSString *type2 = [rs stringForColumn:kType2Name];
        if (type2 == nil) type2 = @"";
        NSString *filePath2 = [rs stringForColumn:kFilePath2Name];
        if (filePath2 == nil) filePath2 = @"";
        else
        {
            filePath2 = [DiaryFileManager fixedFilePath:filePath2];
        }
        NSString *identity = [rs stringForColumn:kDiaryUIdentity];
        if (identity == nil) identity = @"father";
        NSDictionary *diaryInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   title, kTitleName,
                                   date, kDateName,
                                   type, kTypeName,
                                   filePath, kFilePathName,
                                   type2, kType2Name,
                                   filePath2, kFilePath2Name,
                                   identity, kDiaryUIdentity,
                                   nil];
        BOOL deleted = [rs boolForColumn:kDeletedDiary];
        if (deleted)
        {
            [[diaryInfoArray objectAtIndex:DIARY_FILTER_DELETED] addObject:diaryInfo];
            NSString *filePath = [diaryInfo valueForKey:kFilePathName];
            if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath])
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            filePath = [diaryInfo valueForKey:kFilePath2Name];
            if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath]) [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        else
        {
            [[diaryInfoArray objectAtIndex:DIARY_FILTER_ALL] addObject:diaryInfo];
        }
    }
    [rs close];
    
    _sampleDiary = NO;
    if ([self diaryNumFiltered:DIARY_FILTER_ALL]) return;
    
    _sampleDiary = YES;
    
    //sample diary
    NSString *filePath;
    NSString *filePath2;
    NSDate *date = [MyUserDefaults valueForKey:kUDK_FirstEnterDate];
    NSDictionary *diaryInfo;
    if (!date) {
        date = [NSDate date];
        [MyUserDefaults setValue:date forKey:kUDK_FirstEnterDate];
    }
    
    //sample diary - text
    
    NSString *fileDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *typeDir = vType_Text;
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

    diaryInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"展开扑满日记，积累爱的奇迹。", kTitleName,
                 date, kDateName,
                 vType_Text, kTypeName,
                 filePath, kFilePathName,
                 @YES, kSampleDiary,
                 nil];
    [[diaryInfoArray objectAtIndex:DIARY_FILTER_ALL] addObject:diaryInfo];
    
    //sample diary - auphoto
    filePath = [[NSBundle mainBundle] pathForResource:@"sampleDiary_auphoto" ofType:@"jpg" ];
    filePath2 = [[NSBundle mainBundle] pathForResource:@"sampleDiary_auphoto" ofType:@"mp3" ];
    diaryInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"", kTitleName,
                 date, kDateName,
                 vType_Photo, kTypeName,
                 filePath, kFilePathName,
                 vType_Audio, kType2Name,
                 filePath2, kFilePath2Name,
                 @YES, kSampleDiary,
                 nil];
    [[diaryInfoArray objectAtIndex:DIARY_FILTER_ALL] addObject:diaryInfo];

    [downloadedDiaryInfo removeAllObjects];
}


//filter类别日记的总数
- (NSUInteger) diaryNumFiltered:(NSUInteger)filter
{
    if (filter >= [diaryInfoArray count]) return 0;
    NSArray *array = [diaryInfoArray objectAtIndex:filter];
    return [array count];
}

- (NSUInteger) diaryNotSampleNum
{
    if (!_sampleDiary) return [self diaryNumFiltered:DIARY_FILTER_ALL];
    else
    {
        return 0;
    }
}

//filter类别中编号index的日记信息
- (NSDictionary*) diaryInfoAtIndex:(NSUInteger)index filtered:(NSUInteger)filter
{
    if (filter >= [diaryInfoArray count]) return nil;
    NSInteger x = index;
    if (x >= [[diaryInfoArray objectAtIndex:filter] count])
    {
        return nil;
    }
    
    return [[diaryInfoArray objectAtIndex:filter] objectAtIndex:index];
}

//新增日记，更新数据库以及model的数组
- (BOOL)addNewDiary:(NSDictionary *)diaryInfo
{
    NSString *tableName = [self sqliteTableName];
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@) VALUES (?, ?, ?, ?, ?, ?, ?, 0)", tableName, kTitleName, kDateName, kTypeName, kFilePathName, kType2Name, kFilePath2Name, kDiaryUIdentity, kDeletedDiary];
    if (![db executeUpdate: sqlInsert,
          [diaryInfo objectForKey:kTitleName],
          [diaryInfo objectForKey:kDateName],
          [diaryInfo objectForKey:kTypeName],
          [diaryInfo objectForKey:kFilePathName],
          [diaryInfo objectForKey:kType2Name],
          [diaryInfo objectForKey:kFilePath2Name],
          [UserInfo sharedUserInfo].identityStr])
        return NO;
    NSMutableDictionary *mdiaryInfo = [[NSMutableDictionary alloc]initWithDictionary:diaryInfo];
    [mdiaryInfo setValue:[UserInfo sharedUserInfo].identityStr forKey:kDiaryUIdentity];
    if (_sampleDiary)
        [[diaryInfoArray objectAtIndex:0] removeAllObjects];
    _sampleDiary = NO;
    [[diaryInfoArray objectAtIndex:0] insertObject:mdiaryInfo atIndex:0];
    PostNotification(Noti_ReloadDiaryTable, nil);
    return YES;
}

- (BOOL)deleteDiary:(NSDictionary *)diaryInfo
{
    
    [[TaskUploader uploader] addNewTaskToDeleteDiary:diaryInfo];
    //delete sqlite data
    NSDate *date = [diaryInfo valueForKey:kDateName];
    if (date == nil) return  NO;
    NSString *tableName = [self sqliteTableName];
    NSString *sqlDel = [NSString stringWithFormat:@"UPDATE %@ SET %@ = 1 WHERE %@ = ?", tableName, kDeletedDiary, kDateName];
    if (![db executeUpdate:sqlDel, date]) return NO;
    //delete file
    NSString *filePath = [diaryInfo valueForKey:kFilePathName];
    if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    filePath = [diaryInfo valueForKey:kFilePath2Name];
    if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath]) [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    //update model
    
    NSMutableArray *diaries;
    
    diaries = [diaryInfoArray objectAtIndex:DIARY_FILTER_ALL];
    for (int i = 0; i<[diaries count]; i++)
    {
        NSDictionary *diaryInfo = [diaries objectAtIndex:i];
        NSDate *theDate = [diaryInfo valueForKey:kDateName];
        if ([date isEqualToDate:theDate])
        {
            [[diaryInfoArray objectAtIndex:DIARY_FILTER_DELETED] addObject:[diaries objectAtIndex:i]];
            [diaries removeObjectAtIndex:i];
            break;
        }
    }
    if ([diaries count] <=1) {
        [self reloadData];
    }
    
    return YES;
}

//获取某日期的日记  未测试！
- (NSUInteger)indexForDiaryNearDate:(NSDate *)date filtered:(NSUInteger)filter
{
    NSArray *diaries = [diaryInfoArray objectAtIndex:filter];
    for (NSDictionary *diaryInfo in diaries)
    {
        NSDate *curDiaryDate = [diaryInfo objectForKey:kDateName];
        if ([curDiaryDate isEqualToDate:date])
        {
            return  [diaries indexOfObject:diaryInfo];
        }
    }
    return [diaries count] - 1;
}


//关键字搜索
- (NSUInteger)indexForDiarySearchedWithKeyword:(NSString *)keyword filtered:(NSUInteger) filter
{
    NSUInteger i;
    NSArray *diaries = [diaryInfoArray objectAtIndex:filter];
    for (i = 0; i<[diaries count]; i++)
    {
        NSDictionary *diaryInfo = [diaries objectAtIndex:i];
        NSString *title = [diaryInfo valueForKey:kTitleName];
        NSRange range = [title rangeOfString:keyword];
        if (range.location != NSNotFound)
            return i;
    }
    for (i = 0; i<[diaries count]; i++)
    {
        NSDictionary *diaryInfo = [diaries objectAtIndex:i];
        if ([[diaryInfo valueForKey:kTypeName] isEqualToString:vType_Text])
        {
            NSString *filePath = [diaryInfo valueForKey:kFilePathName];
            NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            NSRange range = [content rangeOfString:keyword];
            if (range.location != NSNotFound)
                return i;
        }
    }
    for (i = 0; i<[diaries count]; i++)
    {
        NSDictionary *diaryInfo = [diaries objectAtIndex:i];
        if ([[diaryInfo valueForKey:kType2Name] isEqualToString:vType_Text])
        {
            NSString *filePath = [diaryInfo valueForKey:kFilePath2Name];
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
    if (userInfo.UID > -1) tableName = [NSString stringWithFormat:@"diaryTableForBaby%d_Version0", userInfo.BID];
    else tableName = @"diaryTableForUnloginedUser_Version0";
    
    return tableName;
}

- (NSInteger)indexForDiaryInDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:unit fromDate:date];
    NSArray *diaries = [diaryInfoArray objectAtIndex:DIARY_FILTER_ALL];
    for (NSUInteger i = 0; i < [diaries count]; i++)
    {
        NSDictionary *diaryInfo = [diaries objectAtIndex:i];
        NSDate *diaryDate = [diaryInfo valueForKey:kDateName];
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
    NSArray *diaries = [diaryInfoArray objectAtIndex:DIARY_FILTER_ALL];
    for (NSUInteger i = 0; i < [diaries count]; i++)
    {
        NSDictionary *diaryInfo = [diaries objectAtIndex:i];
        NSDate *diaryDate = [diaryInfo valueForKey:kDateName];
        NSDateComponents *dComp = [calendar components:unit fromDate:diaryDate];
        if ([comp year] == [dComp year] && [comp month] == [dComp month] && [comp day] == [dComp day])
        {
            [array addObject:diaryInfo];
        }
        else if ([diaryDate compare:date] == NSOrderedAscending) break;
    }
    return array;
}

- (UIImageView *)thumbnailForCalendar:(NSDate *)date
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 96)];
    [view setContentMode:UIViewContentModeScaleAspectFill];
    float height = 0;
    BOOL hasAudio = NO, hasText = NO, hasImage = NO, hasmemorialday = NO, hasVaccine = NO;
    NSArray *diaries = [self diariesInDay:date];
    if ([diaries count] == 0) return nil;
    UIImage *thumbImage;
    for (NSDictionary *diaryInfo in diaries)
    {
        NSString *type = [diaryInfo valueForKey:kTypeName];
        NSString *type2 = [diaryInfo valueForKey:kType2Name];
        if ([type isEqualToString:vType_Text])
        {
            hasText = YES;
        }
        if ([type isEqualToString:vType_Audio] || [type2 isEqualToString:vType_Audio])
        {
            hasAudio = YES;
        }
        if (!hasImage)
        {
            if ([type isEqualToString:vType_Photo])
            {
                NSString *photoPathsString = [diaryInfo objectForKey:kFilePathName];
                NSArray *photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
                for (NSString *photoPath in photoPaths)
                {
                    UIImage *photo = [DiaryFileManager imageForPath:photoPath];
                    if (photo != nil) {
                        hasImage = YES;
                        thumbImage = photo;
                        break;
                    }
                }
            }
            else if ([type2 isEqualToString:vType_Photo])
            {
                NSString *photoPath = [diaryInfo objectForKey:kFilePath2Name];
                UIImage *photo = [[UIImage alloc] initWithContentsOfFile:photoPath];
                if (photo != nil) {
                    hasImage = YES;
                    thumbImage = photo;
                }
            }
            else if ([type isEqualToString:vType_Video])
            {
                thumbImage = [DiaryFileManager imageForVideo:[diaryInfo valueForKey:kFilePathName]];
                if (thumbImage != nil) hasImage = YES;
            }
        }
    }
    
    if (hasImage)
    {
        [view setImage:thumbImage];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd"];
        NSString *dayStr = [formatter stringFromDate:date];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(56, height, 24, 24)];
        [label setBackgroundColor:[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]];
        [label setText:dayStr];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:PMColor2];
        [view addSubview:label];
        height += 24;
    }
    if (hasmemorialday)
    {
        UIImageView *memorialdayTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_date_cal_dairy.png"]];
        [memorialdayTag setFrame:CGRectMake(56, 0, 24, 24)];
        [view addSubview:memorialdayTag];
        if (!hasImage) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd"];
            NSString *dayStr = [formatter stringFromDate:date];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(56, height, 24, 24)];
            [label setBackgroundColor:[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]];
            [label setText:dayStr];
          
            [label setTextColor:PMColor2];
            [view addSubview:label];
            height += 24;
        }
        
    }
    if (hasAudio)
    {
        UIImageView *audioTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_audio_cal_diary.png"]];
        [audioTag setFrame:CGRectMake(56, height, 24, 24)];
        [view addSubview:audioTag];
        height += 24;
    }
    
    if (hasText)
    {
        UIImageView *textTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_text_cal_diary.png"]];
        [textTag setFrame:CGRectMake(56,height, 24, 24)];
        [view addSubview:textTag];
        height += 24;
    }
    
    if (hasVaccine)
    {
        UIImageView *VaccineTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_vaccinc_cal_diary.png"]];
        [VaccineTag setFrame:CGRectMake(56, height, 24, 24)];
        [view addSubview:VaccineTag];
       
    }
    return view;
}

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
    if (afRequest.resObj)
    {
        updateDiaryInfo = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in afRequest.resObj)
        {
            NSString *createDateStr = [dic objectForKey:@"DCreateTime"];
            NSDate *createDate = [DateFormatter datetimeFromString:createDateStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
            if (![self diaryExistAtDate:createDate])
            {
                if ([[dic valueForKey:@"TID"] integerValue] == -1)
                {
                    for (NSInteger i=0; i<[updateDiaryInfo count]; i++)
                    {
                        NSDictionary *info = [updateDiaryInfo objectAtIndex:i];
                        if ([[info valueForKey:@"DCreateTime"] isEqualToString:createDateStr])
                        {
                            [updateDiaryInfo removeObjectAtIndex:i];
                            break;
                        }
                    }
                    [self deleteDiaryByServer:createDate];
                }
                else
                    [updateDiaryInfo addObject:dic];
            }
        }
        _updateCnt = [updateDiaryInfo count];
        if (_updateCnt > 0)
        {
            PostNotification(Noti_UpdateDiaryStateRefreshed, nil);
            downloadedDiaryInfo = [[NSMutableArray alloc] init];
            [self performSelectorInBackground:@selector(downloadUpdateDiary) withObject:nil];
        }

    }
}

- (void)downloadUpdateDiary
{
    Reachability *rechability = [Reachability reachabilityWithHostname:@"http://puman.oss.aliyuncs.com"];
    FileUploader *downloader = [[FileUploader alloc] init];
    for (NSDictionary *dic in updateDiaryInfo)
    {
        NSMutableDictionary *diaryInfo = [[NSMutableDictionary alloc] init];

        [diaryInfo setValue:[dic valueForKey:@"title"] forKey:kTitleName];
        NSString *type1 = [dic valueForKey:@"type1"];
        [diaryInfo setValue:type1 forKey:kTypeName];
        NSString *type2 = [dic valueForKey:@"type2"];
        [diaryInfo setValue:type2 forKey:kType2Name];
        NSString *identity = [dic valueForKey:@"Identity"];
        [diaryInfo setValue:identity forKey:kDiaryUIdentity];
        NSDate *createDate = [DateFormatter datetimeFromString:[dic objectForKey:@"DCreateTime"] withFormat:@"yyyy-MM-dd HH:mm:ss"];
        if (createDate == nil)
            createDate = [NSDate date];
        [diaryInfo setValue:createDate forKey:kDateName];
        NSString *url1 = [dic valueForKey:@"url1"];
        NSInteger subCnt1 = [[dic valueForKey:@"subCnt1"] integerValue];
        NSString *filePath1 = @"";
        for (NSInteger i=0; i<subCnt1; i++)
        {
            NSString *url = [NSString stringWithFormat:@"%@/%d", url1, i];
            NSData *fileData;
            for (NSInteger j=0; j<3; j++) //尝试3次
            {
                while (![rechability isReachable]) sleep(10);
                fileData = [downloader downloadDataSynchoronusFromUrl:url];
                if (fileData) break;
            }
            if (fileData)
            {
                //save the file
                NSString *fileDir = [DiaryFileManager fileDirForDiaryType:type1];
                if (!fileDir) continue;
                NSString *fileName = [DateFormatter stringFromDatetime:createDate];
                NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
                if ([type1 isEqualToString:vType_Video])
                {
                    filePath = [filePath stringByAppendingPathExtension:@"MOV"];
                }
                //                    NSString *filePath2 = [filePath stringByAppendingString:@"_src2"];
                [fileData writeToFile:filePath atomically:YES];
                if (i==0) filePath1 = [filePath1 stringByAppendingString:filePath];
                else filePath1 = [filePath1 stringByAppendingFormat:@"#@#%@", filePath];
            }
        }
        [diaryInfo setValue:filePath1 forKey:kFilePathName];
        
        if (type2 && ![type2 isEqualToString:@""])
        {
            NSString *url2 = [dic valueForKey:@"url2"];
            NSInteger subCnt2 = [[dic valueForKey:@"subCnt2"] integerValue];
            NSString *filePath2 = @"";
            for (NSInteger i=0; i<subCnt2; i++)
            {
                NSString *url = [NSString stringWithFormat:@"%@/%d", url2, i];
                NSData *fileData;
                for (NSInteger j=0; j<3; j++) //尝试3次
                {
                    while (![rechability isReachable]) sleep(10);
                    fileData = [downloader downloadDataSynchoronusFromUrl:url];
                    if (fileData) break;
                }
                if (fileData)
                {
                    //save the file
                    NSString *fileDir = [DiaryFileManager fileDirForDiaryType:type1];
                    if (!fileDir) continue;
                    NSString *fileName = [DateFormatter stringFromDatetime:createDate];
                    NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
                    filePath = [filePath stringByAppendingString:@"_src2"];
                    [fileData writeToFile:filePath atomically:YES];
                    if (i==0) filePath2 = filePath;
                    else filePath2 = [filePath2 stringByAppendingFormat:@"#@#%@", filePath];
                }
            }
            [diaryInfo setValue:filePath2 forKey:kFilePath2Name];
        }
        
        [self addDownloadedDiary:diaryInfo];
        [self setDiaryUpdateID:[[dic valueForKey:@"UTID"] integerValue]];
        _downloadedCnt ++;
        PostNotification(Noti_UpdateDiaryStateRefreshed, nil);
    }
    _downloadedCnt = _updateCnt;
}

- (BOOL)diaryExistAtDate:(NSDate *)createDate
{
    for (NSDictionary *diaryInfo in [diaryInfoArray objectAtIndex:DIARY_FILTER_ALL])
    {
        NSDate *date = [diaryInfo valueForKey:kDateName];
        NSTimeInterval dt = [date timeIntervalSinceDate:createDate];
        if (dt >= 0 && dt < 1)
            return YES;
    }
    for (NSDictionary *diaryInfo in [diaryInfoArray objectAtIndex:DIARY_FILTER_DELETED])
    {
        NSDate *date = [diaryInfo valueForKey:kDateName];
        NSTimeInterval dt = [date timeIntervalSinceDate:createDate];
        if (dt >= 0 && dt < 1)
            return YES;
    }

    for (NSDictionary *diaryInfo in downloadedDiaryInfo)
    {
        NSDate *date = [diaryInfo valueForKey:kDateName];
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

//新增日记，更新数据库以及model的数组
- (BOOL)addDownloadedDiary:(NSDictionary *)diaryInfo
{
    NSString *tableName = [self sqliteTableName];
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@) VALUES (?, ?, ?, ?, ?, ?, ?, 0)", tableName, kTitleName, kDateName, kTypeName, kFilePathName, kType2Name, kFilePath2Name, kDiaryUIdentity, kDeletedDiary];
    if (![db executeUpdate: sqlInsert,
          [diaryInfo objectForKey:kTitleName],
          [diaryInfo objectForKey:kDateName],
          [diaryInfo objectForKey:kTypeName],
          [diaryInfo objectForKey:kFilePathName],
          [diaryInfo objectForKey:kType2Name],
          [diaryInfo objectForKey:kFilePath2Name],
          [diaryInfo objectForKey:kDiaryUIdentity]])
        return NO;
    
    [downloadedDiaryInfo addObject:diaryInfo];
    
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

- (void)dealloc
{
    [db close];
}

@end
