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
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:bgView];
    [bgView setBackgroundColor:PMColor4];
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
    label_noti = [[UILabel alloc] initWithFrame:CGRectMake(24, 112, 80, 28)];
    [label_noti setBackgroundColor:[UIColor clearColor]];
    [label_noti setFont:PMFont2];
    [label_noti setTextColor:[UIColor whiteColor]];
    [label_noti setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_noti];
}

- (void)setDirection:(BOOL)isRight
{
    if (isRight) {
        [icon_left setAlpha:0];
        [icon_right setAlpha:1];
    }else{
        [icon_left setAlpha:1];
        [icon_right setAlpha:0];
    }
}

- (void)setTitleName:(NSString *)title;
{
    [label_title setText:title];
    
}

- (void)setNoti:(NSString *)noti
{
    [label_noti setText:noti];
}

- (void)setVerticalFrame
{
    [bgView setAlpha:0.5];
}

- (void)setHorizontalFrame
{
    [bgView setAlpha:1];
}
@end
