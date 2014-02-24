//
//  AFBaseRequest.h
//  Test
//
//  Created by Declan on 13-12-5.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ASIFormDataRequest.h>

typedef enum {
    AFHttpMethod_GET,
    AFHttpMethod_POST
} AFHttpMethod;

typedef enum {
    AFDataFormat_None,
    AFDataFormat_Json,
    AFDataFormat_Xml
} AFDataFormat;

@class AFBaseRequest;

@protocol AFRequestDelegate <NSObject>
@optional
- (void)requestEnded:(AFBaseRequest *)afRequest;
@end

@interface AFBaseRequest : NSObject <ASIHTTPRequestDelegate>
{
    ASIFormDataRequest *_formRequest;
    ASIHTTPRequest *_request;
}

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, retain) NSDictionary *userInfo;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) id resObj;
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, assign) id<AFRequestDelegate> delegate;
@property (nonatomic, assign) NSInteger timeOutSeconds;
@property (nonatomic, assign, readonly) AFHttpMethod httpMethod;
@property (nonatomic, assign, readonly) ASIHTTPRequest *httpRequest;

- (void)setParam:(id)param forKey:(id)key;
- (void)setIntegerParam:(NSInteger)param forKey:(id)key;
- (void)setFloatParam:(CGFloat)param forKey:(id)key;
- (void)setParam:(id)param forKey:(id)key usingFormat:(AFDataFormat)format;
- (void)getAsynchronous;
- (void)postAsynchronous;
- (id)getSynchronous;
- (id)postSynchronous;
- (id)resObjFromRequest:(ASIHTTPRequest *)request;
- (NSInteger)resultWithRequest:(ASIHTTPRequest *)request;
- (void)endRequest;

+ (void)endRequestFor:(id)aDelegate;

@end
