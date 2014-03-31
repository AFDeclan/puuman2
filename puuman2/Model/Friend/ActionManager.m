//
//  ActionManager.m
//  puuman2
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
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (AID INTEGER PRIMARY KEY, GID INTEGER, AType INTEGER, ASouceUID INTEGER, ATargetBID INTEGER, AMeta TEXT, ACreateTime REAL)", tableName];
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

- (NSArray *)actionsForGroup:(NSInteger)GID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY ACreateTime DESC", ActionTableName];
    FMResultSet *rs = [_db executeQuery:sql];
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

- (void)addAction:(Action *)act forGroup:(NSInteger)GID
{
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (AID, GID, AType, ASourceUID, ATargetBID, AMeta, ACreateTime) VALUES(?, ?, ?, ?, ?, ?, ?)", ActionTableName];
    if (![_db executeUpdate:insert, act.AID, act.GID, act.AType, act.ASourceUID, act.ATargetBID, act.AMeta, act.ACreateTime]) {
        [ErrorLog errorLog:@"Insert action failed!" fromFile:@"ActionManager.m" error:_db.lastError];
    }
}


@end
