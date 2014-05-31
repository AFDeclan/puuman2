//
//  FileUploader.m
//  puman
//
//  Created by 陈晔 on 13-5-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//
#import <ASIHTTPRequest.h>
#import <ASIFormDataRequest.h>
#import "FileUploader.h"
#import "UniverseConstant.h"
#import "ErrorLog.h"
#import "PumanRequest.h"

static NSMutableArray *instanceList;


@interface FileUploader()

- (void) getUploadResult:(ASIHTTPRequest*)request;
- (void) getErr:(ASIHTTPRequest*)request;

@end

@implementation FileUploader

@synthesize targetUrl = _targetUrl;

- (void)retainSelf
{
    if (!instanceList)
        instanceList = [[NSMutableArray alloc] init];
    [instanceList addObject:self];
}

- (void)releaseSelf
{
    [instanceList removeObject:self];
}

- (void)uploadData:(NSData *)data toDir:(NSString *)dir fileName:(NSString *)name
{
    [self retainSelf];
    _targetUrl = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@/%@", dir, name];
    NSString *urlHostString = @"http://6.pumantest.sinaapp.com";
    NSString *urlSubpageString = @"/upload.php";
    NSString *urlString = [urlHostString stringByAppendingString:urlSubpageString];
    NSURL *myurl = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setData:data forKey:@"file"];
    [request setPostValue:[MobClick getConfigParams:umeng_onlineConfig_authKey] forKey:@"authCode"];
    [request setPostValue:dir forKey:@"dir"];
    [request setPostValue:name forKey:@"filename"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getUploadResult:)];
    [request setDidFailSelector:@selector(getErr:)];
    [request startAsynchronous];
}

- (BOOL)uploadDataSync:(NSData *)data toDir:(NSString *)dir fileName:(NSString *)name
{
    _targetUrl = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@/%@", dir, name];
    PumanRequest *request = [[PumanRequest alloc] init];
    [request setUrlStr:kUrl_UploadToOSS];
    //设置表单提交项
    [request setData:data forKey:@"file"];
    [request setParam:dir forKey:@"dir"];
    [request setParam:name forKey:@"filename"];
    [request postSynchronous];
    if (request.result != PumanRequest_Succeeded)
    {
        PostNotification(Noti_Imported, name);
        return NO;
    }else{
        PostNotification(Noti_Imported, name);
        return YES;
    }
}

- (BOOL)uploadFile:(NSString *)filePath toDir:(NSString *)dir fileRename:(NSString *)name;
{
    _targetUrl = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@/%@", dir, name];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    return [self uploadDataSync:fileData toDir:dir fileName:name];
}

- (void)downloadDataFromDir:(NSString *)dir fileName:(NSString *)name
{
    [self retainSelf];
    _targetUrl = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@/%@", dir, name];
    NSString *url = [NSString stringWithFormat:@"http://puman.oss.aliyuncs.com/%@/%@", dir, name];
    NSLog(@"download url:%@", url);
    [self downloadDataFromUrl:url];
}

- (void)downloadDataFromUrl:(NSString *)url
{
    [self retainSelf];
    _targetUrl = url;
    _request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [_request setRequestMethod:@"GET"];
    [_request setDelegate:self];
    [_request startAsynchronous];
}

- (NSData *)downloadDataSynchoronusFromUrl:(NSString *)url
{
    [self retainSelf];
    _targetUrl = url;
    _request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [_request setRequestMethod:@"GET"];
    [_request setDelegate:self];
    [_request startSynchronous];
    return [_request responseData];
}

- (void)stop
{
    [_request cancel];
}

- (void) getUploadResult:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    NSLog(@"upload succeeded, %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    if ([self.delegate respondsToSelector:@selector(uploadResult:)])
        [self.delegate uploadResult:YES];
    if ([self.delegate respondsToSelector:@selector(uploadResult:uploader:)])
        [self.delegate uploadResult:YES uploader:self];
    [self releaseSelf];
}

- (void) getErr:(ASIHTTPRequest *)request
{
    [ErrorLog requestFailedLog:request fromFile:@"FileUploader.m"];
    NSLog(@"upload err: %@", request.error.description);
    if ([self.delegate respondsToSelector:@selector(uploadResult:)])
        [self.delegate uploadResult:NO];
    if ([self.delegate respondsToSelector:@selector(uploadResult:uploader:)])
        [self.delegate uploadResult:NO uploader:self];
    [self releaseSelf];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(downloadResult:)])
        [self.delegate downloadResult:[request responseData]];
    if ([self.delegate respondsToSelector:@selector(downloadResult:downLoader:)])
        [self.delegate downloadResult:[request responseData] downLoader:self];
    [self releaseSelf];
   
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [ErrorLog requestFailedLog:request fromFile:@"FileUploader.m"];
    
    if ([self.delegate respondsToSelector:@selector(downloadResult:)])
        [self.delegate downloadResult:nil];
    if ([self.delegate respondsToSelector:@selector(downloadResult:downLoader:)])
        [self.delegate downloadResult:nil downLoader:self];
    [self releaseSelf];
}
@end
