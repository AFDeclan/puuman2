//
//  OtherUserInfo.h
//  用于获取其他用户的基本信息
//  puuman2
//
//  Created by Declan on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherUserInfo : NSObject

@property (assign, nonatomic) NSInteger UID;
@property (retain, readonly) NSString *headimgUrl;

+ (NSString *)headimgUrlForUid:(NSInteger)uid;

@end
