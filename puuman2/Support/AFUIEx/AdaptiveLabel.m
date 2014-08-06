//
//  AdaptiveLabel.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AdaptiveLabel.h"

@implementation AdaptiveLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       [self setNumberOfLines:0];
        self.lineBreakMode = UILineBreakModeWordWrap;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setTitle:(NSString *)title withMaxWidth:(float)maxWidth
{
    self.text = title;
    CGSize labelsize = [title sizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelsize.width, labelsize.height);

}



@end
