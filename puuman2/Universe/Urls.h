//
//  Urls.h
//  puman
//
//  Created by 陈晔 on 13-11-9.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#ifndef puman_Urls_h
#define puman_Urls_h

#pragma mark - 各类网址

//ware
#define kUrl_GetWareFilterDb @"http://1.server4puman.sinaapp.com/Ware/getFilterDb.php"
#define kUrl_GetWareFilterDbForTest @"http://1.server4puman.sinaapp.com/Ware/getFilterDb_test.php"
#define kUrl_GetWareListWithWID @"http://1.server4puman.sinaapp.com/Ware/getWaresWithWID.php"
#define kUrl_GetWareList @"http://1.server4puman.sinaapp.com/Ware/getWareList.php"
#define kUrl_GetWareList_Subtype @"http://1.server4puman.sinaapp.com/Ware/getWareListForSubType.php"
#define kUrl_GetWareList_Search @"http://1.server4puman.sinaapp.com/Ware/searchWareList.php"
#define kUrl_GetCartDone       @"http://1.server4puman.sinaapp.com/Ware/getCartDone.php"
#define kUrl_GetRecomWares     @"http://1.server4puman.sinaapp.com/Ware/getRecomWares.php"
#define kUrl_SearchWareIds          @"http://1.server4puman.sinaapp.com/Ware/searchWareIds.php"
//user
#define kUrl_SetUserIdentity @"http://1.server4puman.sinaapp.com/User/setIdentity.php"
#define kUrl_SetUserMeta @"http://1.server4puman.sinaapp.com/User/UserMeta.php"
#define kUrl_CheckUser @"http://1.server4puman.sinaapp.com/User/checkUser.php"
#define kUrl_RegisterUser @"http://1.server4puman.sinaapp.com/User/registerUser.php"
#define kUrl_RegisterUserWithCode @"http://1.server4puman.sinaapp.com/User/registerUserWithCode.php"
#define kUrl_SendRigisterInvitation @"http://1.server4puman.sinaapp.com/User/sendInvitation.php"
#define kUrl_UpdateUserInfo @"http://1.server4puman.sinaapp.com/User/getUserInfo.php"
#define kUrl_VerifyUser @"http://1.server4puman.sinaapp.com/User/verifRequest.php"
#define kUrl_VerifyPhoneWithCode @"http://1.server4puman.sinaapp.com/User/verifWithCode.php"
#define kUrl_UpdateDiary @"http://1.server4puman.sinaapp.com/User/updateDiary.php"
#define kUrl_ResetPwd @"http://1.server4puman.sinaapp.com/User/resetPwdRequest.php"
#define kUrl_ChangePwd @"http://1.server4puman.sinaapp.com/User/changePwd.php"
#define kUrl_ChangeMailOrPhone @"http://1.server4puman.sinaapp.com/User/changeMailOrPhone.php"
#define kUrl_ConnectUser @"http://1.server4puman.sinaapp.com/User/connectUser.php"
#define kUrl_SetDeviceToken @"http://1.server4puman.sinaapp.com/User/setDeviceToken.php"
//user/baby
#define kUrl_SetBabyMeta @"http://1.server4puman.sinaapp.com/User/Baby/BabyMeta.php"
#define kUrl_SetBabyMetaSingle @"http://1.server4puman.sinaapp.com/User/Baby/BabyMetaSingle.php"
#define kUrl_UpdateVaccine @"http://1.server4puman.sinaapp.com/User/Baby/UpdateVaccine.php"
#define kUrl_UpdateBabyData @"http://1.server4puman.sinaapp.com/User/Baby/UpdateBabyData.php"
//task
#define kUrl_GetUserTask @"http://1.server4puman.sinaapp.com/Task/getUserTask.php"
#define kUrl_UploadUserTask @"http://1.server4puman.sinaapp.com/Task/uploadTask.php"
#define kUrl_GetCompletedTask @"http://1.server4puman.sinaapp.com/Task/getCompletedTask.php"
#define kUrl_UploadFile @"http://1.server4puman.sinaapp.com/AliOSS/upload.php"
//payback
#define kUrl_GetPayBack @"http://1.server4puman.sinaapp.com/Payback/getPayback.php"
#define kUrl_SubmitPayback @"http://1.server4puman.sinaapp.com/Payback/submitPayBack.php"
//feedback
#define kUrl_PostFeedback @"http://1.server4puman.sinaapp.com/feedBack.php"
//forum
#define kUrl_GetTopicReply  @"http://2.server4puman.sinaapp.com/forum/topic_replies"
#define kUrl_GetActiveTopics  @"http://2.server4puman.sinaapp.com/forum/topic_active"
#define kUrl_GetTopic  @"http://2.server4puman.sinaapp.com/forum/topic_no"
#define kUrl_UploadTopicReply  @"http://2.server4puman.sinaapp.com/forum/upload_reply"
#define kUrl_Headimg  @"http://2.server4puman.sinaapp.com/forum/headimg"

#define _puman_feedback_identifier_prefix @"_puman_"
#define _puman_feedbackFailed_identifier_prefix @"_pumanFail_"

#define kPumanPicUrl_Christmas_H    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%9C%A3%E8%AF%9E%E7%8C%AA%E6%A8%AA%E5%B1%8F.png"
#define kPumanPicUrl_Christmas_V    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%9C%A3%E8%AF%9E%E7%8C%AA%E7%AB%96%E5%B1%8F.png"
#define kPumanPicUrl_NewYear_H    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%85%83%E6%97%A6%E7%8C%AA%E6%A9%AB%E5%B1%8F.png"
#define kPumanPicUrl_NewYear_V    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%85%83%E6%97%A6%E7%8C%AA%E7%AB%96%E5%B1%8F.png"

#endif
