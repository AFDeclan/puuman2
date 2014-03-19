//
//  TopicSelectButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicSelectButton.h"
#import "ColorsAndFonts.h"

@implementation TopicSelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 128, 144)];
}

- (void)initialization
{
    [self setBackgroundColor:PMColor4];
    icon_left = [[UIImageView alloc] initWithFrame:CGRectMake(8, 58, 16, 28)];
    [icon_left setImage:[UIImage imageNamed:@"tri_gray_left.png"]];
    [self addSubview:icon_left];
    icon_right = [[UIImageView alloc] initWithFrame:CGRectMake(104, 58, 16, 28)];
    [icon_right setImage:[UIImage imageNamed:@"tri_gray_right.png"]];
    [self addSubview:icon_right];
    label_title = [[UILabel alloc] initWithFrame:CGRectMake(24, 58, 80, 28)];
    [label_title setBackgroundColor:[UIColor clearColor]];
    [label_title setFont:PMFont2];
    [label_title setTextColor:PMColor2];
    [label_title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_title];
    label_noti = [[UILabel alloc] initWithFrame:CGRectMake(24, 96, 80, 28)];
    [label_noti setBackgroundColor:[UIColor clearColor]];
    [label_noti setFont:PMFont2];
    [label_noti setTextColor:PMColor4];
    [label_noti setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_noti];
}
@end
