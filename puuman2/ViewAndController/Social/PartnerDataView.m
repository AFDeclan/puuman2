//
//  PartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation PartnerDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        figuresHeader = [[FiguresHeaderView alloc] initWithFrame:CGRectMake(0, 0, 608, 168)];
        [self addSubview:figuresHeader];
        
        dataInfoView = [[DataInfoScrollView alloc] initWithFrame:CGRectMake(0, 0, 608, 520)];
        [dataInfoView setBounces:NO];
        [dataInfoView setContentSize:CGSizeMake(608, 1432)];
        [self addSubview:dataInfoView];
        manageBtn = [[ColorButton alloc] init];
        [manageBtn initWithTitle:@"管理" andButtonType:kGrayLeft];
        [self addSubview:manageBtn];
      
    }
    return self;
}

- (void)initPortraitsView
{

}
- (void)setVerticalFrame
{
    [dataInfoView setFrame:CGRectMake(0, 168, 608, 776)];
    [dataInfoView setVerticalFrame];
    SetViewLeftUp(figuresHeader, 0, 0);
    SetViewLeftUp(manageBtn, 496, 8);
}

- (void)setHorizontalFrame
{
    [dataInfoView setFrame:CGRectMake(128,168, 608, 520)];
    [dataInfoView setHorizontalFrame];
    SetViewLeftUp(figuresHeader, 128, 0);
    SetViewLeftUp(manageBtn, 752, 84);
}

@end
