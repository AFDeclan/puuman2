//
//  BabyInfo.h
//  puuman2
//
//  Created by Declan on 14-6-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileUploader.h"
#import "PumanRequest.h"

@protocol BabyInfoDelegate <NSObject>

- (void)portraitUploadFinish:(BOOL)suc;
- (void)infoUploadFinish:(BOOL)suc;

@end

@interface BabyInfo : NSObject <UploaderDelegate, AFRequestDelegate>
{
    NSMutableSet * _changedKeys;
}

@property (assign, nonatomic) NSInteger BID;
@property (retain, nonatomic) NSString * Nickname;
@property (assign, nonatomic) BOOL Gender;
@property (assign, nonatomic) BOOL WhetherBirth;
@property (retain, nonatomic) NSDate * Birthday;
@property (retain, nonatomic) NSString * PortraitUrl;

@property (assign, nonatomic) NSObject<BabyInfoDelegate> * delegate;

- (void)setWithDic:(NSDictionary *)dic;
- (NSDictionary *)getDic;

- (void)uploadInfo;
- (BOOL)uploadInfoSync;

@end
