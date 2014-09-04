//
//  AFButton.m
//  puman
//
//  Created by Declan on 13-12-18.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "AFButton.h"

@implementation AFButton
@synthesize  selected = _selected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
}


@end
