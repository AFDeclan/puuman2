//
//  UserInfo.m
//  puuman model
//
//  Created by 陈晔 on 13-4-13.
//  Copyright (c) 2013年 ÂàõÂßã‰∫∫Âõ¢Èòü. All rights reserved.
//

#import "UserInfo.h"
#import "UniverseConstant.h"
#import "DateFormatter.h"
#import "ErrorLog.h"
#import "PumanRequest.h"
#import "MemberCache.h"
#import "DiaryModel.h"
#import "Diary.h"

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
@synthesize UCorns = _UCorns;
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
        _UCorns = [[uInfo valueForKey:userInfo_UCorns] doubleValue];
        _UCorns_connect = [[uInfo valueForKey:userInfo_UCornsConnect] doubleValue];
        
        _UCornsUsed = [[uInfo valueForKey:userInfo_UCornsUsed] doubleValue];
        _UCornsBound = [[uInfo valueForKey:userInfo_pumanBound] doubleValue];
        _UCornsLocalAdded = [[uInfo valueForKey:userInfo_pumanLocalAdded] doubleValue];
        _UCornsLocalAdded_daily = [[uInfo valueForKey:userInfo_pumanLocalAddedDaily] doubleValue];
        _babyInfo = [[BabyInfo alloc] init];
        [_babyInfo setWithDic:[uInfo valueForKey:userInfo_Baby]];
        _addTime = [uInfo valueForKey:userInfo_pumanLocalAddedTime];
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
    [uInfo setValue:[NSString stringWithFormat:@"%f", _UCorns] forKey:userInfo_UCorns];
    [uInfo setValue:[NSString stringWithFormat:@"%f", _UCorns_connect] forKey:userInfo_UCornsConnect];
    [uInfo setValue:[NSString stringWithFormat:@"%f", _UCornsUsed] forKey:userInfo_UCornsUsed];
    [uInfo setValue:[NSString stringWithFormat:@"%f", _UCornsBound] forKey:userInfo_pumanBound];
    [uInfo setValue:[NSString stringWithFormat:@"%f", _UCornsLocalAdded] forKey:userInfo_pumanLocalAdded];
    [uInfo setValue:[NSString stringWithFormat:@"%f", _UCornsLocalAdded_daily] forKey:userInfo_pumanLocalAddedDaily];
    [uInfo setValue:[_babyInfo getDic] forKey:userInfo_Baby];
    [uInfo setValue:_addTime forKey:userInfo_pumanLocalAddedTime];
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

- (BOOL)addCorns:(double)add
{
    if ([[DateFormatter stringFromDate:_addTime] isEqualToString:[DateFormatter stringFromDate:[NSDate date]]]) {
        if (_UCornsLocalAdded_daily >= _UCornsBound) {
            return NO;
        }
        _UCornsLocalAdded_daily += add;
    }
    _UCornsLocalAdded += add;
    _UCorns += add;
    return YES;
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
    [request setIntegerParam:_UID forKey:@"UID"];
    [request setIntegerParam:_UCornsLocalAdded forKey:@"UCornsLocalAdded"];
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
    _UCorns = 0.0;
    self.pwd = nil;
    _createTime = nil;
    [self saveToUserDefault];
    
    PostNotification(Noti_UserLogouted, nil);
}

#pragma mark - User Meta and Portrait

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
    _UCorns = [[dic valueForKey:@"UCorns"] doubleValue];
    _UCorns_connect = [[dic valueForKey:@"UCorns_connect"] doubleValue];
    
    _UCornsUsed = [[dic valueForKey:@"UCornsUsed"] doubleValue];
    _UCornsBound = [[dic valueForKey:@"UCornsBound"] doubleValue];
    _UCornsLocalAdded = 0;
    _UCornsLocalAdded_daily = 0;
    _babyInfo = [[BabyInfo alloc] init];
    [_babyInfo setWithDic:[dic valueForKey:@"Baby"]];
    if ([[dic valueForKey:@"ShareInfo"] isKindOfClass:[NSDictionary class]]) {
        _shareVideo = [[ShareVideo alloc] init];
        [_shareVideo initWithData:[dic valueForKey:@"ShareInfo"]];
    }
    NSMutableDictionary* mm = nil;
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
    _meta = mm;
    [_meta setValue:[dic objectForKey:uMeta_InviteStateKey] forKey:uMeta_InviteStateKey];
    [self updateInviteState];
    tp = [dic valueForKey:@"ShareInfo"];
    if (tp != nil && [tp isKindOfClass:[NSDictionary class]]) {
        
        if (_shareVideo && _shareVideo.RID ==[[tp valueForKey:@"RID"] integerValue]) {
            _shareVideo = [[ShareVideo alloc] init];
            [_shareVideo initWithData:tp];
            
            
        }else{
            if (!_shareVideo) {
                _shareVideo = [[ShareVideo alloc] init];
            }
            [_shareVideo initWithData:tp];
            PostNotification(Noti_HasShareVideo, nil);
        }
    }
    for (Diary * d in [self rewardDiaryList]) {
        [d setRewarded];
        [[DiaryModel sharedDiaryModel] updateDiary:d needUpload:NO];
    }
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

- (NSArray *)rewardDiaryList
{
    id tp = [[_meta valueForKey:uMeta_RewardList] objectFromJSONString];
    if (!tp || ![tp isKindOfClass:[NSArray class]]) return nil;
    NSMutableArray * list = [[NSMutableArray alloc] init];
    for (NSString * str in tp) {
        NSDate * createTime = [DateFormatter datetimeFromTimestampStr:str];
        Diary * d = [[DiaryModel sharedDiaryModel] diaryAtDate:createTime];
        if (d) {
            [list addObject:d];
        }
    }
    return list;
}

- (void)resetRewardList
{
    [self uploadUserMetaVal:@"[]" forKey:uMeta_RewardList];
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
    [request setIntegerParam:_UID forKey:@"UID"];
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
