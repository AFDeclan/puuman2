//
//  ExpandableButton.m
//  puman
//
//  Created by 祁文龙 on 13-12-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "ExpandableButton.h"
#import "ColorsAndFonts.h"

@implementation ExpandableButton


- (id)init
{
    if (self = [super init])
    {
     
        line = [[UIImageView alloc] init];
        [line setBackgroundColor:PMColor3];
        [line setAlpha:0.5];
        [self addSubview:line];

        titleLabel =[[UILabel alloc] init];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setFont:PMFont2];
        [titleLabel setTextColor:PMColor1];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleLabel];
        icon = [[UIImageView alloc] init];
        [icon setImage:[UIImage imageNamed:@"triangle_task_diary.png"]];
        [self addSubview:icon];
        [self setBackgroundColor:PMColor5];

    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [titleLabel setFrame:CGRectMake(12, 0, frame.size.width - 24, frame.size.height)];
    [icon setFrame:CGRectMake( frame.size.width-20-12, (frame.size.height-12)/2, 20, 12)];
    [line setFrame:CGRectMake(0, 0, frame.size.width, 1)];
}
- (void)setTitle:(NSString *)title
{
    [titleLabel setText:title];
}

- (void)setIsExpand:(BOOL)isExpand
{
   
        if (isExpand) {
            icon.transform=CGAffineTransformMakeRotation(0);

        }else{
            icon.transform=CGAffineTransformMakeRotation(M_PI);

        }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
