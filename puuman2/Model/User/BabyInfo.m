//
//  BabyInfo.m
//  puuman2
//
//  Created by Declan on 14-6-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfo.h"
#import "DateFormatter.h"
#import "PumanRequest.h"
#import "UniverseConstant.h"

@implementation BabyInfo

- (void)setWithDic:(NSDictionary *)dic
{
    _BID = [[dic valueForKey:@"BID"] integerValue];
    _Nickname = [dic valueForKey:@"Nickname"];
    _WhetherBirth = [[dic valueForKey:@"Whetherbirth"] boolValue];
    _Gender = [[dic valueForKey:@"Gender"] boolValue];
    _Birthday = [DateFormatter dateFromString:[dic valueForKey:@"Birthday"]];
    _PortraitUrl = [dic valueForKey:@"PortraitUrl"];
    _changedKeys = [[NSMutableSet alloc] init];
}

- (NSDictionary *)getDic
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSNumber numberWithInteger:_BID] forKey:@"BID"];
    [dic setValue:_Nickname forKey:@"Nickname"];
    [dic setValue:[NSNumber numberWithBool:_WhetherBirth] forKey:@"WhetherBirth"];
    [dic setValue:[NSNumber numberWithBool:_Gender] forKey:@"Gender"];
    [dic setValue:[DateFormatter stringFromDate:_Birthday] forKey:@"Birthday"];
    [dic setValue:_PortraitUrl forKey:@"PortraitUrl"];
    return dic;
}

- (void)setNickname:(NSString *)Nickname
{
    _Nickname = Nickname;
    [_changedKeys addObject:@"Nickname"];
}

- (void)setWhetherBirth:(BOOL)WhetherBirth
{
    _WhetherBirth = WhetherBirth;
    [_changedKeys addObject:@"WhetherBirth"];
}

- (void)setGender:(BOOL)Gender
{
    _Gender = Gender;
    [_changedKeys addObject:@"Gender"];
}

- (void)setBirthday:(NSDate *)Birthday
{
    _Birthday = Birthday;
    [_changedKeys addObject:@"Birthday"];
}

- (void)setPortraitUrl:(NSString *)PortraitUrl
{
    _PortraitUrl = PortraitUrl;
    [_changedKeys addObject:@"PortraitUrl"];
}

- (void)uploadPortrait:(UIImage *)portrait
{
    NSString *dir = [NSString stringWithFormat:@"%d", _BID];
    NSString *name = [NSString stringWithFormat:@"portrait/%@.jpg", [DateFormatter stringFromDatetime:[NSDate date]]];
    NSData *imagedata = UIImageJPEGRepresentation(portrait, 0.2);
    FileUploader * uploader = [[FileUploader alloc] init];
    uploader.delegate = self;
    [uploader uploadData:imagedata toDir:dir fileName:name];
}

- (PumanRequest *)uploadReq
{
    NSDictionary *dic = [self getDic];
    PumanRequest * req = [[PumanRequest alloc] init];
    req.urlStr = kUrl_SetBabyInfo;
    [req setIntegerParam:_BID forKey:@"BID"];
    for (NSString * key in _changedKeys) {
        [req setValue:[dic valueForKey:key] forKey:key];
    }
    return req;
}

- (BOOL)uploadInfoSync
{
    PumanRequest * req = [self uploadReq];
    [req postSynchronous];
    return req.result == PumanRequest_Succeeded;
}

- (void)uploadInfo
{
    PumanRequest * req = [self uploadReq];
    [req postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (!_delegate respondsToSelector:@selector(infoUploadFinish:))
        return;
    if (afRequest.result == PumanRequest_Succeeded) {
        [_delegate infoUploadFinish:YES];
    } else {
        [_delegate infoUploadFinish:NO];
    }
}

- (void)uploadResult:(BOOL)suc uploader:(FileUploader *)uploader
{
    if (!suc)
    {
        [self.delegate portraitUploadFinish:NO];
        return;
    }
    NSString *portraitUrl = uploader.targetUrl;
    NSString *ourl = _PortraitUrl;
    [self setPortraitUrl:portraitUrl];
    
    if ([self uploadInfoSync]) {
        [_delegate portraitUploadFinish:YES];
    }
    else {
        _PortraitUrl = ourl;
        [_changedKeys removeObject:@"PortraitUrl"];
        [_delegate portraitUploadFinish:NO];
    }
}

@end
