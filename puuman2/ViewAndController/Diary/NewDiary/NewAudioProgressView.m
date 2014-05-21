//
//  NewAudioProgressView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewAudioProgressView.h"
#import "ColorsAndFonts.h"

@implementation NewAudioProgressView
@synthesize currentTime = _currentTime;
@synthesize maxTime = _maxTime;
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
    _maxTime = 90;
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*2);
    progress = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.height, self.frame.size.height)];
    [progress setBackgroundColor:PMColor6];
    [progress setAlpha:0.5];
    [self addSubview:progress];
    [self setScrollEnabled:NO];
    
    label_time = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    [label_time setText:@"00:00"];
    [label_time setFont:PMFont2];
    [label_time setTextColor:PMColor6];
    [label_time setBackgroundColor:[UIColor clearColor]];
    [label_time setTextAlignment:NSTextAlignmentCenter];
    [label_time setAlpha:0];
    [self addSubview:label_time];
}

- (void)setMaxTime:(NSTimeInterval)maxTime
{
    _maxTime = maxTime;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;    
    CGPoint pos = self.contentOffset;
    if (_maxTime == 0) {
        return;
    }
    pos.y = (_currentTime/_maxTime)*self.frame.size.height;
    self.contentOffset = pos;
    [self scrollRectToVisible:CGRectMake(0, pos.y, self.frame.size.width, self.frame.size.height) animated:YES];

    int min = ((int)currentTime)/60;
    int sec = ((int)currentTime)%60;
    if (sec<10) {
        [label_time setText:[NSString stringWithFormat:@"0%d:0%d", min, sec]];
    }else{
        [label_time setText:[NSString stringWithFormat:@"0%d:%d", min, sec]];
    }
    if (currentTime > 0) {
        if (label_time.alpha == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                label_time.alpha = 1;
            }];
        }
    } else {
        label_time.alpha = 0;
    }
}

@end
