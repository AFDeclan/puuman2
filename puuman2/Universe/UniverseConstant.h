//
//  UniverseConstant.h
//  puman
//
//  Created by 胡杨林 on 6/25/13.
//  Copyright (c) 2013 创始人团队. All rights reserved.
//

#import "ColorsAndFonts.h"
#import "Urls.h"
#import "Notifications.h"
#import "UserdefaultKeys.h"
#import "UmengDefine.h"
#import "FileManager.h"
#import "ErrorLog.h"
#import "AFNetwork.h"
#import "Device.h"

#ifndef puman_UniverseConstant_h
#define puman_UniverseConstant_h

#pragma mark - 常用代码

#define MyUserDefaults  [NSUserDefaults standardUserDefaults]
#define MyNotiCenter    [NSNotificationCenter defaultCenter]
#define PostNotification(notiName, notiObj) [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:notiObj]
#define SetViewLeftUp(view, x, y) view.center = CGPointMake(x+view.frame.size.width/2, y+view.frame.size.height/2)

#pragma mark - 应用信息
#define APPID @"691858998"
#define APPINFO @"APPINFO"
#define APPLOCALE @"CST"

#define _puman_AboutUS @"    扑满日记是深圳点石互动科技有限公司针对于中国新妈妈设计开发的一款iPad应用，应用融合了早期育儿过程中必不可少的'成长日记建立'与'商品垂直索引'两大模块，提供更多更精准的育儿讯息和直观简单的购买功能。\n    制作团队开创了新的返利模式，给用户带去更多的实惠。扑满日记还针对不同阶段的用户提供营养，保健，健康诊断，发育参考标准等实用讯息，让新手爸妈不在迷茫。\n    扑满日记，让您与小宝宝的互动变得更简单~ Puu, Puu~"

#pragma mark - 商品品类
#define kWareTypeCnt 15


#pragma  mark - 图片类型定义
#define JPG                @"jpg"
#define JPEG               @"jpeg"
#define PNG                @"png"
#define GIF                @"gif"

#pragma mark - 购物车相关定义
#define CartDone_Ware_List @"CartDone_Ware_List"
#define CartDone_Time_List @"CartDone_Time_List"
#define CartUndo_Ware_List @"CartUndo_Ware_List"
#define CartUndo_Time_List @"CartUndo_Time_List"

#define CartDone    @"_puman_CartDone"
#define CartUndo    @"_puman_CartUndo"

#define Cart_PutIntoCart @"Cart_PutIntoCart"
#define Cart_Done_Batch @"Cart_Done_Batch"





#define MODE_OFFLINE  @"_puman_offline"
#define MODE_ONLINE   @"_puman_online"



#pragma mark - 新版本相关参数
#define _puman_new_version_remindInterval 10 // 提醒用户有新版本的间隔(以秒为单位)
#define _puman_new_version_exist @"_puman_new_version_exist"
#define _puman_new_version_id @"_puman_new_version_id"
#define _puman_new_version_lastcheck @"_puman_new_version_lastcheck"
#define _puman_new_version_trackViewUrl @"_puman_new_version_trackViewUrl"



#pragma mark - 动画持续时间
#define ShowInterval 0.5    // DimView进场动画


#pragma mark - 获取ranklist时的传入参数
#define RANK_WSale @"WSale"
#define RANK_WRate @"WRate"
#define RANK_WPriceLB @"WPriceLB"
#define RANK_WShopCnt @"WShopCnt"
#define RANK_DEFAULT @"WID"
#define RANK_ASC @"Asc"
#define RANK_DESC @"Desc"

#pragma mark - 商品搜索字段
#define SEARCH_LOCALIZE_STRING  @"searchStr"
#define SEARCH_LOCALIZE_BATCH  @"batch"
#define SEARCH_LOCALIZE_TAG 1

#pragma mark - AlertView Tag
#define _puman_alertView_normal 0
#define _puman_alertView_networkerror 1
#define _puman_alertView_contactUS 2
#define _puman_alertView_feedbackSuccess 3

#pragma mark - 数据解析字段
#define _task_Bonus         @"TBonus"
#define _task_CreateTime    @"TCreateTime"
#define _task_Description   @"TDescription"
#define _task_ID            @"TID"
#define _task_Name          @"TName"
#define _task_Status        @"TStatus"
#define _task_TaskType      @"TType"
#define _task_UTCreateTime  @"UTCreateTime"
#define _task_UTID          @"UTID"
#define _task_UTStatus      @"UTStatus"
#define _task_IsWithDrew    @"IsWithDraw"

// 扑满声音播放类
#define _audio_Puman    @"PumanPuman"




#pragma mark - Tutorial
#define tutorial_diaryPage_showed           @"DiaryPageTutorialShowed"
#define tutorial_taskPage_showed            @"TaskPageTutorialShowed"
#define tutorial_pumanFirstPage_showed      @"PumanFirstPageTutorialShowed"


#define sampleTextDiary1_fileName           @"sampleTextDiary1.txt"
#define first_enter_date                    @"FirstEnterDate"

#define default_ware_image @"shopping_default.png"
#define default_portrait_image @"btn_babyinfo3_diary.png"
#define tasks_wait_for_upload       @"tasksWaitForUpload"

#pragma mark - UserInfo
#define userInfoKey                 @"userInfo"
#define userInfo_uid                @"userID"
#define userInfo_bid                @"userBID"
#define userInfo_identity           @"userIdentity"
#define userInfo_mail               @"usermailAddr"
#define userInfo_phone              @"userPhoneNum"
#define userInfo_pumanQuan          @"userPuman"
#define userInfo_pumanUsed          @"userPumanUsed"
#define userInfo_meta               @"userMeta"
#define userInfo_pwdMd5             @"userPwdMd5"
#define userInfo_createTime         @"userCreateTime"

#define uMetaKey                    @"_puman_UserMeta"
#define uMeta_nickName              @"Baby_NickName"
#define uMeta_whetherBirth          @"Baby_WhetherBirth"
#define uMeta_birthDate             @"Baby_BirthDate"
#define uMeta_gender                @"Baby_Gender"
#define uMeta_portraitUrl           @"PortraitUrl"
#define uMeta_alipayAccount         @"AliPayAccount"
#define uMeta_pendingTaskCount      @"PendingTaskCount"
#define uMeta_processedTaskCount    @"ProcessedTaskCount"
#define uMeta_InviteStateKey        @"InviteState"
#define uMeta_InvitedKey            @"Invited"
#define uMeta_PBLEFT    @"_puman_PayBackLeft"
#define uMeta_PBLastCheck   @"_puman_PayBack_LastCheck"

//#pragma mark - 新手任务相关
//#define task1_finished              @"task1_finished"
//#define task2_finished              @"task2_finished"
//#define task3_finished              @"task3_finished"
//#define task4_finished              @"task4_finished"
//#define task5_finished              @"task5_finished"

#pragma mark - ASIHTTPRequest userInfo 中的 key

#define kHttpRequest_WareBatch      @"WareBatch"
#define kHttpRequest_WareType       @"WareType"
#define kHttpRequest_WareRankMode   @"WareRankMode"




#endif
