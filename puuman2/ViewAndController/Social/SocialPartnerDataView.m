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
        [[Friend sharedInstance] addDelegateObject:self];

    }
    return self;
}

- (void)showView
{
    [super showView];
    [[Friend sharedInstance] getGroupData];
     
}


- (void)inGoup
{
    if (!inGroupView) {
        inGroupView = [[PartnerInGroupDataView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:inGroupView];
    }
    [inGroupView setAlpha:1];
    [outGroupView setAlpha:0];
    PostNotification(Noti_InOrOutGroup,[NSNumber numberWithBool:YES]);
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
}

- (void)outGroup
{
    if (!outGroupView) {
        outGroupView = [[PartnerOutGroupDataView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:outGroupView];
    }
    [inGroupView setAlpha:0];
    [outGroupView setAlpha:1];
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
    
    NSLog(@"%@",[[Friend sharedInstance] myGroup].GName);
    
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
