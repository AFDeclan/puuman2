//
//  AFDataStore.h
//  AFNetwork
//
//  Created by Declan on 13-12-14.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "AFDataDownloader.h"

@protocol AFDataStoreDelegate <NSObject>
- (void)dataDownloadEnded:(NSData *)data forUrl:(NSString *)url;
@end

@interface AFDataStore : NSObject <AFDataDownloaderDelegate>
{
    NSMutableDictionary *_delegates;
    NSMutableDictionary *_pending;
    FMDatabase *_db;
}

//设置下载队列的最大长度，默认为10
@property (nonatomic, assign) int maxConnection;
//设置下载的超时时间，默认为5秒
@property (nonatomic, assign) int timeOutSeconds;

//单例
+ (AFDataStore *)sharedStore;
//根据url获取数据
- (NSData *)getDataFromUrl:(NSString *)url delegate:(id<AFDataStoreDelegate>)del;
//获取本地文件
- (NSData *)getDataFromPath:(NSString *)path needCache:(BOOL)cache;
//根据url移除委托
- (void)removeDelegate:(id)delegate forURL:(NSString*)key;

- (void)didReceiveMemoryWarning;

@end
