//
//  NSString+VersionCompare.h
//
//
//  Created by Declan on 14-1-22.
//  Copyright (c) 2014年 创始人团队. All rights reserved.
//
//  用于比较版本号的先后

#import <Foundation/Foundation.h>

@interface NSString (VersionCompare)

- (NSComparisonResult)compareVersion:(NSString *)otherVersion;

- (BOOL)earlierThenVersion:(NSString *)otherVersion;

@end
