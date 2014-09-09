//
//  ActionManager.m
//  puuman model
//
//  Created by Declan on 14-3-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ActionManager.h"
#import "UniverseConstant.h"
#import "Action.h"

#define ActionDBName    @"GroupActionDb.sqlite"
#define ActionTableName @"GroupActionTable"

@implementation ActionManager

+ (ActionManager *)sharedInstance
{
    static ActionManager * instance;
    if (!instance) {
        instance = [[ActionManager alloc] init];
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
    NSString *dbPath = [documents stringByAppendingPathComponent:ActionDBName];
    _db= [FMDatabase databaseWithPath:dbPath] ;
    if (![_db open]) {
        [ErrorLog errorLog:@"Could not open db." fromFile:@"ActionManager.m" error:_db.lastError];
    }
    NSString *tableName = ActionTableName;
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (AID INTEGER PRIMARY KEY, GID INTEGER, AType INTEGER, ASourceUID INTEGER, ATargetBID INTEGER, AMeta TEXT, ACreateTime REAL)", tableName];
    if (![_db executeUpdate:sqlCreateTable])
    {
        [ErrorLog errorLog:@"Create table failed!" fromFile:@"ActionManager.m" error:_db.lastError];
    }

}

- (void)clear
{
    NSString *getLatest = [NSString stringWithFormat:@"SELECT ACreateTime FROM %@ ORDER BY ACreateTime DESC LIMIT 1", ActionTableName];
    FMResultSet *rs = [_db executeQuery:getLatest];
    if (![rs next]) return;
    NSDate * latest = [rs dateForColumnIndex:0];
    NSDate * weekago = [latest dateByAddingTimeInterval:-7*24*60*60];
    NSString *clear = [NSString stringWithFormat:@"DELETE FROM %@ WHERE ACreateTime < ?", ActionTableName];
    if (![_db executeUpdate:clear, weekago]) {
        [ErrorLog errorLog:@"Clear table failed!" fromFile:@"ActionManager.m" error:_db.lastError];
    }
}

- (NSArray *)actionsFromResultSet:(FMResultSet *)rs
{
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    while ([rs next]) {
        Action * act = [[Action alloc] init];
        act.AID = [rs intForColumn:@"AID"];
        act.GID = [rs intForColumn:@"GID"];
        act.AType = [rs intForColumn:@"AType"];
        act.ASourceUID = [rs intForColumn:@"ASourceUID"];
        act.ATargetBID = [rs intForColumn:@"ATargetBID"];
        act.AMeta = [rs stringForColumn:@"AMeta"];
        act.ACreateTime = [rs dateForColumn:@"ACreateTime"];
        [actions addObject:act];
    }
    return actions;
}

- (NSArray *)actionsForGroup:(NSInteger)GID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE GID = %ld ORDER BY ACreateTime ASC", ActionTableName, (long)GID];
    FMResultSet *rs = [_db executeQuery:sql];
    return [self actionsFromResultSet:rs];
}

- (NSArray *)msgsForGroup:(NSInteger)GID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE GID = %ld AND AType = %d ORDER BY ACreateTime ASC", ActionTableName, (long)GID, (int)ActionType_Msg];
    FMResultSet *rs = [_db executeQuery:sql];
    return [self actionsFromResultSet:rs];
}

- (Action *)latestActionForGroup:(NSInteger)GID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE GID = %ld AND AType <> %d ORDER BY ACreateTime DESC LIMIT 1", ActionTableName, (long)GID, (int)ActionType_Msg];
    FMResultSet *rs = [_db executeQuery:sql];
    NSArray *actions = [self actionsFromResultSet:rs];
    if (actions.count > 0) return [actions firstObject];
    else return nil;
}

- (void)addAction:(Action *)act forGroup:(NSInteger)GID
{
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (AID, GID, AType, ASourceUID, ATargetBID, AMeta, ACreateTime) VALUES(%ld, %ld, %d, %ld, %ld, ?, ?)", ActionTableName, (long)act.AID, (long)act.GID, act.AType, (long)act.ASourceUID, (long)act.ATargetBID];
    if (![_db executeUpdate:insert, act.AMeta, act.ACreateTime]) {
        [ErrorLog errorLog:@"Insert action failed!" fromFile:@"ActionManager.m" error:_db.lastError];
    }
}


@end
