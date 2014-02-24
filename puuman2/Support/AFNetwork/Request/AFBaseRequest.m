//
//  AFBaseRequest.m
//  Test
//
//  Created by Declan on 13-12-5.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import "AFBaseRequest.h"
#import <JSONKit.h>
#import <XMLReader.h>
#import <ASIHTTPRequest.h>

static NSMutableArray * instanceList;

@implementation AFBaseRequest

@synthesize params = _params;
@synthesize httpRequest = _httpRequest;
@synthesize delegate = _delegate;
@synthesize resObj = _resObj;
@synthesize result = _result;
@synthesize timeOutSeconds = _timeOutSeconds;
@synthesize userInfo = _userInfo;

+ (void)endRequestFor:(id)aDelegate
{
    for (AFBaseRequest *req in instanceList)
    {
        if (req.delegate == aDelegate)
            [req endRequest];
    }
}

- (id)init
{
    if (self = [super init])
    {
        _params = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setParam:(id)param forKey:(id)key
{
    [self setParam:param forKey:key usingFormat:AFDataFormat_None];
}

- (void)setIntegerParam:(NSInteger)param forKey:(id)key
{
    [self setParam:[NSString stringWithFormat:@"%d", param] forKey:key];
}

- (void)setFloatParam:(CGFloat)param forKey:(id)key
{
    [self setParam:[NSString stringWithFormat:@"%f", param] forKey:key];
}

- (void)setParam:(id)param forKey:(id)key usingFormat:(AFDataFormat)format
{
    NSString *paramStr;
    switch (format) {
        case AFDataFormat_Json:
        {
            paramStr = [param JSONString];
            break;
        }
        case AFDataFormat_Xml:
        {
            if (param == nil) return;
            NSData *xmlData = [NSPropertyListSerialization dataFromPropertyList:param
                                                                         format:NSPropertyListXMLFormat_v1_0
                                                               errorDescription:NULL];
            paramStr = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            break;
        }
        default:
            paramStr = param;
            break;
    }
    [_params setValue:paramStr forKey:key];
}

- (void)getAsynchronous
{
    [self buildGetRequest];
    [self retainSelf];
    _httpRequest = _request;
    [_request startAsynchronous];
}
- (void)postAsynchronous
{
    [self buildPostRequest];
    [self retainSelf];
    _httpRequest = _formRequest;
    [_formRequest startAsynchronous];
}
- (id)getSynchronous
{
    [self buildGetRequest];
    _request.delegate = nil;
    _httpRequest = _request;
    [_request startSynchronous];
    id del = _delegate;
    _delegate = nil;
    if ([_request error])
        [self requestFailed:_request];
    else [self requestFinished:_request];
    _delegate = del;
    return nil;
}
- (id)postSynchronous
{
    [self buildPostRequest];
    _formRequest.delegate = nil;
    _httpRequest = _formRequest;
    [_formRequest startSynchronous];
    id del = _delegate;
    _delegate = nil;
    if ([_formRequest error])
        [self requestFailed:_formRequest];
    else
        [self requestFinished:_formRequest];
    _delegate = del;
    return nil;
}

#pragma mark - support methods

- (void)buildGetRequest
{
    NSMutableString *tempUrl = [[NSMutableString alloc] initWithString:_urlStr];
    [tempUrl appendString:@"?"];
    NSArray *keys = [_params allKeys];
    NSInteger cnt = [keys count];
    for (NSInteger i=0; i<cnt; i++)
    {
        id key, value;
        key = [keys objectAtIndex:i];
        value = [_params objectForKey:key];
        [tempUrl appendFormat:@"%@=%@", key, value];
    }
    _request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:tempUrl]];
    _request.delegate = self;
    _request.timeOutSeconds = _timeOutSeconds;
}

- (void)buildPostRequest
{
    _formRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:_urlStr]];
    _formRequest.delegate = self;
    for (id key in _params)
    {
        [_formRequest setPostValue:[_params valueForKey:key] forKey:key];
    }
    _formRequest.timeOutSeconds = _timeOutSeconds;
}

- (void)endRequest
{
    [_formRequest cancel];
    [_request cancel];
    _delegate = nil;
    [self releaseSelf];
}

#pragma mark - ASIHTTPRequest Delegate

- (void)requestFailed:(ASIHTTPRequest *)request
{
    _resObj = nil;
    _result = [self resultWithRequest:request];
    if ([_delegate respondsToSelector:@selector(requestEnded:)])
    {
        [_delegate requestEnded:self];
    }
    [self releaseSelf];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    _resObj = [self resObjFromRequest:request];
    _result = [self resultWithRequest:request];
    if ([_delegate respondsToSelector:@selector(requestEnded:)])
    {
        [_delegate requestEnded:self];
    }
    [self releaseSelf];
}

#pragma mark - overidden by subclass

- (NSInteger)resultWithRequest:(ASIHTTPRequest *)request
{
    NSAssert(NO, @"Subclasses need to overwrite this method: errorWithRequest:");
    return 0;
}

- (id)resObjFromRequest:(ASIHTTPRequest *)request
{
    NSAssert(NO, @"Subclasses need to overwrite this method: resObjFromRequest:");
    return nil;
}

#pragma mark - retain and release self

- (void)retainSelf
{
    if (!instanceList) instanceList = [[NSMutableArray alloc] init];
    [instanceList addObject:self];
}

- (void)releaseSelf
{
    [instanceList removeObject:self];
}

@end
