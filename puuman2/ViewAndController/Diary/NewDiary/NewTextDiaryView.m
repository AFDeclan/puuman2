//
//  NewTextDiaryView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewTextDiaryView.h"

@implementation NewTextDiaryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    [self setTitle:@"写日记" withIcon:[UIImage imageNamed:@"icon_text2_diary.png"]];
    
}

@end
