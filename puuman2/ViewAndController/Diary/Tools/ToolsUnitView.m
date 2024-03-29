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

    }
    return self;
}

- (void)initialization
{

    content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 0)];
    [self addSubview:content];
    [content setBackgroundColor:[UIColor clearColor]];
    [content setAlpha:0];
    settingBtn = [[ToolsSelectedButton alloc] init];
    [settingBtn addTarget:self action:@selector(foldOrUnFold) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
    

}

- (void)refreshInfo
{

}

- (void)foldOrUnFold
{
    [_delegate foldOrUnFoldWithFlag:_flagNum];

}

- (void)foldTool
{
    [UIView animateWithDuration:0.5 animations:^{
        [content setAlpha:0];

    }];
    
    [settingBtn foldTool];
}

- (void)unFoldTool
{
    [UIView animateWithDuration:0.5 animations:^{
        [content setAlpha:1];
    
    }];
    [settingBtn unFoldTool];
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
            return [ToolsDynamicView heightWithTheIndex:index];
        case 1:
            return [ToolsCoinView heightWithTheIndex:index];
        case 2:
            return [ToolsCalendarView heightWithTheIndex:index];
        default:
            return 0;
            break;
    }
}
@end
