//
//  Device.h
//  puman
//
//  Created by Declan on 13-12-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#ifndef puman_Device_h
#define puman_Device_h


#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width


#endif
