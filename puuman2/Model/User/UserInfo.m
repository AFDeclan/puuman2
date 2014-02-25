//
//  UserInfo.m
//  puman
//
//  Created by 陈晔 on 13-4-13.
//  Copyright (c) 2013年 ÂàõÂßã‰∫∫Âõ¢Èòü. All rights reserved.
//

#import "UserInfo.h"
#import "UniverseConstant.h"
#import "DateFormatter.h"
#import "ErrorLog.h"
#import "PumanRequest.h"


static UserInfo *instance = nil;

@interface UserInfo ()


@end

@implementation UserInfo

@synthesize UID = _UID;
@synthesize BID = _BID;
@synthesize identityStr = _identityStr;
@synthesize identity = _identity;
@synthesize inviteState = _inviteState;
@synthesize status = _status;
@synthesize createTime = _createTime;
@synthesize meta = _meta;
@synthesize pumanQuan = _pumanQuan;
@synthesize pwd_md5 = _pwd_md5;
@synthesize UMail = _UMail;
@synthesize UPhone = _UPhone;
@synthesize timeToResendVerifyMsg = _timeToResendVerifyMsg;

+ (void)init
{
    instance = [[UserInfo alloc] init];
}

+ (UserInfo *)sharedUserInfo
{
    if (!instance)
        instance = [[UserInfo alloc] init];
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        logined = NO;
        _UID = defaultUserID;
        self.mailAddr = @"";
        self.phoneNum = @"";
        _pwd_md5 = @"";
        _timeToResendVerifyMsg = 0;
    }
    return self;
}

- (BOOL)loginFromUserDefault
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *uInfo = [userDefaults valueForKey:userInfoKey];
    NSDictionary *uMeta = [userDefaults valueForKey:uMetaKey];
    logined = NO;
    if (uInfo)
    {
        _UMail = [uInfo valueForKey:userInfo_mail];
        _UPhone = [uInfo valueForKey:userInfo_phone];
        self.mailAddr = _UMail;
        self.phoneNum = _UPhone;
        _pwd_md5 = [uInfo valueForKey:userInfo_pwdMd5];
        _UID = [[uInfo valueForKey:userInfo_uid] integerValue];
        _BID = [[uInfo valueForKey:userInfo_bid] integerValue];
        _identityStr = [uInfo valueForKey:userInfo_identity];
        if ([_identityStr isEqualToString:kUserIdentity_Father])
        {
            _identity = Father;
        }
        else
        {
            _identity = Mother;
        }
        _createTime = [uInfo valueForKey:userInfo_createTime];
        _pumanQuan = [[uInfo valueForKey:userInfo_pumanQuan] doubleValue];
        if( uMeta != nil ){
            _meta = [[NSMutableDictionary alloc] initWithDictionary:uMeta];
        }
        else{
            _meta = [[NSMutableDictionary alloc] init];
        }
        [self updateInviteState];
        if (_UID != defaultUserID)
        {
            logined = YES;
            [self updateUserInfo];
            PostNotification(Noti_UserLogined, nil);
            [self uploadDeviceToken:NO];
        }
    }
    return logined;
}

- (void)updateInviteState
{
    NSString *inState = [_meta valueForKey:uMeta_InviteStateKey];
    if (inState)
    {
        if ([inState isEqualToString:@"Done"])
        {
            _inviteState = done;
        }
        else
        {
            NSTimeInterval inviteTime = [inState integerValue];
            if ([[NSDate date] timeIntervalSince1970] - inviteTime >= 24*60*60)
                _inviteState = noInvite;
            else
                _inviteState = waitForAccept;
        }
    }
    else _inviteState = noInvite;
}

- (void)saveToUserDefault
{
    NSMutableDictionary *uInfo = [[NSMutableDictionary alloc] init];
    [uInfo setValue:_UMail forKey:userInfo_mail];
    [uInfo setValue:_UPhone forKey:userInfo_phone];
    [uInfo setValue:_pwd_md5 forKey:userInfo_pwdMd5];
    [uInfo setValue:_identityStr forKey:userInfo_identity];
    [uInfo setValue:[NSString stringWithFormat:@"%d", _UID] forKey:userInfo_uid];
    [uInfo setValue:[NSString stringWithFormat:@"%d", _BID] forKey:userInfo_bid];
    [uInfo setValue:[NSString stringWithFormat:@"%f", _pumanQuan] forKey:userInfo_pumanQuan];
    [uInfo setValue:_createTime forKey:userInfo_createTime];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:uInfo forKey:userInfoKey];
    [userDefaults setObject:_meta forKey:uMetaKey];
    [userDefaults synchronize];
}

- (BOOL)logined
{
    return logined;
}

- (enum userActionResult)login
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_CheckUser;
    request.tag = 1;
    [request setTimeOutSeconds:5];
    [request setParam:self.mailAddr forKey:@"UMail"];
    [request setParam:self.phoneNum forKey:@"UPhone"];
    [request setParam:[MD5 md5:self.pwd] forKey:@"UPwd"];
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postSynchronous];
    NSInteger ret = request.result;
    NSDictionary *resDic = request.resObj;
    if (ret == PumanRequest_Succeeded)
    {
        if (resDic)
        {
            logined = YES;
            [self setUserInfoWithDic:resDic];
            PostNotification(Noti_UserLogined, nil);
            [self uploadDeviceToken:NO];
        }
        else ret = PumanRequest_OtherError;
    }
    return ret;
}

- (void)updateUserInfo
{
    if (!self.logined) return;
    PumanRequest *request = [[PumanRequest alloc] init];
    request.delegate = self;
    request.urlStr = kUrl_UpdateUserInfo;
    request.tag = 2;
    [request setTimeOutSeconds:5];
    [request setParam:[NSString stringWithFormat:@"%d", _UID] forKey:@"UID"];
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
}

- (BOOL)mailVerified
{
    return _status & 2;
}
- (BOOL)phoneVerified
{
    return _status & 1;
}

- (void)uploadDeviceToken:(BOOL)reset
{
    NSData *token = [MyUserDefaults valueForKey:kUDK_DeviceToken];
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_SetDeviceToken;
    request.tag = 3;
    request.delegate = self;
    [request setParam:token forKey:@"DeviceToken"];
    if (reset)
        [request setParam:@"-1" forKey:@"UID"];
    else
        [request setParam:[NSNumber numberWithInteger:_UID] forKey:@"UID"];
    [request postAsynchronous];
}

#pragma mark - AFRequestDelegate
- (void)requestEnded:(AFBaseRequest *)afRequest
{
    switch (afRequest.tag) {
        case 1:
        {
            break;
        }
        case 2:
        {
            NSDictionary *resDic = afRequest.resObj;
            if (resDic)
            {
                [self setUserInfoWithDic:resDic];
                PostNotification(Noti_UserInfoUpdated, nil);
            }
            break;
        }
        case 3:
        {
            if (afRequest.result != succeeded)
            {
                [ErrorLog errorLog:@"Failed to upload device token" fromFile:@"UserInfo.m" error:nil];
            }
            break;
        }
        default:
            break;
    }
}

- (void)logout
{
    [self uploadDeviceToken:YES];
    logined = NO;
    _UID = defaultUserID;
    _meta = nil;
    self.mailAddr = nil;
    _pumanQuan = 0.0;
    self.pwd = nil;
    _createTime = nil;
    [self saveToUserDefault];
    
    PostNotification(Noti_UserLogouted, nil);
}

#pragma mark - User Meta and Portrait
- (BOOL)uploadBabyMeta:(NSDictionary *)uMeta
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:kUrl_SetBabyMeta]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //set body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<Request Action=\"setBabyMeta\">"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSString *key in [uMeta keyEnumerator])
    {
        [postBody appendData:[[NSString stringWithFormat:@"<UserMeta>"] dataUsingEncoding:NSUTF8StringEncoding]];
        //UID
        [postBody appendData:[[NSString stringWithFormat:@"<BID>%d</BID>", _BID] dataUsingEncoding:NSUTF8StringEncoding]];
        //key
        [postBody appendData:[[NSString stringWithFormat:@"<UMKey>%@</UMKey>", key] dataUsingEncoding:NSUTF8StringEncoding]];
        //value
        [postBody appendData:[[NSString stringWithFormat:@"<UMVal>%@</UMVal>", [uMeta valueForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"</UserMeta>"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [postBody appendData:[[NSString stringWithFormat:@"</Request>"] dataUsingEncoding:NSUTF8StringEncoding]];
    //post
    [request setHTTPBody:postBody];
    [request setTimeoutInterval:5];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if ([data length] > 0 && error == nil)
    {
        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Response: %@", result);
        for (NSString *key in [uMeta keyEnumerator])
        {
            [_meta setValue:[uMeta valueForKey:key] forKey:key];
        }
        [self saveToUserDefault];
        PostNotification(Noti_UserInfoUpdated, nil);
        return YES;
    }
    else
    {
        if (error){
            [ErrorLog errorLog:@"upload usermeta error" fromFile:@"UserInfo.m" error:error];
            NSLog(@"upload usermeta error:%@",error.debugDescription);
            
        }
        return NO;
    }
}

- (BOOL)uploadBabyMetaVal:(NSString *)val forKey:(NSString *)key
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_SetBabyMetaSingle;
    [request setTimeOutSeconds:5];
    [request setParam:val forKey:@"value"];
    [request setParam:key forKey:@"key"];
    [request setParam:@"set" forKey:@"mode"];
    [request setParam:[NSNumber numberWithInteger:_BID] forKey:@"BID"];
    [request postSynchronous];
    
    if (request.result == PumanRequest_Succeeded)
    {
        [_meta setValue:val forKey:key];
        PostNotification(Noti_UserInfoUpdated, nil);
        return YES;
    }
    else return NO;
}

- (BOOL)uploadUserMetaVal:(NSString *)val forKey:(NSString *)key
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_SetUserMeta;
    [request setTimeOutSeconds:5];
    [request setParam:val forKey:@"value"];
    [request setParam:key forKey:@"key"];
    [request setParam:@"set" forKey:@"mode"];
    [request setParam:[NSNumber numberWithInteger:_UID] forKey:@"UID"];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        [_meta setValue:val forKey:key];
        PostNotification(Noti_UserInfoUpdated, nil);
        return YES;
    }
    else return NO;
    
}

- (void)uploadPortrait:(UIImage *)portrait
{
    portraitUploading = portrait;
    NSString *dir = [NSString stringWithFormat:@"%d", _UID];
    NSString *name = [NSString stringWithFormat:@"portrait/%@.jpg", [DateFormatter stringFromDatetime:[NSDate date]]];
    NSData *imagedata = UIImageJPEGRepresentation(portrait, 0.2);
    FileUploader * uploader = [[FileUploader alloc] init];
    uploader.delegate = self;
    [uploader uploadData:imagedata toDir:dir fileName:name];
}

- (void)uploadResult:(BOOL)suc uploader:(FileUploader *)uploader
{
    if (!suc)
    {
        [self.portraitUploadDelegate portraitUploadFinish:NO];
        return;
    }
    NSString *portraitUrl = uploader.targetUrl;
    if ([self uploadBabyMetaVal:portraitUrl forKey:uMeta_portraitUrl] ||[self uploadUserMetaVal:portraitUrl forKey:uMeta_portraitUrl])
    {
        [self.portraitUploadDelegate portraitUploadFinish:YES];
    }
    else
        [self.portraitUploadDelegate portraitUploadFinish:NO];
}

- (NSString *)portraitUrl
{
    return [_meta valueForKey:uMeta_portraitUrl];
}

- (BOOL)setAlipayAccount:(NSString *)alipayAccount
{
    return [self uploadUserMetaVal:alipayAccount forKey:uMeta_alipayAccount];
}

- (NSString *)alipayAccount
{
    return [_meta valueForKey:uMeta_alipayAccount];
}

- (void)setUserInfoWithDic:(NSDictionary *)dic
{
    id tp = [dic objectForKey:@"UID"];
    if( tp == nil ){  return; }
    _UID = [tp integerValue];
    _BID = [[dic objectForKey:@"BID"] integerValue];
    _identityStr = [dic objectForKey:@"Identity"];
    if ([_identityStr isEqualToString:kUserIdentity_Father])
    {
        _identity = Father;
    }
    else
    {
        _identity = Mother;
    }
    tp = [dic objectForKey:@"UStatus"];
    if( tp == nil ) _status = 1;    else _status = [tp integerValue];
    tp = [dic objectForKey:@"UCreateTime"];
    if( tp == nil )
        _createTime = [NSDate date];
    else{
        _createTime = [DateFormatter datetimeFromString:tp withFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    self.mailAddr = [dic objectForKey:@"UMail"];
    self.phoneNum = [dic objectForKey:@"UPhone"];
    _UPhone = [dic objectForKey:@"UPhone"];
    _UMail = [dic objectForKey:@"UMail"];
    _pwd_md5 = [dic objectForKey:@"UPwd"];
    tp = [dic objectForKey:@"hasMeta"];
    NSMutableDictionary* mm = nil;
    if( tp != nil && [tp isEqualToString:@"yes"] ){
        tp = [dic objectForKey:@"Metas"];
        if( tp != nil ){
            mm = [[NSMutableDictionary alloc] init];
            NSMutableArray* tparr = [NSMutableArray arrayWithArray:tp];
            for( int i = 0 ; i < [tparr count] ; i++ ){
                NSMutableDictionary* tpdic = [NSMutableDictionary dictionaryWithDictionary:[tparr objectAtIndex:i]];
                [mm setObject:[tpdic objectForKey:@"UMVal"] forKey:[tpdic objectForKey:@"UMKey"]];
            }
        }else
            mm = nil;
    }else
        mm = nil;
    _meta = mm;
    [_meta setValue:[dic objectForKey:uMeta_InviteStateKey] forKey:uMeta_InviteStateKey];
    [self updateInviteState];
    _pumanQuan = [[_meta valueForKey:@"UPuman"] doubleValue];
    [self saveToUserDefault];
}

#pragma mark - 账号关联
- (NSString *)invitedBy
{
    if (_inviteState == done) return nil;
    NSString *invitedStr = [_meta valueForKey:uMeta_InvitedKey];
    if (!invitedStr) return nil;
    NSTimeInterval invitedTime = [invitedStr integerValue];
    if (invitedTime - [[NSDate date] timeIntervalSince1970] > 24*60*60) return nil;
    if ([[invitedStr componentsSeparatedByString:@"#"] count] < 3) return nil;
    return [[invitedStr componentsSeparatedByString:@"#"] objectAtIndex:1];
}
- (enum userActionResult)acceptInvite
{
    NSString *url = kUrl_ConnectUser;
    NSString *invitedStr = [_meta valueForKey:uMeta_InvitedKey];
    NSString *token = [[invitedStr componentsSeparatedByString:@"#"] lastObject];
    url = [url stringByAppendingFormat:@"?token=%@", token];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:5];
    [request startSynchronous];
    if ([request error])
    {
        if ([[request error] code] == NSURLErrorTimedOut )
        {
            return timeOut;
        }
        else
        {
            return otherError;
        }
    }
    NSString *res = [request responseString];
    NSRange range = [res rangeOfString:@"账号关联成功"];
    if (range.location != NSNotFound)
    {
        [self updateUserInfo];
        return succeeded;
    }
    else return otherError;
}
- (enum userActionResult)rejectInvite
{
    return [self uploadUserMetaVal:@"" forKey:uMeta_InvitedKey];
}

#pragma mark - 密码相关
- (BOOL)checkPwd:(NSString *)pwd
{
    return [_pwd_md5 isEqualToString:[MD5 md5:pwd]];
}

- (enum userActionResult)changePwdTo:(NSString *)newPwd
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_ChangePwd;
    [request setParam:[MD5 md5:newPwd] forKey:@"newPwd_md5"];
    [request setParam:_pwd_md5 forKey:@"oldPwd_md5"];
    [request setParam:[NSNumber numberWithInteger:_UID] forKey:@"uid"];
    //设置请求方式
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    return request.result;
}

- (enum userActionResult)changeMailTo:(NSString *)newMail phoneTo:(NSString *)newPhone
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_ChangeMailOrPhone;
    [request setParam:_pwd_md5 forKey:@"oldPwd_md5"];
    [request setParam:newMail forKey:@"newMail"];
    [request setParam:newPhone forKey:@"newPhone"];
    [request setParam:[NSNumber numberWithInteger:_UID] forKey:@"uid"];
    //设置请求方式
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        if (newMail && ![newMail isEqualToString:@""])
        {
            _UMail = newMail;
            _mailAddr = newMail;
        }
        else
        {
            _UPhone = newPhone;
            _phoneNum = newPhone;
        }
    }
    return request.result;
}


#pragma mark - 邀请和注册

- (enum userActionResult)sendInvitationToMail:(NSString *)mail phoneNum:(NSString *)phone
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_SendRigisterInvitation;
    [request setParam:[NSNumber numberWithInteger:_UID] forKey:@"UID"];
    [request setParam:phone forKey:@"Phone"];
    [request setParam:mail forKey:@"Mail"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        [_meta setValue:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] forKey:uMeta_InviteStateKey];
        [self updateInviteState];
    }
    return request.result;
}

- (enum userActionResult)verifyUser:(BOOL)verifMail
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_VerifyUser;
    [request setParam:[NSNumber numberWithInt:_UID] forKey:@"UID"];
    if (verifMail)
        [request setParam:@"1" forKey:@"mode"];
    else [request setParam:@"0" forKey:@"mode"];
    //设置请求方式
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        NSString *mailOrPhone = request.resObj;
        if (verifMail)
        {
            _UMail = mailOrPhone;
            self.mailAddr = _UMail;
        }
        else
        {
            _UPhone = mailOrPhone;
            self.phoneNum = _UPhone;
        }
    }
    if (!verifMail)
    {
        _timeToResendVerifyMsg = 60;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(minusTimeToResend:) userInfo:nil repeats:YES];
    }
    return request.result;
}

- (void)minusTimeToResend:(NSTimer *)timer
{
    _timeToResendVerifyMsg --;
    if (_timeToResendVerifyMsg == 0)
        [timer invalidate];
}

- (enum userActionResult)verifyPhoneWithCode:verif
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_VerifyPhoneWithCode;
    [request setParam:[NSNumber numberWithInt:_UID] forKey:@"UID"];
    [request setParam:_phoneNum forKey:@"Phone"];
    [request setParam:verif forKey:@"token"];
    //设置请求方式
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    if (request.result == PumanRequest_Succeeded)
    {
        _status |= 1;
    }
    return request.result;
    
}

+ (enum userActionResult)resetPwdForMail:(NSString *)mail phoneNum:(NSString *)phone
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_ResetPwd;
    [request setParam:phone forKey:@"UPhone"];
    [request setParam:mail forKey:@"UMail"];
    [request setTimeOutSeconds:5];
    [request postSynchronous];
    return request.result;
}

//- (enum userActionResult)changeIdentityTo:(UserIdentity)identity
//{
//    if (identity == _identity) return succeeded;
//    PumanRequest *request = [[PumanRequest alloc] init];
//    request.urlStr = kUrl_SetUserIdentity;
//    [request setParam:[NSNumber numberWithInt:_UID] forKey:@"UID"];
//    switch (identity) {
//        case Father:
//            [request setParam:@"father" forKey:@"Identity"];
//            break;
//        default:
//            [request setParam:@"mother" forKey:@"Identity"];
//            break;
//    }
//    //设置请求方式
//    [request setTimeOutSeconds:5];
//    [request postSynchronous];
//    if (request.result == PumanRequest_Succeeded)
//    {
//        _identity = identity;
//        [_meta setValue:[request.params valueForKey:@"Identity"] forKey:@"Identity"];
//    }
//    return request.result;
//}

@end
