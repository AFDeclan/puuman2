//
//  AFDataDownloader.m
//  AFNetwork
//
//  Created by Declan on 13-12-11.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import "AFDataDownloader.h"

static NSMutableSet *instanceSet;

@implementation AFDataDownloader

@synthesize delegate = _delegate;
@synthesize url = _url;
@synthesize request = _request;
@synthesize downloadedData = _downloadedData;
@synthesize timeOutSeconds = _timeOutSeconds;
@synthesize downloading = _downloading;

+ (NSData *)downloadSyncronousFromUrl:(NSString *)url
{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request startSynchronous];
    return request.responseData;
}
- (id)initWithDelegate:(id<AFDataDownloaderDelegate>)del
{
    self = [super init];
    if (self)
    {
        _delegate = del;
        _downloading = NO;
    }
    return self;
}
- (id)init
{
    if (self = [super init])
    {
        _downloading = NO;
    }
    return self;
}

- (void)downloadAsyncronousFromUrl:(NSString *)url
{
    _url = url;
    [self downloadAsyncronous];
}

- (void)downloadAsyncronous
{
    _downloading = YES;
    [self retainSelf];
    _request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    _request.delegate = self;
    _request.timeOutSeconds = _timeOutSeconds;
    [_request startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    _downloading = NO;
    _downloadedData = nil;
    [_delegate dataDownloadEnded:self];
    [self releaseSelf];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    _downloading = NO;
    _downloadedData = request.responseData;
    [_delegate dataDownloadEnded:self];
    [self releaseSelf];
}


- (void)retainSelf
{
    if (!instanceSet) instanceSet = [[NSMutableSet alloc] init];
    [instanceSet addObject:self];
}

- (void)releaseSelf
{
    [instanceSet removeObject:self];
}

@end
