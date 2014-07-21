//
//  PuumanShowView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-26.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "PuumanShowView.h"
#import "UniverseConstant.h"
#import "UserInfo.h"

@implementation PuumanShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       

    }
    return self;
}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
