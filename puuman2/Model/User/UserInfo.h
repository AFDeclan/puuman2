//
//  UserInfo.h
//  puman
//
//  Created by 陈晔 on 13-4-13.
//  Copyright (c) 2013年 ÂàõÂßã‰∫∫Âõ¢Èòü. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileUploader.h"
#import "JSONKit.h" 
#import "MD5.h"
#import "MobClick.h"
#import "UniverseConstant.h"
#import "AFNetwork.h"
#import "ShareVideo.h"


#define defaultUserID       -1

#define kUserIdentity_Father    @"father"
#define kUserIdentity_Mother    @"mother"

typedef enum userActionResult{
     //both
    succeeded = -1,
    otherError = 0,
    timeOut = 1,
    //login
    checkFailed = 2,
    //register
    dumplicated = 3,
    //resetpwd
    noSuchUser = 4
} UserActionResult;

typedef enum userIdentity {
    Father = 0,
    Mother = 1
} UserIdentity;

typedef enum inviteState {
    noInvite = 0,
    waitForAccept = 1,
    done = 2,
}InviteState;


@protocol UserPortraitUploadDelegate <NSObject>
- (void)portraitUploadFinish:(BOOL)suc;
@end

@interface UserInfo : NSObject <UploaderDelegate, ASIHTTPRequestDelegate, AFRequestDelegate>
{
    BOOL logined;
    UIImage *portraitUploading;
}

@property (assign, readonly) NSInteger        UID;
@property (assign, readonly) NSInteger        BID;
@property (retain, readonly) NSString*        identityStr;
@property (assign, readonly) enum userIdentity identity;
@property (assign, readonly) enum inviteState inviteState;
@property (retain, readonly) NSString*        pwd_md5;
@property (assign, readonly) NSInteger        status;
@property (retain, readonly) NSDate*          createTime;
@property (retain, readonly) NSMutableDictionary* meta;
@property (assign, readonly) double           pumanQuan;
@property (retain, readonly) NSString *       UMail;
@property (retain, readonly) NSString *       UPhone;
//@property (assign, readonly) double           pumanUsed;
//登录时填充
@property (retain) NSString*        mailAddr;
@property (retain) NSString*        phoneNum;
@property (retain) NSString*        pwd;
//重发验证码倒计时
@property (assign, nonatomic, readonly) NSInteger timeToResendVerifyMsg;

@property (retain, nonatomic, readonly) ShareVideo * shareVideo;

@property (assign, nonatomic) NSObject<UserPortraitUploadDelegate> *portraitUploadDelegate;

+ (void)init;
+ (UserInfo *)sharedUserInfo;

//登陆
- (BOOL)loginFromUserDefault;
- (enum userActionResult)login;
//登出
- (void)logout;

//提交用户信息。
- (BOOL)uploadBabyMeta:(NSDictionary *)uMeta;
- (BOOL)uploadBabyMetaVal:(NSString *)val forKey:(NSString *)key;
- (BOOL)uploadUserMetaVal:(NSString *)val forKey:(NSString *)key;
- (void)uploadPortrait:(UIImage *)portrait;
- (NSString *)portraitUrl;
- (NSString *)alipayAccount;
- (BOOL)setAlipayAccount:(NSString *)alipayAccount;
- (BOOL)mailVerified;
- (BOOL)phoneVerified;

- (BOOL)logined;
- (BOOL)checkPwd:(NSString *)pwd;

- (enum userActionResult)changePwdTo:(NSString *)newPwd;
- (enum userActionResult)changeMailTo:(NSString *)newMail phoneTo:(NSString *)newPhone;

//更新用户信息
- (void)updateUserInfo;

//关联账户
- (NSString *)invitedBy;
- (enum userActionResult)acceptInvite;
- (enum userActionResult)rejectInvite;

//邀请
- (enum userActionResult)sendInvitationToMail:(NSString *)mail phoneNum:(NSString *)phone;
/*
 succeeded, timeOut, otherError, 
 dumplicated: 被邀请用户已注册
 */
- (enum userActionResult)verifyUser:(BOOL)verifMail;
/*
succeeded, timeOut, otherError
*/
- (enum userActionResult)verifyPhoneWithCode:verif;
/*
 succeeded, timeOut, checkFaild（验证码有误）, otherError
 */
+ (enum userActionResult)resetPwdForMail:(NSString *)mail phoneNum:(NSString *)phone;

@end
