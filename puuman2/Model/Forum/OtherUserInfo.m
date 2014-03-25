//
//  OtherUserInfo.m
//  puuman2
//
//  Created by Declan on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "OtherUserInfo.h"
#import "UniverseConstant.h"

@implementation OtherUserInfo

@synthesize UID = _UID;
@synthesize headimgUrl = _headimgUrl;

- (void)setUID:(NSInteger)UID
{
    _UID = UID;
    _headimgUrl = [NSString stringWithFormat:@"%@?authCode=%@&UID=%d", kUrl_Headimg, [MobClick getConfigParams:umeng_onlineConfig_authKey], _UID];
}

+ (NSString *)headimgUrlForUid:(NSInteger)uid
{
    return [NSString stringWithFormat:@"%@?authCode=%@&UID=%d", kUrl_Headimg, [MobClick getConfigParams:umeng_onlineConfig_authKey], uid];
}

@end
