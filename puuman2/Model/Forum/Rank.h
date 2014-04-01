//
//  Rank.h
//  puuman2
//
//  Created by Declan on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rank : NSObject

@property (assign, nonatomic, readonly) NSInteger BID;
//点赞+被点赞数
@property (assign, nonatomic, readonly) NSInteger VCnt;
//评论+被评论数
@property (assign, nonatomic, readonly) NSInteger CCnt;

- (void)setData:(NSDictionary *)data;

@end
