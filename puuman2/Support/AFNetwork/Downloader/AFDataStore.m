//
//  AFDataStore.m
//  AFNetwork
//
//  Created by Declan on 13-12-14.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import "AFNetwork.h"

static AFDataStore *instance;
static NSMutableDictionary *cachedData;

const NSString *tableName = @"AFDataStoreTable";
const NSString *urlColumnName = @"Url";
const NSString *dataColumnName = @"Data";
const NSString *createDateColumnName = @"CreateDate";

@implementation AFDataStore

//单例
+ (AFDataStore *)sharedStore
{
    if (!instance) instance = [[AFDataStore alloc] init];
    return instance;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *dbPath = [documents stringByAppendingPathComponent:AFNetWorkDbName];
        _db= [FMDatabase databaseWithPath:dbPath] ;
        if (![_db open]) {
            NSLog(@"Could not open AFNetwork db.");
        }
        else
        {
            NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT PRIMARY KEY, %@ BLOB, %@ DATETIME)", tableName, urlColumnName, dataColumnName, createDateColumnName];
            if (![_db executeUpdate:sqlCreateTable])
            {
                NSLog(@"Create AFDataStore table failed!");
            }
        }
        _pending = [[NSMutableDictionary alloc] init];
        _delegates = [[NSMutableDictionary alloc] init];
        _maxConnection = 10;
        _timeOutSeconds = 5;
    }
    return self;
}
- (NSData *)getDataFromDb:(NSString *)urlOrPath
{
    NSString *sqlSelect = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = ? ORDER BY %@ DESC", dataColumnName, tableName, urlColumnName, createDateColumnName];
    FMResultSet *rs = [_db executeQuery:sqlSelect, urlOrPath];
    if ([rs next])
    {
        NSData *data = [rs dataForColumnIndex:0];
        return data;
    }
    return nil;
}
//根据url获取数据
- (NSData *)getDataFromUrl:(NSString *)url delegate:(id<AFDataStoreDelegate>)del
{
    NSData *fromDb = [self getDataFromDb:url];
    if (fromDb) return fromDb;
    AFDataDownloader *dl = [_pending objectForKey:url];
    if (dl == nil) {
        dl = [[AFDataDownloader alloc] initWithDelegate:self];
        dl.url = url;
        dl.timeOutSeconds = _timeOutSeconds;
        [_pending setObject:dl forKey:url];
    }
    NSMutableArray *arr = [_delegates objectForKey:url];
    if (arr) {
        //add delegate to queue
        [arr addObject:del];
    }else {
        //if queue not exist, create one
        [_delegates setObject:[NSMutableArray arrayWithObject:del] forKey:url];
    }
    //if not exceed the maximum length of queue, start donwload
    
    if ([_pending count] <= _maxConnection && !dl.downloading) {
        [dl downloadAsyncronous];
    }

    return nil;
}
- (NSData *)getDataFromPath:(NSString *)path needCache:(BOOL)cache
{
    NSData *fromCache = [cachedData valueForKey:path];
    if (fromCache) return fromCache;
    NSData *fromDb = [self getDataFromDb:path];
    if (fromDb) {
        if (cache) [self cacheData:fromDb forUrlOrPath:path];
        return fromDb;
    }
    NSData *fromFile = [NSData dataWithContentsOfFile:path];
    if (cache) [self cacheData:fromFile forUrlOrPath:path];
    return fromFile;
}
- (void)cacheData:(NSData *)data forUrlOrPath:(NSString *)urlOrPath
{
    if (!cachedData) cachedData = [[NSMutableDictionary alloc] init];
    [cachedData setValue:data forKey:urlOrPath];
}
- (void)removeDelegate:(id)delegate forURL:(NSString *)key{
    if (!key) return;
    NSMutableArray *arr = [_delegates objectForKey:key];
    if (arr) {
        [arr removeObject:delegate];
        if ([arr count] == 0) {
            [_delegates removeObjectForKey:key];
        }
    }
}
- (void)dataDownloadEnded:(AFDataDownloader *)downloader
{
    id data = downloader.downloadedData;
    if (data)
    {
        NSString *sql = [NSString stringWithFormat:@"REPLACE INTO %@ VALUES(?, ?, DATETIME('now'))", tableName];
        if (![_db executeUpdate:sql, downloader.url, data])
        {
            NSLog(@"Cache into Db failed!");
        }
    }
    NSMutableArray *arr = [_delegates objectForKey:downloader.url];
    if (arr) {
        for (id delegate in arr) {
            if ([delegate respondsToSelector:@selector(dataDownloadEnded:forUrl:)]) {
                [delegate dataDownloadEnded:data forUrl:downloader.url];
            }
        }
        [_delegates removeObjectForKey:downloader.url];
    }
    [_pending removeObjectForKey:downloader.url];
    [self getPending];
}
- (void)getPending
{
    NSArray *keys = [_pending allKeys];
    for (NSString *url in keys) {
        AFDataDownloader *dl = [_pending objectForKey:url];
        //get waiting queue
        NSMutableArray *arr = [_delegates objectForKey:url];
        if (arr == nil) {
            //if queue not exist, remove downloader
            [_pending removeObjectForKey:url];
        }else if ([arr count] == 0) {
            //if queue is empty, delete the downloader and release queue
            [_delegates removeObjectForKey:url];
            [_pending removeObjectForKey:url];
        }else {
            if (!dl.downloading) {
                //start download
                [dl downloadAsyncronous];
                break;
            }
        }
    }
}
- (void)cleanUp
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ <= (SELECT %@ FROM %@ order by %@ LIMIT 1 OFFSET 500);", tableName, createDateColumnName, createDateColumnName, tableName, createDateColumnName];
    if (![_db executeUpdate:sql])
    {
        NSLog(@"CleanUp Failed!");
    }
}

- (void)dealloc
{
    [self cleanUp];
    [_db close];
}

- (void)didReceiveMemoryWarning
{
    [cachedData removeAllObjects];
    cachedData = nil;
}
@end
