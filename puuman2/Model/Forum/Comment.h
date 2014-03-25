//
//  Comment.h
//  puuman2
//
//  Created by Declan on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

//评论ID
@property (assign, nonatomic, readonly) NSInteger CID;
//回复RID
@property (assign, nonatomic, readonly) NSInteger RID;
//作者UID
@property (assign, nonatomic, readonly) NSInteger UID;
//评论内容
@property (retain, nonatomic, readonly) NSString * CContent;
//创建时间
@property (retain, nonatomic, readonly) NSDate * CCreateTime;

@property (retain, nonatomic) NSDictionary *data;

@end
