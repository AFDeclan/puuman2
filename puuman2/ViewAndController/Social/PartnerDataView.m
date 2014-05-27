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
#import "MainTabBarController.h"

@implementation PartnerDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        inGroupView = [[PartnerDataInGroupView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:inGroupView];
        outGroupView = [[PartnerDataOutGroupView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:outGroupView];
        [inGroupView setAlpha:0];
        [outGroupView setAlpha:0];
        [MyNotiCenter addObserver:self selector:@selector(refreshStatus) name:Noti_RefreshInviteStatus object:nil];
    }
    return self;
}

- (void)refreshStatus
{
    if ([[Friend sharedInstance] inGroup]) {
         PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:YES] );
    }else{
         PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:NO] );
    }
    
    [[Friend sharedInstance] removeDelegateObject:self];
    [[Friend sharedInstance] addDelegateObject:self];
    [[Friend sharedInstance] getGroupData];
}

- (void)setVerticalFrame
{
    
    if ([[Friend sharedInstance] inGroup])
    {
        [inGroupView setFrame:CGRectMake(0, 0, 608, 944)];
        [inGroupView setVerticalFrame];
    }else{
        [outGroupView setFrame:CGRectMake(0, 0, 608, 944)];
        [outGroupView setVerticalFrame];
    }
    
}

- (void)setHorizontalFrame
{
    
    if ([[Friend sharedInstance] inGroup])
    {
        [inGroupView setFrame:CGRectMake(0, 0, 864, 688)];
        [inGroupView setHorizontalFrame];
    }else{
        [outGroupView setFrame:CGRectMake(0, 0, 864, 688)];
        [outGroupView setHorizontalFrame];
    }
}

//获取小组信息成功
- (void)groupDataReceived
{
    if ([[Friend sharedInstance] inGroup]) {
        [inGroupView setAlpha:1];
        [outGroupView setAlpha:0];
        [inGroupView loadViewInfo];
          PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:YES]);
        
    }else{
        [inGroupView setAlpha:0];
        [outGroupView setAlpha:1];
        [outGroupView loadViewInfo];
          PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:NO] );
    }
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

//获取小组信息失败
- (void)groupDataFailed
{
    if ([[Friend sharedInstance] inGroup]) {
        [inGroupView setAlpha:1];
        [outGroupView setAlpha:0];
        [inGroupView loadViewInfo];
        
    }else{
        [inGroupView setAlpha:0];
        [outGroupView setAlpha:1];
        [outGroupView loadViewInfo];
    }
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }

}


@end
