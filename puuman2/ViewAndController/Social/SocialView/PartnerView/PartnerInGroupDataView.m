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
        [MyNotiCenter addObserver:self selector:@selector(showManagerMenu:) name:Noti_manangingPartnerData object:nil];
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
    
    if (managing) {
        [blockView setFrame:CGRectMake(0, 0, 768, 1024)];
        [figuresHeader setFrame:CGRectMake(80, 80, 608, 168)];

    }else{
        [dataInfoView setFrame:CGRectMake(0, 168, 608, 776)];
        [figuresHeader setFrame:CGRectMake(0, 0, 608, 168)];

    }
    [dataInfoView setVerticalFrame];
    [figuresHeader setVerticalFrame];
}

- (void)setHorizontalFrame
{
    if (managing) {
        [blockView setFrame:CGRectMake(0, 0, 1024, 768)];
        [figuresHeader setFrame:CGRectMake(80, 80, 608, 168)];

    }else{
        [dataInfoView setFrame:CGRectMake(0,168, 864, 520)];
        [figuresHeader setFrame:CGRectMake(0, 0, 864, 168)];
    }
    
    [dataInfoView setHorizontalFrame];
    [figuresHeader setHorizontalFrame];

}

- (void)loadViewInfo
{
    managing = NO;
    [figuresHeader reloadGroupInfo];
    [dataInfoView reloadWithGroupInfo:[[Friend sharedInstance] myGroup]];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)showManagerMenu:(NSNotification *)notification
{
    managing = [[notification object] boolValue];
    
    if (!blockView) {
        blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }

    if (managing) {
        [[MainTabBarController sharedMainViewController].view addSubview:blockView];
        [blockView addSubview:figuresHeader];
    }else{
        [self addSubview:figuresHeader];
        [blockView removeFromSuperview];
    }
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)dealloc
{
    [figuresHeader removeFromSuperview];
    if (blockView) {
        [blockView removeFromSuperview];
    }
    [MyNotiCenter removeObserver:self];
}
@end
