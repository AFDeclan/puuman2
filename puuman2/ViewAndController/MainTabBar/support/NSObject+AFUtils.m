//
//  NSObject+AFUtils.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NSObject+AFUtils.h"

@implementation NSObject (AFUtils)

- (void)performSelectorIfExists:(SEL)selector withArguments:(void **)arguments {
    [self performSelectorIfExists:selector andReturnTo:NULL withArguments:arguments];
}

- (void)performSelectorIfExists:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments {
    if([self respondsToSelector:selector]) {
        [self performSelector:selector andReturnTo:returnData withArguments:arguments];
    }
}

- (void)performSelector:(SEL)selector andReturnTo:(void *)returnData withArguments:(void **)arguments {
    NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:selector];
    
    NSUInteger argCount = [methodSignature numberOfArguments];
    
    for (int i=2; i < argCount; i++) {
        void *arg = arguments[i-2];
        [invocation setArgument:arg atIndex:i];
    }
    
    [invocation invokeWithTarget:self];
    if(returnData != NULL) {
        [invocation getReturnValue:returnData];
    }
}
@end
