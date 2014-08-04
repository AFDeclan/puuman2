//
//  PartnerInGroupDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerInGroupDataView.h"
#import "UniverseConstant.h"
#import "Friend.h"
#import "MainTabBarController.h"

@implementation PartnerInGroupDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        figuresHeader = [[FiguresHeaderView alloc] initWithFrame:CGRectMake(0, 0, 608, 168)];
        [self addSubview:figuresHeader];
        dataInfoView = [[DataInfoScrollView alloc] initWithFrame:CGRectMake(0, 0, 608, 520)];
        [dataInfoView setBounces:YES];
        [dataInfoView setContentSize:CGSizeMake(608, 672)];
        [self addSubview:dataInfoView];
        
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)setVerticalFrame
{
    [dataInfoView setFrame:CGRectMake(0, 168, 608, 776)];
    [figuresHeader setFrame:CGRectMake(0, 0, 608, 168)];
    [dataInfoView setVerticalFrame];
    [figuresHeader setVerticalFrame];
}

- (void)setHorizontalFrame
{
    [dataInfoView setFrame:CGRectMake(0,168, 864, 520)];
    [figuresHeader setFrame:CGRectMake(0, 0, 864, 168)];
    [dataInfoView setHorizontalFrame];
    [figuresHeader setHorizontalFrame];
}

- (void)loadViewInfo
{
    [figuresHeader reloadGroupInfo];
    [dataInfoView reloadWithGroupInfo:[[Friend sharedInstance] myGroup]];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)dealloc
{

}


@end
