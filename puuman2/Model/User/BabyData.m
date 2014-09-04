//
//  BabyData.m
//  puuman model
//
//  Created by 陈晔 on 13-10-18.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "BabyData.h"
#import "UserInfo.h"
#import "DateFormatter.h"
#import "NSDate+Compute.h"
#import "ErrorLog.h"

static BabyData * instance;

@implementation BabyData

@synthesize heightArray = _heightArray;
@synthesize weightArray = _weightArray;
@synthesize highestHeightRecord = _highestHeightRecord;
@synthesize lowestHeightRecord = _lowestHeightRecord;
@synthesize highestWeightRecord = _highestWeightRecord;
@synthesize lowestWeightRecord = _lowestWeightRecord;

+ (BabyData *)sharedBabyData
{
    if (!instance)
        instance = [[BabyData alloc] init];
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _vaccineUpdating = NO;
        _data = [[NSMutableArray alloc] init];
        _vaccine = [[NSMutableArray alloc] init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *dbPath = [documents stringByAppendingPathComponent:kBabyDataDbName];
        _db= [FMDatabase databaseWithPath:dbPath] ;
        [self openDb];
        [self reloadData];
    }
    return self;
}

- (BOOL)openDb
{
    if (![_db open]) {
        [ErrorLog errorLog:@"Could not open db." fromFile:@"BabyData.m" error:nil];
        NSLog(@"Could not open db.");
        return NO;
    }
    return YES;
}

- (BOOL)closeDb
{
    return [_db close];
}

#pragma mark - operations

- (void)reloadData
{
    [self reloadBabyData];
    [self reloadVaccineData];
    [self updateData];
}

- (void)updateData
{
    [self updateBabyData];
    [self updateVaccineData];
}

- (void)reloadBabyData
{
    NSString *tableName = [self babydataTableName];
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY, %@ REAL, %@ REAL, %@ REAL, %@ INTEGER)", tableName, kBabyData_Date, kBabyData_Height, kBabyData_Weight, kBabyData_Uploaded];
    if (![_db executeUpdate:sqlCreateTable])
    {
        [ErrorLog errorLog:@"Create BabyData table failed!." fromFile:@"BabyData.m" error:nil];
        NSLog(@"Create BabyData table failed!");
    }
    NSString *sqlSelect = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ ASC", tableName, kBabyData_Date];
    FMResultSet *rs = [_db executeQuery: sqlSelect];
    [_data removeAllObjects];
    NSMutableArray *heightArr = [[NSMutableArray alloc] init];
    NSMutableArray *weightArr = [[NSMutableArray alloc] init];
    float maxHeight = 0, minHeight = MAXFLOAT, maxWeight = 0, minWeight = MAXFLOAT;
    while ([rs next])
    {
        NSInteger ID = [rs intForColumnIndex:0];
        NSDate *date = [rs dateForColumn:kBabyData_Date];
        if (date == nil)
        {
            
            [ErrorLog errorLog:@"Create BabyData table failed!." fromFile:@"BabyData.m" error:nil];
            NSLog(@"BabyData : Error date record!");
            continue;
        }
        CGFloat height = [rs doubleForColumn:kBabyData_Height];
        CGFloat weight = [rs doubleForColumn:kBabyData_Weight];
        BOOL uploaded = [rs boolForColumn:kBabyData_Uploaded];
        NSMutableDictionary *record = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInteger:ID], kBabyData_ID,
                                       [NSNumber numberWithDouble:height], kBabyData_Height,
                                       [NSNumber numberWithDouble:weight], kBabyData_Weight,
                                       [NSNumber numberWithBool:uploaded], kBabyData_Uploaded,
                                       date, kBabyData_Date,
                                       nil];
        [_data addObject:record];
        if (height != 0)
        {
            [heightArr addObject:record];
            if (height > maxHeight) maxHeight = height;
            if (height < minHeight) minHeight = height;
        }
        if (weight != 0)
        {
            [weightArr addObject:record];
            if (weight > maxWeight) maxWeight = weight;
            if (weight < minWeight) minWeight = weight;
        }
    }
    _heightArray = heightArr;
    _weightArray = weightArr;
    _highestHeightRecord = maxHeight;
    _lowestHeightRecord = minHeight;
    _highestWeightRecord = maxWeight;
    _lowestWeightRecord = minWeight;
    [rs close];
    
}

- (void)reloadVaccineData
{
    NSString *tableName = [self vaccineTableName];
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER, %@ TEXT, %@ TEXT, %@ REAL, %@ TEXT, %@ INTEGER, %@ INTEGER)", tableName, kVaccine_ID, kVaccine_Name, KVaccine_Info, kVaccine_DoneTime, kVaccine_SuitMonth, kVaccine_Order, kVaccine_Uploaded];
    if (![_db executeUpdate:sqlCreateTable])
    {
        
        [ErrorLog errorLog:@"Create VaccineData table failed!" fromFile:@"BabyData.m" error:nil];
        NSLog(@"Create VaccineData table failed!");
    }
    NSString *sqlSelect = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ ASC", tableName, kVaccine_Order];
    FMResultSet *rs = [_db executeQuery: sqlSelect];
    [_vaccine removeAllObjects];
    _vaccineCntNotInjured = 0;
    NSArray *age = [[NSDate date] ageFromDate:[[UserInfo sharedUserInfo] babyInfo].Birthday];
    NSInteger month = 0;
    if ([age count] == 3)
    {
        month = [[age objectAtIndex:0] integerValue] * 12 + [[age objectAtIndex:1] integerValue];
    }
    
    while ([rs next])
    {
        NSInteger ID = [rs intForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        if (!name) name = @"";
        NSString *info = [rs stringForColumnIndex:2];
        if (!info) info = @"";
        NSDate *date = [rs dateForColumnIndex:3];
        NSString * suitMonth = [rs stringForColumnIndex:4];
        BOOL uploaded = [rs boolForColumn:kVaccine_Uploaded];
        NSMutableDictionary *vaccineRecord = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ID], kVaccine_ID,
                                              name, kVaccine_Name,
                                              info, KVaccine_Info,
                                              [NSNumber numberWithBool:uploaded], kVaccine_Uploaded,
                                              suitMonth, kVaccine_SuitMonth,
                                              date, kVaccine_DoneTime, nil];
        [_vaccine addObject:vaccineRecord];
        NSArray *suitMonths = [suitMonth componentsSeparatedByString:@"~"];
        NSInteger startMonth = 0, endMonth = 0;
        if ([suitMonths count] == 2)
        {
            startMonth = [[suitMonths objectAtIndex:0] integerValue];
            endMonth = [[suitMonths objectAtIndex:1] integerValue];
            if (month >= startMonth && month < endMonth) {
                _vaccineCntNotInjured ++;
            }
        }
    }
    
}

- (float)selectHeightWithDate:(NSDate *)date
{
    float height = 0;
    for (NSDictionary * record in _data)
    {
        NSDate *recordDate = [record valueForKey:kBabyData_Date];
        if ([recordDate isSameDayWithDate:date])
        {
            height = [[record valueForKey:kBabyData_Height] floatValue];
            break;
        }
    }
    return height;
    
}
- (float)selectWeightWithDate:(NSDate *)date
{
    float weight = 0;
    for (NSDictionary * record in _data)
    {
        NSDate *recordDate = [record valueForKey:kBabyData_Date];
        if ([recordDate isSameDayWithDate:date])
        {
            weight = [[record valueForKey:kBabyData_Weight] floatValue];
            break;
        }
    }
    return weight;
}

- (void)insertRecordAtDate:(NSDate *)date height:(CGFloat)h weight:(CGFloat)w
{
    [self insertRecordAtDate:date height:h weight:w fromServer:NO];
    [self updateBabyData];
}


- (void)insertRecordAtDate:(NSDate *)date height:(CGFloat)h weight:(CGFloat)w fromServer:(BOOL)fromSer
{
    NSInteger ID = -1;
    //检查是否已有同一天的记录
    for (NSDictionary * record in _data)
    {
        NSDate *recordDate = [record valueForKey:kBabyData_Date];
        if ([recordDate isSameDayWithDate:date])
        {
            ID = [[record valueForKey:kBabyData_ID] integerValue];
            break;
        }
    }
    NSString *tableName = [self babydataTableName];
    if (ID >= 0)
    {
        NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ?, %@ = ?, %@ = ?, %@ = ? WHERE id = ?", tableName, kBabyData_Date, kBabyData_Height, kBabyData_Weight, kBabyData_Uploaded];
        if (![_db executeUpdate: sqlUpdate, date, [NSNumber numberWithDouble:h], [NSNumber numberWithDouble:w], [NSNumber numberWithBool:fromSer], [NSNumber numberWithInteger:ID]])
        {
            [ErrorLog errorLog: @"BabyData : Insert new record failed! (modify)" fromFile:@"BabyData.m" error:nil];
            NSLog(@"BabyData : Insert new record failed! (modify)");
            return;
        }
    }
    else
    {
        NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@) VALUES (?, ?, ?, ?)", tableName, kBabyData_Date, kBabyData_Height, kBabyData_Weight, kBabyData_Uploaded];
        if (![_db executeUpdate: sqlInsert, date, [NSNumber numberWithDouble:h], [NSNumber numberWithDouble:w], [NSNumber numberWithBool:fromSer]])
        {
            
            [ErrorLog errorLog:  @"BabyData : Insert new record failed!" fromFile:@"BabyData.m" error:nil];
            NSLog(@"BabyData : Insert new record failed!");
            return;
        }
    }
    
    [self reloadBabyData];
}

- (void)updateVaccineAtIndex:(NSInteger)index withDoneTime:(NSDate *)date
{
    if (index >= [_vaccine count]) return;
    NSMutableDictionary *vaccine = [_vaccine objectAtIndex:index];
    [vaccine setValue:@NO forKey:kVaccine_Uploaded];
    [vaccine setValue:date forKey:kVaccine_DoneTime];
    NSInteger ID = [[vaccine valueForKey:kVaccine_ID] integerValue];
    [self updateVaccineWithVID:ID doneTime:date fromServer:NO];
    [self updateVaccineData];
}

- (void)updateVaccineWithVID:(NSInteger)VID doneTime:(NSDate *)date fromServer:(BOOL)fromSer
{
    NSString *tableName = [self vaccineTableName];
    NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ?, %@ = ? WHERE %@ = ?", tableName, kVaccine_DoneTime, kVaccine_Uploaded, kVaccine_ID];
    if (![_db executeUpdate:sqlUpdate, date, [NSNumber numberWithBool:fromSer], [NSNumber numberWithInteger:VID]])
    {
        [ErrorLog errorLog: @"BabyData vaccine update Failed:" fromFile:@"BabyData.m" error:nil];
        NSLog(@"BabyData vaccine update Failed: %@ %@ %d", sqlUpdate, date, VID);
    }
    
}

#pragma mark - data read

- (NSUInteger)recordCount
{
    return [_data count];
}

- (NSDictionary *)recordAtIndex:(NSUInteger)index
{
    if (index >= [_data count]) return nil;
    return [_data objectAtIndex:index];
}

- (NSUInteger)vaccineCount
{
    return [_vaccine count];
}

- (NSDictionary *)vaccineAtIndex:(NSUInteger)index
{
    if (index >= [_vaccine count]) return nil;
    return [_vaccine objectAtIndex:index];
}

#pragma mark - other

- (NSString *)babydataTableName
{
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    NSString *tableName;
    if (userInfo.UID > -1) tableName = [NSString stringWithFormat:@"BabyDataTableForBaby%d_0_0_0", userInfo.BID];
    else tableName = @"BabyDataTableForUnloginedUser_0_0_0";
    return tableName;
}

- (NSString *)vaccineTableName
{
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    NSString *tableName;
    if (userInfo.UID > -1) tableName = [NSString stringWithFormat:@"VaccineTableForBaby%d_0_0_0", userInfo.BID];
    else tableName = @"VaccineTableForUnloginedUser_0_0_0";
    return tableName;
}

#pragma mark - update Data

//Update VaccineData
- (void)updateVaccineData
{
    if (_vaccineUpdating) return;
    _vaccineUpdating = YES;
    NSMutableArray *toUpload = [[NSMutableArray alloc] init];
    NSMutableArray *toUpload2 = [[NSMutableArray alloc] init];
    NSInteger vaccineUpdatedID = 0;
    for (NSMutableDictionary *vaccine in _vaccine)
    {
        NSInteger ID = [[vaccine valueForKey:kVaccine_ID] integerValue];
        if (ID > vaccineUpdatedID) vaccineUpdatedID = ID;
        BOOL uploaded = [[vaccine valueForKey:kVaccine_Uploaded] boolValue];
        if (!uploaded)
        {
            [toUpload addObject:vaccine];
            NSMutableDictionary *vac2 = [[NSMutableDictionary alloc] initWithDictionary:vaccine];
            NSDate *date = [vaccine valueForKey:kVaccine_DoneTime];
            [vac2 setValue:[DateFormatter timestampStrFromDatetime:date] forKey:kVaccine_DoneTime];
            [toUpload2 addObject:vac2];
        }
    }
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_UpdateVaccine;
    request.userInfo = [NSDictionary dictionaryWithObject:toUpload forKey:@"uploadList"];
    request.tag = 1;
    [request setParam:[NSNumber numberWithInteger:[UserInfo sharedUserInfo].BID] forKey:@"BID"];
    [request setParam:toUpload2 forKey:@"Logs" usingFormat:AFDataFormat_Json];
    [request setParam:[self vaccineLogUpdatedID] forKey:@"LID_local"];
    [request setParam:[NSNumber numberWithInteger:vaccineUpdatedID] forKey:@"VID_local"];
    request.delegate = self;
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
}

- (void)addNewVaccines:(NSArray *)newVaccines
{
    NSString *tableName = [self vaccineTableName];
    for (NSArray *vaccine in newVaccines)
    {
        NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@, %@, %@) VALUES (?, ?, ?, ?, ?, ?)", tableName, kVaccine_ID, kVaccine_Name, KVaccine_Info, kVaccine_SuitMonth, kVaccine_Order, kVaccine_Uploaded];
        NSNumber *ID = [vaccine valueForKey:@"VID"];
        NSString *name = [vaccine valueForKey:@"VName"];
        NSString *info = [vaccine valueForKey:@"VInfo"];
        NSString *suitMonth = [vaccine valueForKey:@"Month"];
        NSNumber *order = [vaccine valueForKey:@"Order"];
        if (![_db executeUpdate:sqlInsert, ID, name, info, suitMonth, order, @YES])
        {
            
            [ErrorLog errorLog: @"BabyData vaccine insert Failed:" fromFile:@"BabyData.m" error:nil];
            NSLog(@"BabyData vaccine insert Failed: %@ %@ %@ %@ %@ %@", sqlInsert, ID, name, info, suitMonth, order);
        }
    }
    
    if ([newVaccines count] > 0) [self reloadVaccineData];
}

- (NSString *)vaccineLogUpdatedID
{
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUDK_VaccineLogUpdatedLID, [UserInfo sharedUserInfo].BID];
    NSString *ID = [MyUserDefaults valueForKey:key];
    if (!ID) ID = @"0";
    return ID;
}

- (void)setVaccineLogUpdatedID:(NSString *)ID
{
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUDK_VaccineLogUpdatedLID, [UserInfo sharedUserInfo].BID];
    [MyUserDefaults setObject:ID forKey:key];
    [MyUserDefaults synchronize];
}

- (void)vaccineUploaded:(NSArray *)uploaded
{
    for (NSMutableDictionary *vaccine in uploaded)
        [vaccine setValue:@YES forKey:kVaccine_Uploaded];
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?", [self vaccineTableName], kVaccine_Uploaded, kVaccine_ID];
    for (NSDictionary *vac in uploaded)
        if (![_db executeUpdate:sql, @YES, [vac valueForKey:kVaccine_ID]])
        {
            
            [ErrorLog errorLog: @"BabyData vaccineTable updated failed:" fromFile:@"BabyData.m" error:nil];
            NSLog(@"BabyData vaccineTable updated failed:%@", sql);
        }
    
}
//Update BabyData
- (void)updateBabyData
{
    NSMutableArray *toUpload = [[NSMutableArray alloc] init];
    NSMutableArray *toUpload2 = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *record in _data)
    {
        BOOL uploaded = [[record valueForKey:kBabyData_Uploaded] boolValue];
        if (!uploaded)
        {
            [toUpload addObject:record];
            NSMutableDictionary *record2 = [[NSMutableDictionary alloc] initWithDictionary:record];
            NSDate * date = [record valueForKey:kBabyData_Date];
            [record2 setValue:[DateFormatter timestampStrFromDatetime:date] forKey:kBabyData_Date];
            [toUpload2 addObject:record2];
        }
    }
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_UpdateBabyData;
    request.userInfo = [NSDictionary dictionaryWithObject:toUpload forKey:@"uploadList"];
    request.tag = 2;
    [request setParam:[NSNumber numberWithInteger:[UserInfo sharedUserInfo].BID] forKey:@"BID"];
    [request setParam:toUpload2 forKey:@"Records" usingFormat:AFDataFormat_Json];
    [request setParam:[self babyDataUpdatedID] forKey:@"BDID_local"];
    request.delegate = self;
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
    
}

- (NSString *)babyDataUpdatedID
{
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUDK_BabyDataUpdatedLID, [UserInfo sharedUserInfo].BID];
    NSString *ID = [MyUserDefaults valueForKey:key];
    if (!ID) ID = @"0";
    return ID;
}

- (void)setBabyDataUpdatedID:(NSString *)ID
{
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUDK_BabyDataUpdatedLID, [UserInfo sharedUserInfo].BID];
    [MyUserDefaults setObject:ID forKey:key];
    [MyUserDefaults synchronize];
}

- (void)babydataUploaded:(NSArray *)uploaded
{
    for (NSMutableDictionary *rec in uploaded)
        [rec setValue:@YES forKey:kBabyData_Uploaded];
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE id = ?", [self babydataTableName], kBabyData_Uploaded];
    for (NSDictionary *rec in uploaded)
        if (![_db executeUpdate:sql, @YES, [rec valueForKey:kBabyData_ID]])
        {
            
            [ErrorLog errorLog:@"BabyData babyDataTable updated failed" fromFile:@"BabyData.m" error:nil];
            
            NSLog(@"BabyData babyDataTable updated failed:%@", sql);
        }
}

#pragma mark - request result

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    NSDictionary *resDic = afRequest.resObj;
    if (!resDic) return;
    switch (afRequest.tag) {
        case 1:
        {
            NSArray *newVaccines = [resDic valueForKey:@"Vaccine"];
            if (![newVaccines isKindOfClass:[NSNull class]])
            {
                [self addNewVaccines:newVaccines];
                PostNotification(Noti_VaccineUpdated, nil);
            }
            NSArray *logs = [resDic valueForKey:@"Logs"];
            if (![logs isKindOfClass:[NSNull class]])
            {
                for (NSDictionary *log in logs)
                {
                    NSInteger VID = [[log valueForKey:@"VID"] integerValue];
                    NSString *timeStr = [log valueForKey:@"DoneTime"];
                    NSDate *doneTime = nil;
                    if (![timeStr hasPrefix:@"0000"])
                        doneTime = [DateFormatter datetimeFromString:timeStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
                    [self updateVaccineWithVID:VID doneTime:doneTime fromServer:YES];
                    for (NSMutableDictionary *vaccine in _vaccine)
                    {
                        if ([[vaccine valueForKey:kVaccine_ID] integerValue] == VID)
                        {
                            [vaccine setValue:doneTime forKey:kVaccine_DoneTime];
                            break;
                        }
                    }
                }
                PostNotification(Noti_VaccineUpdated, nil);
            }
            [self vaccineUploaded:[afRequest.userInfo valueForKey:@"uploadList"]];
            NSString *updatedLID = [resDic valueForKey:@"LID"];
            if (![updatedLID isKindOfClass:[NSNull class]]) [self setVaccineLogUpdatedID:updatedLID];
            _vaccineUpdating = NO;
            break;
        }
        case 2:
        {
            [self babydataUploaded:[afRequest.userInfo valueForKey:@"uploadList"]];
            NSArray *records = [resDic valueForKey:@"Records"];
            if (![records isKindOfClass:[NSNull class]])
            {
                for (NSDictionary *record in records)
                {
                    CGFloat h = [[record valueForKey:@"Height"] doubleValue];
                    CGFloat w = [[record valueForKey:@"Weight"] doubleValue];
                    NSString *dateStr = [record valueForKey:@"Date"];
                    NSDate *date = [DateFormatter datetimeFromString:dateStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
                    if (!date) date = [NSDate date];
                    [self insertRecordAtDate:date height:h weight:w fromServer:YES];
                }
                PostNotification(Noti_BabyDataUpdated, nil);
            }
            NSString *updatedBDID = [resDic valueForKey:@"BDID"];
            if (![updatedBDID isKindOfClass:[NSNull class]]) [self setBabyDataUpdatedID:updatedBDID];
            break;
        }
        default:
            
            break;
    }
}

- (void)dealloc
{
    [self closeDb];
}

@end
