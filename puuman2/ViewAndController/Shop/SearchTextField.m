//
//  SearchTextField.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SearchTextField.h"
#import "ColorsAndFonts.h"

@implementation SearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTextColor:PMColor3];
        [self setFont:PMFont3];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 14);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 14);
}


@end
