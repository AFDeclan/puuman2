//
//  Award.h
//  puuman2
//
//  Created by Declan on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Award : NSObject

@property (assign, nonatomic, readonly) NSInteger ALevel;
@property (retain, nonatomic, readonly) NSString * AName;
@property (retain, nonatomic, readonly) NSString * AImgUrl;
@property (retain, nonatomic, readonly) NSDate * ADueTime;

- (void)setData:(NSDictionary *)data;

@end
