//
//  SocialNetwork.m
//  puman
//
//  Created by 陈晔 on 13-9-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SocialNetwork.h"
#import "UniverseConstant.h"
#import "UserInfo.h"
#import "TaskUploader.h"
#import "ErrorLog.h"
#import "CustomAlertViewController.h"
#import "CustomNotiViewController.h"

#define kWeiXinAppKey    @"wx8bc5e7464037f911"

#define kWeiboAppKey             @"3177530976"
#define kWeiboAppSecret          @"d5bfad271933d0f03b37588c253bd469"
#define kWeiboAppRedirectURI     @"http://1.pumansocial.sinaapp.com/callback.php"

#define kTencentAppId       @"100456789"

#define kUserDefault_TencentAuthAccessToken     @"TencentAuthAccessToken"
#define kUserDefault_TencentAuthOpenID          @"TencentAuthOpenID"
#define kUserDefault_TencentAuthExpire          @"TencentAuthExpire"
#define kUserDefault_TencentUserName            @"TencentUserName"
#define kUserDefault_TencentUserImgUrl          @"TencentImgUrl"

#define kUserDefault_WeiboAuthAccessToken     @"WeiboAuthAccessToken"
#define kUserDefault_WeiboAuthOpenID          @"WeiboAuthOpenID"
#define kUserDefault_WeiboAuthExpire          @"WeiboAuthExpire"
#define kUserDefault_WeiboUserName            @"WeiboUserName"
#define kUserDefault_WeiboUserImgUrl          @"WeiboUserImgUrl"


static SocialNetwork * instance;

@implementation SocialNetwork

+ (SocialNetwork *)sharedInstance
{
    if (!instance) instance = [[SocialNetwork alloc] init];
    return instance;
}

+ (void)initSocialNetwork
{
    [WXApi registerApp:kWeiXinAppKey];
    [[self sharedInstance] initFromCache];
}

+ (BOOL)handleOpenURL:(NSURL *)url
{
    return [[self sharedInstance] handleOpenURL:url];
}

- (void)initFromCache
{
    self.QQUserName = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentUserName, [UserInfo sharedUserInfo].UID]];
    self.QQUserImgUrl = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentUserImgUrl, [UserInfo sharedUserInfo].UID]];
    [self setQQWithCache];
    if ([_tencentAuth isSessionValid])
        [_tencentAuth getUserInfo];
    
    self.WeiboUserName = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboUserName, [UserInfo sharedUserInfo].UID]];
    self.WeiboUserImgUrl = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboUserImgUrl, [UserInfo sharedUserInfo].UID]];
    [self setWeiboWithCache];
    if ([_weiboAuth isAuthValid])
    {
        [_weiboAuth cancelRequest];
        [self updateWeiboUserInfo];
    }

}

- (SocialNetwork *)init
{
    if (self = [super init])
    {
        [_tencentAuth cancel:nil];
        _tencentAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppId andDelegate:self];
        
        [_weiboAuth cancelRequest];
        _weiboAuth.delegate = nil;
        _weiboAuth = [[SinaWeibo alloc] initWithAppKey:kWeiboAppKey appSecret:kWeiboAppSecret appRedirectURI:kWeiboAppRedirectURI andDelegate:self];
    }
    return self;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    BOOL wxHandle = [WXApi handleOpenURL:url delegate:self];
    BOOL weiboHandle = [_weiboAuth handleOpenURL:url];
    BOOL tecentHandle = [TencentOAuth HandleOpenURL:url];
    return wxHandle || weiboHandle || tecentHandle;
}

- (void)shareText:(NSString *)text title:(NSString *)title image:(UIImage *)img toSocial:(SocialType)type
{
    _shareTitle = title;
    _shareText = text;
    _shareImg = img;
    switch (type) {
        case QQ:
            [self shareToQQ];
            break;
        case Weibo:
            [self shareToWeibo];
            break;
        case Weixin:
            [self shareToWeixin];
            break;
        default:
            break;
    }
}

- (void)loginToSocial:(SocialType)type
{
    switch (type) {
        case QQ:
            [self loginToQQ];
            break;
        case Weibo:
            [self loginToWeibo];
            break;
        default:
            break;
    }

}

#pragma mark - 微信
- (void)shareToWeixin
{
    NSString *version = [WXApi getWXAppSupportMaxApiVersion];
    NSLog(@"Weixin version:%@", version);
    if ([version isEqualToString:@""])
    {
        [CustomAlertViewController showAlertWithTitle:@"分享失败，请确保已安装微信~" confirmRightHandler:^{
        
    }];
        return;
    }
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.scene = WXSceneTimeline;
    if (_shareImg)
    {
        req.bText = NO;
        WXMediaMessage *message = [WXMediaMessage message];
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = UIImageJPEGRepresentation(_shareImg, 1);
        message.mediaObject = ext;
//        [message setThumbImage:_shareImg];
        req.message = message;
    }
    else
    {
        req.bText = YES;
        req.text = [NSString stringWithFormat:@"%@ -- %@", _shareTitle, _shareText];
    }
    
    if ([WXApi sendReq:req])
    {
       
        NSLog(@"分享到朋友圈成功");
        [self shareSucceeded];
    }
    else
    {
       // PostNotification(Noti_ShowAlert, );
        [CustomAlertViewController showAlertWithTitle:@"分享到朋友圈失败~微信1.1以上版本才可以喔~" confirmRightHandler:^{
            
        }];
    }

}

- (void)onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        [self onRequestAppMessage];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        [self onShowMediaMessage:temp.message];
    }
}

- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSLog(@"微信发送媒体消息结果:%d", resp.errCode);
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        NSLog(@"微信Auth结果:%d", resp.errCode);
    }
}

- (void)onShowMediaMessage:(WXMediaMessage *) message
{
    NSLog(@"微信message:%@", message);
}

- (void)onRequestAppMessage
{
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
}

#pragma mark - 微博

- (void)loginToWeibo
{
    [_weiboAuth logIn];
}

- (void)updateWeiboUserInfo
{
    if ([_weiboAuth isAuthValid])
    {
        NSString *url = @"https://api.weibo.com/2/users/show.json";
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:_weiboAuth.userID forKey:@"uid"];
        [_weiboAuth requestWithURL:url params:param httpMethod:@"GET" delegate:self tag:1];
    }
}

- (void)setWeiboWithCache
{
    NSString *token = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboAuthAccessToken, [UserInfo sharedUserInfo].UID]];
    NSString *authOpenId = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboAuthOpenID, [UserInfo sharedUserInfo].UID]];
    NSDate *expireDate = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboAuthExpire, [UserInfo sharedUserInfo].UID]];
    [_weiboAuth setUserID:authOpenId];
    [_weiboAuth setAccessToken:token];
    [_weiboAuth setExpirationDate:expireDate];
}

- (void)shareToWeibo
{
    if (![_weiboAuth isAuthValid])
    {
        [self setWeiboWithCache];
    }
    _waitingForShare = YES;
    if (![_weiboAuth isAuthValid])
    {
        [self loginToWeibo];
    }
    else
    {
        NSString *addBlogUrl = @"https://api.weibo.com/2/statuses/update.json";
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:[NSString stringWithFormat:@"%@  %@", _shareTitle, _shareText] forKey:@"status"];
        if (_shareImg)
        {
            addBlogUrl = @"https://upload.api.weibo.com/2/statuses/upload.json";
            [params setObject:UIImageJPEGRepresentation(_shareImg, 1) forKey:@"pic"];
        }
        [_weiboAuth requestWithURL:addBlogUrl params:params httpMethod:@"POST" delegate:self tag:2];
    }
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
     [ErrorLog errorLog:@"" fromFile:@"SocialNetwork.m" error:error];
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    if ([_weiboAuth isAuthValid])
    {
        if (_waitingForShare) [self shareToWeibo];
        NSLog(@"weibo logined");
        NSString *token = _weiboAuth.accessToken;
        NSString *authOpenId = _weiboAuth.userID;
        NSDate *expireDate = _weiboAuth.expirationDate;
        [MyUserDefaults setValue:token forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboAuthAccessToken, [UserInfo sharedUserInfo].UID]];
        [MyUserDefaults setValue:authOpenId forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboAuthOpenID, [UserInfo sharedUserInfo].UID]];
        [MyUserDefaults setValue:expireDate forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboAuthExpire, [UserInfo sharedUserInfo].UID]];
        [self updateWeiboUserInfo];
    }
        
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{

     [ErrorLog errorLog:@"sina request failed" fromFile:@"SocialNetwork.m" error:error];
     NSLog(@"sina request failed:%@", error);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
//    NSLog(@"sina request result:%@", result);
    if (request.tag == 1)
    {
        NSString *userName = [result objectForKey:@"screen_name"];
        NSString *imgUrl = [result objectForKey:@"profile_image_url"];
        [MyUserDefaults setValue:userName forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboUserName, [UserInfo sharedUserInfo].UID]];
        [MyUserDefaults setValue:imgUrl forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_WeiboUserImgUrl, [UserInfo sharedUserInfo].UID]];
        self.WeiboUserName = userName;
        self.WeiboUserImgUrl = imgUrl;
        PostNotification(Noti_SocialLoginSucceeded, [NSNumber numberWithInteger:Weibo]);
        NSString *weiboId = [result objectForKey:@"id"];
        [[UserInfo sharedUserInfo] uploadUserMetaVal:weiboId forKey:@"SinaWeibo"];
    }
    else if (request.tag == 2)
    {
        [self shareSucceeded];
    }
}

#pragma mark - QQ
- (void)loginToQQ
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            nil];
    [_tencentAuth authorize:permissions inSafari:NO];
}

- (void)setQQWithCache
{
    NSString *token = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentAuthAccessToken, [UserInfo sharedUserInfo].UID]];
    NSString *authOpenId = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentAuthOpenID, [UserInfo sharedUserInfo].UID]];
    NSDate *expireDate = [MyUserDefaults valueForKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentAuthExpire, [UserInfo sharedUserInfo].UID]];
    [_tencentAuth setAccessToken:token];
    [_tencentAuth setOpenId:authOpenId];
    [_tencentAuth setExpirationDate:expireDate];
}

- (void)shareToQQ
{
    if (![_tencentAuth isSessionValid])
    {
        [self setQQWithCache];
    }
    _waitingForShare = YES;
    if (![_tencentAuth isSessionValid])
    {
        [self loginToQQ];
    }
    else
    {
        _waitingForShare = NO;
        TCAddOneBlogDic *params = [TCAddOneBlogDic dictionary];
        params.paramTitle = _shareTitle;
        params.paramContent = _shareText;
        params.paramUserData = [[NSDictionary alloc] init];
        [_tencentAuth addOneBlogWithParams: params];
    }
}

- (void)shareToTencentWeibo
{

}

- (void)tencentDidLogin
{
    if ([_tencentAuth isSessionValid])
    {
        NSLog(@"tencent logined");
        NSString *token = _tencentAuth.accessToken;
        NSString *authOpenId = _tencentAuth.openId;
        NSDate *expireDate = _tencentAuth.expirationDate;
        [MyUserDefaults setValue:token forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentAuthAccessToken, [UserInfo sharedUserInfo].UID]];
        [MyUserDefaults setValue:authOpenId forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentAuthOpenID, [UserInfo sharedUserInfo].UID]];
        [MyUserDefaults setValue:expireDate forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentAuthExpire, [UserInfo sharedUserInfo].UID]];
        [_tencentAuth getUserInfo];
        if (_waitingForShare)
            [self shareToQQ];
    }
    else
    {
         [ErrorLog errorLog:@"tencent Login Failed!" fromFile:@"SocialNetwork.m" error:nil];
        NSLog(@"tencent Login Failed!");
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [ErrorLog errorLog:@"tencent Login Failed!" fromFile:@"SocialNetwork.m" error:nil];
    if (!cancelled) NSLog(@"tencent Login Failed!");
}

- (void)tencentDidNotNetWork
{
    [ErrorLog errorLog:@"Tencent not network" fromFile:@"SocialNetwork.m" error:nil];
    NSLog(@"Tencent not network");
}

- (void)addOneBlogResponse:(APIResponse *)response
{
    if (URLREQUEST_SUCCEED == response.retCode
        && kOpenSDKErrorSuccess == response.detailRetCode)
    {
        NSLog(@"QQ发日志成功");
        [self shareSucceeded];
    }
    else
    {
       
        [ErrorLog errorLog:@"QQ发日志失败" fromFile:@"SocialNetwork.m" error:nil];
        NSString *errMsg = [NSString stringWithFormat:@"errorMsg:%@\n%@", response.errorMsg, [response.jsonResponse objectForKey:@"msg"]];
        NSLog(@"QQ发日志失败，error：%@", errMsg);
    }
}

- (void)getUserInfoResponse:(APIResponse *)response
{
//    NSLog(@"qq response:%@", response.jsonResponse);
    NSString *userName = [response.jsonResponse valueForKey:@"nickname"];
    NSString *imgUrl = [response.jsonResponse valueForKey:@"figureurl"];
    self.QQUserName = userName;
    self.QQUserImgUrl = imgUrl;
    [MyUserDefaults setValue:userName forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentUserName, [UserInfo sharedUserInfo].UID]];
    [MyUserDefaults setValue:imgUrl forKey:[NSString stringWithFormat:@"%@_%d", kUserDefault_TencentUserImgUrl, [UserInfo sharedUserInfo].UID]];
    
    PostNotification(Noti_SocialLoginSucceeded, [NSNumber numberWithInteger:QQ]);
}



- (void)shareSucceeded
{
    
    [CustomNotiViewController showNotiWithTitle:@"分享成功" withTypeStyle:kNotiTypeStyleRight];

}


@end
