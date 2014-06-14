//
//  Share.h
//  puuman2
//
//  Created by Declan on 14-6-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Diary.h"

@interface Share : NSObject

+ (NSInteger)reqRet;

+ (NSString *)shareUrlForDiary:(Diary *)diary;

@end
