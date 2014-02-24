//
//  SocialNetwork.h
//  puman
//
//  Created by 陈晔 on 13-9-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "SinaWeibo.h"
#import <TencentOpenAPI/TencentOAuth.h>

typedef enum e_SocialType{
    Weixin = 0,
    Weibo,
    QQ,
    TencentWeibo
} SocialType;

@interface SocialNetwork : NSObject <SinaWeiboDelegate, SinaWeiboRequestDelegate, WXApiDelegate, TencentSessionDelegate>
{
    TencentOAuth *_tencentAuth;
    SinaWeibo *_weiboAuth;
    BOOL _waitingForShare;
    NSString *_shareText;
    NSString *_shareTitle;
    UIImage *_shareImg;
}

@property (nonatomic, retain) NSString * WeiboUserName;
@property (nonatomic, retain) NSString * WeiboUserImgUrl;

@property (nonatomic, retain) NSString * QQUserName;
@property (nonatomic, retain) NSString * QQUserImgUrl;

//返回单例
+ (SocialNetwork *)sharedInstance;

//初始化，须在其他方法之前调用
+ (void)initSocialNetwork;
    /*
    应读入本地缓存的用户数据，并更新用户头像 目前未实现
     */

//handleOpenUrl 对应于AppDelegate里的handleOpenUrl和openUrl方法
+ (BOOL)handleOpenURL:(NSURL *)url;

//分享内容到指定网络
- (void)shareText:(NSString *)text title:(NSString *)title image:(UIImage *)img toSocial:(SocialType)type;
    /*
     如果本地缓存token未过期则直接使用，否则先进行登录，完成后再分享
     */

//账户登录
- (void)loginToSocial:(SocialType)type;
    /*
     登录完成后发送Notification
     Name: Noti_SocialLoginSucceeded
     Object: NSNumber{
                 社交网络类型 1微博 2qq
            }
     如果获取用户头像为异步过程，则登录成功后发一次消息，其中kSocialUserPortrait为nil，获取成功后再发一次消息
     登录完成后将用户信息（用户名，token，expireDate，头像等）在本地缓存
     */


@end
