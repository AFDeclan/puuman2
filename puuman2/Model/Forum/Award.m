//
//  Award.m
//  puuman2
//
//  Created by Declan on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "Award.h"

@implementation Award

- (void)setData:(NSDictionary *)data
{
    _AImgUrl = [data valueForKey:@"AImgUrl"];
    _ALevel = [[data valueForKey:@"ALevel"] integerValue];
    _AName = [data valueForKey:@"AName"];
}

@end
