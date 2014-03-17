//
//  ReSendButton.m
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-9.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ReSendButton.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
@implementation ReSendButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         //Initialization code
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    [self setBackgroundColor:PMColor6];
    count = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    [count setTextAlignment:NSTextAlignmentCenter];
    [count setFont:PMFont2];
    [count setTextColor:[UIColor whiteColor]];
    [count setBackgroundColor:[UIColor clearColor]];
    [self addSubview:count];
   
    
    if ([UserInfo sharedUserInfo].timeToResendVerifyMsg == 0) {
        [self setEnabled:YES];
        [mask setAlpha:0];
        [count setAlpha:0];
    }else{
        [self setEnabled:NO];
        [mask setAlpha:1];
        [count setAlpha:1];
        [count setText:[NSString stringWithFormat:@"%d",[UserInfo sharedUserInfo].timeToResendVerifyMsg]];
        aniTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
}
- (void)countDown
{
    [count setText:[NSString stringWithFormat:@"%d",[UserInfo sharedUserInfo].timeToResendVerifyMsg]];
    if ([UserInfo sharedUserInfo].timeToResendVerifyMsg == 0) {
        [self setEnabled:YES];
        [mask setAlpha:0];
        [count setAlpha:0];
    }
}

- (void)startSend
{
   
    [self setEnabled:NO];
    [mask setAlpha:1];
    [count setAlpha:1];
    [count setText:[NSString stringWithFormat:@"%d",[UserInfo sharedUserInfo].timeToResendVerifyMsg]];
    aniTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}


@end
