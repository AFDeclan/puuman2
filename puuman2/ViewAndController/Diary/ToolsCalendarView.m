//
//  ToolsCalendarView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsCalendarView.h"
#import "NSDate+Compute.h"
#import "UserInfo.h"

@implementation ToolsCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setContentView];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setContentView
{
    
}

- (void)refreshInfo
{
    

}




+(float)heightWithTheIndex:(NSInteger)index
{
    return 280 ;
}

@end
