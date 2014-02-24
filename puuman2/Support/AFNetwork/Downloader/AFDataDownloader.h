//
//  AFDataDownloader.h
//  AFNetwork
//
//  Created by Declan on 13-12-11.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ASIHTTPRequest.h>

@class AFDataDownloader;

@protocol AFDataDownloaderDelegate <NSObject>

- (void)dataDownloadEnded:(AFDataDownloader *)downloader;

@end

@interface AFDataDownloader : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic, assign) id<AFDataDownloaderDelegate> delegate;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain, readonly) ASIHTTPRequest *request;
@property (nonatomic, retain, readonly) NSData *downloadedData;
@property (nonatomic, assign) NSTimeInterval timeOutSeconds;
@property (nonatomic, assign, readonly) BOOL downloading;

+ (NSData *)downloadSyncronousFromUrl:(NSString *)url;
- (id)initWithDelegate:(id<AFDataDownloaderDelegate>)del;
- (void)downloadAsyncronousFromUrl:(NSString *)url;
- (void)downloadAsyncronous;

@end
