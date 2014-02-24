//
//  UILabel+AdjustSize.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-4.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "UILabel+AdjustSize.h"

@implementation UILabel (AdjustSize)

- (void)adjustSize
{
    NSString *content = self.text;
    CGSize fitSize = [content sizeWithFont:self.font];
    CGRect frame = self.frame;
    frame.size = fitSize;
    [self setFrame:frame];
}

- (void)adjustSizeFixCenter
{
    NSString *content = self.text;
    CGSize fitSize = [content sizeWithFont:self.font];
    CGRect frame = self.frame;
    frame.size = fitSize;
    [self setBounds:frame];
}

- (void)adjustSizeFixLeftUpWithWidth:(CGFloat)width
{
    NSString *content = self.text;
    CGSize fitSize = [content sizeWithFont:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    CGRect frame = self.frame;
    frame.size = fitSize;
    [self setFrame:frame];
}
@end
