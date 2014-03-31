//
//  Member.h
//  puuman2
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Member : NSObject


@property (assign, nonatomic, readonly) NSInteger GID;
@property (assign, nonatomic, readonly) NSInteger BID;
@property (retain, nonatomic, readonly) NSArray * UIDs;
@property (retain, nonatomic, readonly) NSDate * JoinTime;
//base info:
@property (retain, nonatomic, readonly) NSString * BabyNick;
@property (assign, nonatomic, readonly) BOOL BabyIsBoy;
@property (retain, nonatomic, readonly) NSDate * BabyBirth;
@property (retain, nonatomic, readonly) NSString * BabyPortraitUrl;
//detail info:

@property (retain, nonatomic) NSDictionary * data;

@end
