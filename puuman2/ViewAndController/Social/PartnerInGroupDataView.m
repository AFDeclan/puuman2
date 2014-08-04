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
        selected = NO;
        dataInfoView = [[DataInfoScrollView alloc] initWithFrame:CGRectMake(0, 0, 608, 520)];
        [dataInfoView setBounces:NO];
        [dataInfoView setContentSize:CGSizeMake(608, 672)];//1432
        [self addSubview:dataInfoView];
        manageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [manageBtn setFrame:CGRectMake(0, 0, 40, 32)];
        [manageBtn.titleLabel setFont:PMFont2];
        [manageBtn setBackgroundColor:PMColor6];
        [manageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [manageBtn setTitle:@"管理" forState: UIControlStateNormal];
        [manageBtn addTarget:self action:@selector(managePartner) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:manageBtn];
        
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}



@end
