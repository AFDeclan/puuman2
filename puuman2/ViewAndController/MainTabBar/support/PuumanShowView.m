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
        coin_num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 128, 32)];
        [coin_num setBackgroundColor:[UIColor clearColor]];
        [coin_num setTextAlignment:NSTextAlignmentRight];
        [coin_num setTextColor:[UIColor whiteColor]];
        [coin_num setFont:PMFont1];
        [self addSubview:coin_num];
        
        coin_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 128, 24)];
        [coin_label setBackgroundColor:[UIColor clearColor]];
        [coin_label setTextAlignment:NSTextAlignmentRight];
        [coin_label setTextColor:[UIColor whiteColor]];
        [coin_label setFont:PMFont2];
        [coin_label setText:@"金币"];
        [self addSubview:coin_label];
        [MyNotiCenter addObserver:self selector:@selector(updateData) name:Noti_UpdatePuumanShow object:nil];

    }
    return self;
}
- (void)updateData
{
    [coin_num setText:[NSString stringWithFormat:@"%0.1f",[[UserInfo sharedUserInfo] UCorns]]];
    
    
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
