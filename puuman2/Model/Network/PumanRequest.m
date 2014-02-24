//
//  PumanRequest.m
//  puman
//
//  Created by Declan on 13-12-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "PumanRequest.h"
#import "UniverseConstant.h"
#import <JSONKit.h>
#import <XMLReader.h>

@implementation PumanRequest

@synthesize feedBackIdentity = _feedBackIdentity;

@synthesize resEncoding = _resEncoding;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setParam:[MobClick getConfigParams:umeng_onlineConfig_authKey] forKey:@"authCode"];
        _resEncoding = PumanRequestRes_NoneEncoding;
        _feedBackIdentity = YES;
    }
    return self;
}


- (NSInteger)resultWithRequest:(ASIHTTPRequest *)request
{
    if (request.error)
    {
        if (request.error.code == 2 || request.error.code == 1)
        {
            return PumanRequest_TimeOut;
        }
        else
        {
            [ErrorLog requestFailedLog:request fromFile:@"PumanRequest"];
            return PumanRequest_OtherError;
        }
    }
    if (_feedBackIdentity)
    {
        NSString *res = [request responseString];
        NSRange range = [res rangeOfString: _puman_feedback_identifier_prefix];
        if( range.length == 0 ){
            range = [res rangeOfString:_puman_feedbackFailed_identifier_prefix];
            if (range.length == 0)
            {
                [ErrorLog requestFailedLog:request fromFile:@"PumanRequest"];
                return PumanRequest_OtherError;
            }
            else
            {
                res = [res substringFromIndex:range.length + range.location];
                return [res integerValue];
            }
        }

    }
    return PumanRequest_Succeeded;
}

- (id)resObjFromRequest:(ASIHTTPRequest *)request
{
    NSString *res = [request responseString];
    NSRange range = [res rangeOfString: _puman_feedback_identifier_prefix];
    if( range.length == 0 && _feedBackIdentity){
        return nil;
    }
    else
    {
        if (_feedBackIdentity) res = [res substringFromIndex:range.location+range.length];
        switch (_resEncoding) {
            case PumanRequestRes_NoneEncoding:
                return res;
                break;
            case PumanRequestRes_JsonEncoding:
            {
                if ([res isEqualToString:@""])
                    return nil;
                NSError *parseError = nil;
                id result = [res objectFromJSONStringWithParseOptions:JKParseOptionNone error:&parseError];
                if (parseError)
                {
                    [ErrorLog requestFailedLog:request fromFile:@"PumanRequest"];
                }
                return result;
            }
            case PumanRequestRes_XmlEncoding:
            {
                if (_feedBackIdentity)
                {
                    if ([res isEqualToString:@""])
                        return nil;
                    NSError *parseError = nil;
                    id result = [XMLReader dictionaryForXMLString:res error:&parseError];
                    if (parseError)
                    {
                        [ErrorLog requestFailedLog:request fromFile:@"PumanRequest"];
                    }
                    return result;
                }
                else
                {
                    NSData *resData = [request responseData];
                    NSError *parseError = nil;
                    id result = [XMLReader dictionaryForXMLData:resData error:&parseError];
                    if (parseError)
                    {
                        [ErrorLog requestFailedLog:request fromFile:@"PumanRequest"];
                    }
                    return result;
                }
            }
        }
        
    }
}


@end
