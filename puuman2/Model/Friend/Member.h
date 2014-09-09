//
//  Member.h
//  puuman model
//
//  Created by Declan on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BabyInfo.h"


@interface Member : NSObject


@property (assign, nonatomic, readonly) NSInteger GID;
@property (assign, nonatomic, readonly) NSInteger BID;
@property (retain, nonatomic, readonly) NSArray * UIDs;
@property (retain, nonatomic, readonly) NSDate * JoinTime;
//base info:
@property (retain, nonatomic, readonly) BabyInfo * babyInfo;
@property (assign, nonatomic, readonly) CGFloat BabyHeight;
@property (assign, nonatomic, readonly) CGFloat BabyWeight;
@property (assign, nonatomic, readonly) CGFloat BabyPuuman;
//detail info:

@property (retain, nonatomic) NSDictionary * data;

- (BOOL)belongsTo:(NSInteger)uid;

@end
