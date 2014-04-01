//
//  PartnerDataInGroupView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataInGroupView.h"
#import "UniverseConstant.h"
#import "Friend.h"

@implementation PartnerDataInGroupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        figuresHeader = [[FiguresHeaderView alloc] initWithFrame:CGRectMake(0, 0, 608, 168)];
        [self addSubview:figuresHeader];
        manage = NO;
        dataInfoView = [[DataInfoScrollView alloc] initWithFrame:CGRectMake(0, 0, 608, 520)];
        [dataInfoView setBounces:NO];
        [dataInfoView setContentSize:CGSizeMake(608, 1432)];
        [self addSubview:dataInfoView];
        manageBtn = [[ColorButton alloc] init];
        [manageBtn initWithTitle:@"管理" andButtonType:kGrayLeft];
        [manageBtn addTarget:self action:@selector(managePartner) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:manageBtn];
    }
    return self;
}

- (void)setVerticalFrame
{
    [dataInfoView setFrame:CGRectMake(0, 168, 608, 776)];
    [dataInfoView setVerticalFrame];
    [figuresHeader setVerticalFrame];
    SetViewLeftUp(figuresHeader, 0, 0);
    SetViewLeftUp(manageBtn, 496, 8);
}

- (void)setHorizontalFrame
{
    [dataInfoView setFrame:CGRectMake(0,168, 864, 520)];
    [dataInfoView setHorizontalFrame];
    [figuresHeader setHorizontalFrame];
    SetViewLeftUp(figuresHeader, 130, 0);
    SetViewLeftUp(manageBtn, 752, 84);
}

- (void)managePartner
{
    manage = !manage;
    if (manage) {
        [manageBtn initWithTitle:@"保存" andButtonType:kGrayLeft];
        PostNotification(Noti_manangePartnerData, nil);
    }else{
        [manageBtn initWithTitle:@"管理" andButtonType:kGrayLeft];
        PostNotification(Noti_manangedPartnerData, nil);
    }
}

- (void)loadViewInfo
{
    manage = NO;
    [manageBtn initWithTitle:@"管理" andButtonType:kGrayLeft];
    PostNotification(Noti_manangedPartnerData, nil);
    [figuresHeader reloadWithGroupInfo:[[Friend sharedInstance] myGroup]];
    [dataInfoView reloadWithGroupInfo:[[Friend sharedInstance] myGroup]];
    
}

@end
