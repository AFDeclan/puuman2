//
//  AFPopView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFPopView.h"
#import "UniverseConstant.h"


@implementation AFPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [bgView setAlpha:0.2];
    [self addSubview:bgView];
    _content = [[UIView alloc] init];
    [_content setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_content];
 
}

- (void)setVerticalFrame
{
    [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
    self.frame = CGRectMake(0, 0, 768, 1024);
    
}

- (void)setHorizontalFrame
{
    [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
    self.frame = CGRectMake(0, 0, 1024, 768);
    
}
- (void)dismiss
{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Vertical object:nil];
}
@end
