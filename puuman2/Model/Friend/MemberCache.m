//
//  MemberCache.m
//  puuman2
//
//  Created by Declan on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MemberCache.h"
#import "UniverseConstant.h"
#import "Member.h"
#import "Friend.h"
#import <JSONKit.h>

#define MemberDBName    @"MemberCacheDb.sqlite"
#define MemberTableName @"MemberCacheTable"

@implementation MemberCache

+ (MemberCache *)sharedInstance
{
    static MemberCache * instance;
    if (!instance) {
        instance = [[MemberCache alloc] init];
    }
    return instance;
}

- (id)init
{
    if (self = [super init])
    {
        [self createTable];
        [self clear];
    }
    return self;
}

- (void)createTable
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *dbPath = [documents stringByAppendingPathComponent:MemberDBName];
    _db= [FMDatabase databaseWithPath:dbPath] ;
    if (![_db open]) {
        [ErrorLog errorLog:@"Could not open db." fromFile:@"MemberCache.m" error:_db.lastError];
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (BID INTEGER PRIMARY KEY, UIDs TEXT, Data TEXT, LastActive REAL)", MemberTableName];
    if (![_db executeUpdate:sqlCreateTable])
    {
        [ErrorLog errorLog:@"Create table failed!" fromFile:@"MemberCache.m" error:_db.lastError];
    }
}

- (void)clear
{
    NSDate * weekago = [[NSDate date] dateByAddingTimeInterval:-7*24*60*60];
    NSString *clear = [NSString stringWithFormat:@"DELETE FROM %@ WHERE LastActive < ?", MemberTableName];
    if (![_db executeUpdate:clear, weekago]) {
        [ErrorLog errorLog:@"Clear table failed!" fromFile:@"MemberCache.m" error:_db.lastError];
    }
}

- (void)cacheMember:(Member *)mem
{
    NSString *uids = [mem.UIDs JSONString];
    NSMutableDictionary *baseData = [NSMutableDictionary dictionaryWithDictionary:mem.data];
    [baseData setValue:nil forKey:@"DetailInfo"];
    NSString *data = [baseData JSONString];
    NSString *replace = [NSString stringWithFormat:@"REPLACE INTO %@ (BID, UIDs, Data, LastActive) VALUES (?, ?, ?, ?)", MemberTableName];
    if (![_db executeUpdate:replace, mem.BID, uids, data, [NSDate date]]) {
        [ErrorLog errorLog:@"Cache member failed!" fromFile:@"MemberCache.m" error:_db.lastError];
    }
}

- (Member *)getMemberFromDb:(FMResultSet *)rs
{
    if ([rs next]) {
        NSString *dataStr = [rs stringForColumnIndex:0];
        NSError *parseError = nil;
        NSDictionary * data = [dataStr objectFromJSONStringWithParseOptions:JKParseOptionNone error:&parseError];
        if (parseError) {
            [ErrorLog errorLog:@"Parse error!" fromFile:@"MemberCache.m" error:_db.lastError];
            return nil;
        } else {
            Member *mem = [[Member alloc] init];
            [mem setData:data];
            return mem;
        }
    } else {
        return nil;
    }
}

- (Member *)getMemberWithBID:(NSInteger)bid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT Data FROM %@ WHERE BID = ?", MemberTableName];
    FMResultSet * rs = [_db executeQuery:sql, [NSNumber numberWithInteger:bid]];
    Member * mem = [self getMemberFromDb:rs];
    if (mem) return mem;
    [self downloadMemberWithUID:0 orBID:bid];
    return nil;
}

- (Member *)getMemberWithUID:(NSInteger)uid
{
    NSString *sql = @"SELECT Data FROM ? WHERE UID LIKE %?%";
    FMResultSet * rs = [_db executeQuery:sql, MemberTableName, [NSNumber numberWithInteger:uid]];
    Member * mem = [self getMemberFromDb:rs];
    if (mem) return mem;
    [self downloadMemberWithUID:uid orBID:0];
    return nil;
}

- (void)downloadMemberWithUID:(NSInteger)uid orBID:(NSInteger)bid
{
    PumanRequest *req = [[PumanRequest alloc] init];
    req.urlStr = kUrl_GetMember;
    req.resEncoding = PumanRequestRes_JsonEncoding;
    req.delegate = self;
    [req setIntegerParam:uid forKey:@"UID"];
    [req setIntegerParam:bid forKey:@"BID"];
    [req postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.result == PumanRequest_Succeeded) {
        id obj = afRequest.resObj;
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            Member * mem = [[Member alloc] init];
            [mem setData:dic];
            [[Friend sharedInstance] informDelegates:@selector(memberDownloaded:) withObject:mem];
            return;
        }
    }
    [[Friend sharedInstance] informDelegates:@selector(memberDownloadFailed) withObject:nil];
}


@end
