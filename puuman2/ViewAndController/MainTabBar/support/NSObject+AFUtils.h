//
//  NSObject+AFUtils.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AFUtils)

- (void)performSelectorIfExists:(SEL)selector withArguments:(void **)arguments;
@end
