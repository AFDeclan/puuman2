//
//  BindAddButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BindAddButton.h"

@implementation BindAddButton
@synthesize empty =_empty;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bg_black = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bg_black setBackgroundColor:[UIColor blackColor]];
        [self addSubview:bg_black];
        add =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [add setText:@"添加"];
        [add setTextAlignment:NSTextAlignmentCenter];
        [add setBackgroundColor:[UIColor clearColor]];
        [add setTextColor:[UIColor whiteColor]];
        [self addSubview:add];
    }
    return self;
}

- (void)showAdd
{
    [bg_black setAlpha:0.5];
    [add setAlpha:1];
}

- (void)hiddenAdd
{
    [bg_black setAlpha:0];
    [add setAlpha:0];

}



@end
