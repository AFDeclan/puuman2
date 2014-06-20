//
//  ShareVideo.h
//  puuman2
//
//  Created by Declan on 14-5-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareVideo : NSObject

@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSString * shareUrl;
@property (nonatomic, assign) NSInteger RID;

- (void)initWithData:(NSDictionary *)data;

//向服务器汇报状态，同步方法，5秒超时。
//确定分享
- (BOOL)toShare;
//丢弃
- (BOOL)toDiscard;

@end
