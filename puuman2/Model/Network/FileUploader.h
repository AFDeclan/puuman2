//
//  FileUploader.h
//  puman
//
//  Created by 陈晔 on 13-5-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ASIHTTPRequest.h>

@class FileUploader;

@protocol UploaderDelegate <NSObject>

@optional
- (void)uploadResult:(BOOL)suc;
- (void)uploadResult:(BOOL)suc uploader:(FileUploader *)uploader;
- (void)downloadResult:(NSData*)data;
- (void)downloadResult:(NSData *)data downLoader:(FileUploader *)downLoader;

@end

@interface FileUploader : NSObject <ASIHTTPRequestDelegate,ASIProgressDelegate>
{
    ASIHTTPRequest *_request;
}

@property (assign, nonatomic) NSObject<UploaderDelegate> *delegate;
@property (assign, nonatomic) NSInteger tag;
@property (retain, nonatomic, readonly) NSString * targetUrl;

//sync
- (BOOL)uploadFile:(NSString *)filePath toDir:(NSString *)dir fileRename:(NSString *)name;
- (BOOL)uploadDataSync:(NSData *)data toDir:(NSString *)dir fileName:(NSString *)name;

//async
- (void)uploadData:(NSData *)data toDir:(NSString *)dir fileName:(NSString *)name;

- (void)downloadDataFromDir:(NSString *)dir fileName:(NSString *)name;

- (void)downloadDataFromUrl:(NSString *)url;

- (NSData *)downloadDataSynchoronusFromUrl:(NSString *)url;

- (void)stop;

@end
