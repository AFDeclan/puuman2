//
//  ToolsDynamicView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsDynamicView.h"
#import "UniverseConstant.h"

@implementation ToolsDynamicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];

    }
    return self;
}

- (void)initialization
{
    self.layer.masksToBounds = YES;
    [super initialization];
    [self setContentView];

}

- (void)setContentView
{
    [content setFrame:CGRectMake(0, 0, 240, 288+64)];


    joinView = [[JoinView alloc] initWithFrame:CGRectMake(0, 0,240,288+64)];
    [content addSubview:joinView];
    [joinView refreshStaus];


}

-(void)keyBoardHidden{
    
    [joinView resign];
    
}

- (void)refreshStatus
{
    [joinView refreshStaus];

}


- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}


+(float)heightWithTheIndex:(NSInteger)index
{
    return 288+64;
}

@end
