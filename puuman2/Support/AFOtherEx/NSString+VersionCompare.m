//
//  NSString+VersionCompare.m
//  puman
//
//  Created by Declan on 14-1-22.
//  Copyright (c) 2014年 创始人团队. All rights reserved.
//

#import "NSString+VersionCompare.h"

@implementation NSString (VersionCompare)

- (NSComparisonResult)compareVersion:(NSString *)otherVersion
{
    NSArray *versionNum1 = [self componentsSeparatedByString:@"."];
    NSArray *versionNum2 = [otherVersion componentsSeparatedByString:@"."];
    for (int i=0; i<MIN(versionNum1.count, versionNum2.count); i++)
    {
        NSInteger num1 = [[versionNum1 objectAtIndex:i] integerValue];
        NSInteger num2 = [[versionNum2 objectAtIndex:i] integerValue];
        if (num1 < num2) return NSOrderedAscending;
        else if (num1 > num2) return NSOrderedDescending;
    }
    if (versionNum1.count < versionNum2.count) return NSOrderedAscending;
    else if (versionNum1.count > versionNum2.count) return NSOrderedDescending;
    return NSOrderedSame;
}

- (BOOL)earlierThenVersion:(NSString *)otherVersion
{
    return [self compareVersion:otherVersion] == NSOrderedAscending;
}

@end
