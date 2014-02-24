//
//  UserNameCheck.h
//  PuumanForPhone
//
//  Created by Declan on 14-1-13.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserNameCheck : NSObject

+ (BOOL)validateMobile:(NSString *)mobileNum;
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validateUserName:(NSString *)userName;

@end
