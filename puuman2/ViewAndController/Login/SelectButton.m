//
//  YearButton.m
//  puman
//
//  Created by 祁文龙 on 13-10-29.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "SelectButton.h"
#import "ColorsAndFonts.h"

@implementation SelectButton
@synthesize  myTag;
@synthesize label;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setTextColor:PMColor1];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:PMFont2];
        [self addSubview:label];
        
    }
    return self;
}



@end
