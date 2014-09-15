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
#define AF_DEBUG

#ifdef AF_DEBUG
//forum
#define kUrl_GetTopicReply  @"http://server.puuman.cn/index.php/server/forumTest/topic_replies"
#define kUrl_GetMyReply  @"http://server.puuman.cn/index.php/server/forumTest/my_replies"
#define kUrl_GetActiveTopic  @"http://server.puuman.cn/index.php/server/forumTest/topic_active"
#define kUrl_GetVotingTopic  @"http://server.puuman.cn/index.php/server/forumTest/topics_voting"
#define kUrl_GetTopic  @"http://server.puuman.cn/index.php/server/forumTest/topic_no"
#define kUrl_GetAwardRank  @"http://server.puuman.cn/index.php/server/forumTest/rank_award"
#define kUrl_UploadTopic  @"http://server.puuman.cn/index.php/server/forumTest/upload_topic"
#define kUrl_VoteTopic  @"http://server.puuman.cn/index.php/server/forumTest/vote_topic"
#define kUrl_UploadTopicReply  @"http://server.puuman.cn/index.php/server/forumTest/upload_reply"
#define kUrl_Headimg  @"http://server.puuman.cn/index.php/server/forumTest/headimg"
#define kUrl_VoteReply @"http://server.puuman.cn/index.php/server/forumTest/vote_reply"
#define kUrl_GetReplyComment @"http://server.puuman.cn/index.php/server/forumTest/reply_comments"
#define kUrl_UploadReplyComment @"http://server.puuman.cn/index.php/server/forumTest/reply_comments_upload"
//group
#define kUrl_GetGroupData @"http://server.puuman.cn/index.php/server/forumTest/group_data"
#define kUrl_UploadAction @"http://server.puuman.cn/index.php/server/forumTest/upload_action"
#define kUrl_UpdateAction @"http://server.puuman.cn/index.php/server/forumTest/update_action"
#define kUrl_GetMember @"http://server.puuman.cn/index.php/server/forumTest/get_member"
#define kUrl_ShopEmptyH @"http://www.puuman.cn/index.php/shop/show/1"
#define kUrl_ShopEmptyV @"http://www.puuman.cn/index.php/shop/show/2"

#else

//forum
#define kUrl_GetTopicReply  @"http://server.puuman.cn/index.php/server/forum/topic_replies"
#define kUrl_GetMyReply  @"http://server.puuman.cn/index.php/server/forum/my_replies"
#define kUrl_GetActiveTopic  @"http://server.puuman.cn/index.php/server/forum/topic_active"
#define kUrl_GetVotingTopic  @"http://server.puuman.cn/index.php/server/forum/topics_voting"
#define kUrl_GetTopic  @"http://server.puuman.cn/index.php/server/forum/topic_no"
#define kUrl_GetAwardRank  @"http://server.puuman.cn/index.php/server/forum/rank_award"
#define kUrl_UploadTopic  @"http://server.puuman.cn/index.php/server/forum/upload_topic"
#define kUrl_VoteTopic  @"http://server.puuman.cn/index.php/server/forum/vote_topic"
#define kUrl_UploadTopicReply  @"http://server.puuman.cn/index.php/server/forum/upload_reply"
#define kUrl_Headimg  @"http://server.puuman.cn/index.php/server/forum/headimg"
#define kUrl_VoteReply @"http://server.puuman.cn/index.php/server/forum/vote_reply"
#define kUrl_GetReplyComment @"http://server.puuman.cn/index.php/server/forum/reply_comments"
#define kUrl_UploadReplyComment @"http://server.puuman.cn/index.php/server/forum/reply_comments_upload"
//group
#define kUrl_GetGroupData @"http://server.puuman.cn/index.php/server/forum/group_data"
#define kUrl_UploadAction @"http://server.puuman.cn/index.php/server/forum/upload_action"
#define kUrl_UpdateAction @"http://server.puuman.cn/index.php/server/forum/update_action"
#define kUrl_GetMember @"http://server.puuman.cn/index.php/server/forum/get_member"
#define kUrl_ShopEmptyH @"http://www.puuman.cn/index.php/shop/show/1"
#define kUrl_ShopEmptyV @"http://www.puuman.cn/index.php/shop/show/2"
#endif

//share
#define kUrl_VideoShare @"http://server.puuman.cn/index.php/server/makeShare/share_video"
#define kUrl_VideoDiscard @"http://server.puuman.cn/index.php/server/makeShare/discard_video"
#define kUrl_ShareDiary @"http://server.puuman.cn/index.php/server/makeShare/share_diary"
#define kUrl_SharePuuman @"http://server.puuman.cn/index.php/server/makeShare/share_puuman"
#define kUrl_ShareMeasure @"http://server.puuman.cn/index.php/server/makeShare/share_measure"

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
#define kUrl_SetUserMeta  @"http://server.puuman.cn/index.php/server/user/set_meta"
#define kUrl_CheckUser @"http://server.puuman.cn/index.php/server/user/login"
#define kUrl_RegisterUser @"http://server.puuman.cn/index.php/server/user/register"
#define kUrl_RegisterUserWithCode @"http://server.puuman.cn/index.php/server/user/register_with_code"
#define kUrl_SendRigisterInvitation @"http://server.puuman.cn/index.php/server/user/send_invitation"
#define kUrl_UpdateUserInfo @"http://server.puuman.cn/index.php/server/user/get_user_info"
#define kUrl_VerifyUser @"http://server.puuman.cn/index.php/server/user/send_verif"
#define kUrl_VerifyPhoneWithCode @"http://server.puuman.cn/index.php/server/user/verify_phone"
#define kUrl_ResetPwd @"http://server.puuman.cn/index.php/server/user/reset_pwd"
#define kUrl_ChangePwd @"http://server.puuman.cn/index.php/server/user/change_pwd"
#define kUrl_ChangeMailOrPhone @"http://server.puuman.cn/index.php/server/user/change_account"
#define kUrl_ConnectUser @"http://server.puuman.cn/index.php/server/user/connect"
#define kUrl_SetDeviceToken @"http://server.puuman.cn/index.php/server/user/set_device_token/iPad"
//user/baby
#define kUrl_UpdateVaccine @"http://server.puuman.cn/index.php/server/baby/update_vaccine"
#define kUrl_UpdateBabyData @"http://server.puuman.cn/index.php/server/baby/update_data"
#define kUrl_SetBabyInfo @"http://server.puuman.cn/index.php/server/baby/set_baby_info"
//diary
#define kUrl_UpdateDiary @"http://server.puuman.cn/index.php/server/diary/update"
#define kUrl_UploadUserTask @"http://server.puuman.cn/index.php/server/diary/upload"
#define kUrl_UploadUserTaskInfo @"http://server.puuman.cn/index.php/server/diary/uploadInfo"
#define kUrl_GetUserTask    @"http://server.puuman.cn/index.php/server/diary/get_task"
#define kUrl_RewardDiary @"http://server.puuman.cn/index.php/server/diary/reward"

#define kUrl_GetCompletedTask @"http://1.server4puman.sinaapp.com/Task/getCompletedTask.php"
//payback
#define kUrl_GetPayBack @"http://1.server4puman.sinaapp.com/Payback/getPayback.php"
#define kUrl_SubmitPayback @"http://1.server4puman.sinaapp.com/Payback/submitPayBack.php"
//feedback
#define kUrl_PostFeedback @"http://server.puuman.cn/index.php/server/other/feedback"

//upload
#define kUrl_UploadToOSS @"http://server.puuman.cn/index.php/server/upload_oss"

#define _puman_feedback_identifier_prefix @"_puman_"
#define _puman_feedbackFailed_identifier_prefix @"_pumanFail_"
#define kPumanPicUrl_Christmas_H    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%9C%A3%E8%AF%9E%E7%8C%AA%E6%A8%AA%E5%B1%8F.png"
#define kPumanPicUrl_Christmas_V    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%9C%A3%E8%AF%9E%E7%8C%AA%E7%AB%96%E5%B1%8F.png"
#define kPumanPicUrl_NewYear_H    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%85%83%E6%97%A6%E7%8C%AA%E6%A9%AB%E5%B1%8F.png"
#define kPumanPicUrl_NewYear_V    @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E6%89%91%E6%BB%A1%E9%A1%B5%E9%9D%A2%E7%8C%AA%E5%9B%BE%E7%89%87/%E5%85%83%E6%97%A6%E7%8C%AA%E7%AB%96%E5%B1%8F.png"

#endif
