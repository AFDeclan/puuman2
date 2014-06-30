//
//  PuuamnShowView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-26.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "PuuamnShowView.h"
#import "UniverseConstant.h"
#import "UserInfo.h"

@implementation PuuamnShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        coin_num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 128, 24)];
        [coin_num setBackgroundColor:[UIColor clearColor]];
        [coin_num setTextAlignment:NSTextAlignmentRight];
        [coin_num setTextColor:[UIColor whiteColor]];
        [coin_num setFont:PMFont2];
        [self addSubview:coin_num];
        
        coin_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 128, 16)];
        [coin_label setBackgroundColor:[UIColor clearColor]];
        [coin_label setTextAlignment:NSTextAlignmentRight];
        [coin_label setTextColor:[UIColor whiteColor]];
        [coin_label setFont:PMFont4];
        [coin_label setText:@"金币"];
        [self addSubview:coin_label];
        num = 0;
    }
    return self;
}
- (void)updateData
{
    num += 0.1;
    [coin_num setText:[NSString stringWithFormat:@"%0.1f",[[UserInfo sharedUserInfo] UCorns] +num]];
    
    
}


@end
