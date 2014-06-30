//
//  BabyView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyView.h"
#import "UserInfo.h"

@implementation BabyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        babyInfoView = [[BabyInfoBornView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }else{
        babyInfoView = [[BabyInfoBornView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    [self addSubview:babyInfoView];
}

- (void)loadDataInfo
{
    
}

@end
