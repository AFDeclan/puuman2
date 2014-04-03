//
//  main.m
//  puuman2
//
//  Created by Declan on 14-2-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        @try{
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }@catch (NSException* e) {
            [ErrorLog errorLog:e.debugDescription fromFile:@"main.m" error:nil];
        }
    }
}
