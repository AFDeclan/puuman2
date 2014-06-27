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
#import "ErrorLog.h"
#import "AFNetwork.h"
#import "Device.h"
#import "AFUICode.h"

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

#pragma mark - Tutorial
#define tutorial_diaryPage_showed           @"DiaryPageTutorialShowed"
#define tutorial_taskPage_showed            @"TaskPageTutorialShowed"
#define tutorial_pumanFirstPage_showed      @"PumanFirstPageTutorialShowed"


#define sampleTextDiary1_fileName           @"sampleTextDiary1.txt"
#define first_enter_date                    @"FirstEnterDate"

#define default_ware_image @"shopping_default.png"
#define default_portrait_image @"btn_babyinfo3_diary.png"
#define tasks_wait_for_upload       @"tasksWaitForUpload"

#endif
