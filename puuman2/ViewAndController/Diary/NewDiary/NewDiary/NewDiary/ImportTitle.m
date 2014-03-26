//
//  ImportTitle.m
//  puman
//
//  Created by Ra.（祁文龙） on 14-2-21.
//  Copyright (c) 2014年 创始人团队. All rights reserved.
//

#import "ImportTitle.h"
#import "ColorsAndFonts.h"

@implementation ImportTitle

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        [self setTextColor:Color_bl1];
        [self setFont:DefaultFont_Small2];
        [self setBackground:[UIImage imageNamed:@"block_input_login_diary.png"]];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 8);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 8);
}

@end
