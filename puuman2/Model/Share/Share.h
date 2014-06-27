//
//  Share.h
//  puuman model
//
//  Created by Declan on 14-6-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Diary.h"

@interface Share : NSObject

+ (NSInteger)reqRet;    //请求失败时获取结果码，以确认原因。

//分享日记
+ (NSString *)shareUrlForDiary:(Diary *)diary;

//分享扑满金库
+ (NSString *)shareUrlForPuuman;

//分享身高体重
+ (NSString *)shareUrlForMeasure;

@end
