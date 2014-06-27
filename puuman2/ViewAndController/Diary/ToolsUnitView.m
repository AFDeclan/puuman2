//
//  ToolsUnitView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsUnitView.h"
#import "UniverseConstant.h"
#import "ToolsCalendarView.h"
#import "ToolsCoinView.h"
#import "ToolsDynamicView.h"

@implementation ToolsUnitView
@synthesize delegate = _delegate;
@synthesize flagNum = _flagNum;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [self setBackgroundColor:PMColor4];
    }
    return self;
}

- (void)initialization
{
    settingBtn = [[ToolsSelectedButton alloc] init];
    [settingBtn addTarget:self action:@selector(foldOrUnFold) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
    content = [[UIView alloc] initWithFrame:CGRectMake(0, 48, 240, self.frame.size.height-48)];
    [self addSubview:content];

}

- (void)refreshInfo
{

}

- (void)foldOrUnFold
{
    [_delegate foldOrUnFoldWithFlag:_flagNum];
}

- (void)setFlagNum:(NSInteger)flagNum
{
    _flagNum = flagNum;
    [settingBtn setFlagNum:flagNum];
}


+(float)heightWithTheIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return [ToolsDynamicView heightWithTheIndex:index]+48;
        case 1:
            return [ToolsCoinView heightWithTheIndex:index]+48;
        case 2:
            return [ToolsCalendarView heightWithTheIndex:index]+48;
        case 3:
            return 48;

            break;
        default:
            return 0;
            break;
    }
}
@end
