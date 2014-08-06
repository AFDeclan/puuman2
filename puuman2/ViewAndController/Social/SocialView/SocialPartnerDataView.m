//
//  SocialPartnerDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialPartnerDataView.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "Group.h"
#import "Friend.h"

@implementation SocialPartnerDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}


- (void)showView
{
    [super showView];
    [MyNotiCenter addObserver:self selector:@selector(getData) name:Noti_RefreshInviteStatus object:nil];
    [[Friend sharedInstance] addDelegateObject:self];
    [self getData];
}

- (void)getData
{
    [[Friend sharedInstance] getGroupData];

}



- (void)hiddenView
{
    [[Friend sharedInstance] removeDelegateObject:self];
    [MyNotiCenter removeObserver:self];
    [super hiddenView];

}



- (void)inGoup
{
    if (outGroupView) {
        [outGroupView removeFromSuperview];
         outGroupView = nil;
    }
    
    if (!inGroupView) {
        inGroupView = [[PartnerInGroupDataView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:inGroupView];
    }
    
    [inGroupView setAlpha:1];
    [inGroupView loadViewInfo];
    PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:YES]);
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)outGroup
{
    if (inGroupView) {
        [inGroupView removeFromSuperview];
        inGroupView = nil;
    }
    if (!outGroupView) {
        outGroupView = [[PartnerOutGroupDataView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:outGroupView];
    }
    [outGroupView setAlpha:1];
    [outGroupView loadViewInfo];
    PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:NO] );
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

//获取小组信息成功
- (void)groupDataReceived
{
    if ([[Friend sharedInstance] inGroup]) {
        [self inGoup];
        
    }else{
        [self outGroup];
    }
}

//获取小组信息失败
- (void)groupDataFailed
{
    if ([[Friend sharedInstance] inGroup]) {
        [self inGoup];
    }else{
        [self outGroup];
    }
    
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


@end
