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
        [self setContentView];
        self.layer.masksToBounds = YES;

    }
    return self;
}

- (void)setContentView
{
    self.backgroundColor = PMColor4;
    joinView = [[JoinView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:joinView];
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
    return 192;
}

@end
