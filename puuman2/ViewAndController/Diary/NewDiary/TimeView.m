//
//  TimeView.m
//  puman
//
//  Created by Ra.（祁文龙） on 14-2-11.
//  Copyright (c) 2014年 创始人团队. All rights reserved.
//

#import "TimeView.h"
#import "ColorsAndFonts.h"

@implementation TimeView

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
    videoTime = 0;
    UILabel *flag = [[UILabel alloc] initWithFrame:CGRectMake(32, 24, 16, 32)];
    [flag setText:@":"];
    [flag setTextColor:PMColor6];
    [flag setFont:PMFont2];
    [flag setTextAlignment:NSTextAlignmentCenter];
    [flag setBackgroundColor:[UIColor clearColor]];
    [self addSubview:flag];
    
    minuteLabel= [[UILabel alloc] initWithFrame:CGRectMake(12, 25, 32, 32)];
    [minuteLabel setText:@"00"];
    [minuteLabel setTextColor:PMColor6];
    [minuteLabel setFont:PMFont2];
    [minuteLabel setTextAlignment:NSTextAlignmentCenter];
    [minuteLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:minuteLabel];
    
    secondLabel= [[UILabel alloc] initWithFrame:CGRectMake(36, 25, 32, 32)];
    [secondLabel setText:@"00"];
    [secondLabel setTextColor:PMColor6];
    [secondLabel setFont:PMFont2];
    [secondLabel setTextAlignment:NSTextAlignmentCenter];
    [secondLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:secondLabel];

}
- (void)showTimeWithSecond:(NSInteger)time
{
   
    int min = time/60;
    int sec = time%60;
    if (min<10) {
        [minuteLabel setText:[NSString stringWithFormat:@"0%d",min]];
    }else{
        [minuteLabel setText:[NSString stringWithFormat:@"%d",min]];
    }
    if (sec<10) {
        [secondLabel setText:[NSString stringWithFormat:@"0%d",sec]];
    }else{
        [secondLabel setText:[NSString stringWithFormat:@"%d",sec]];
    }
}

- (void)startRecord;
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
}

- (void)stopRecord
{
    [timer invalidate];
    timer = nil;
}

- (void)refreshTime
{
    videoTime ++;
    [self showTimeWithSecond:videoTime];
}


@end
