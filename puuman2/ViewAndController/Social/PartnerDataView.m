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
        
        [[Friend sharedInstance] getGroupData];
        [[Friend sharedInstance] addDelegateObject:self];
        
        inGroupView = [[PartnerDataInGroupView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:inGroupView];
        outGroupView = [[PartnerDataOutGroupView alloc] initWithFrame:CGRectMake(0, 0, 864, 688)];
        [self addSubview:inGroupView];
        [inGroupView setAlpha:0];
        [outGroupView setAlpha:0];
    }
    return self;
}

- (void)initPortraitsView
{
   // UITextView *a;
}

- (void)setVerticalFrame
{
    if ([[Friend sharedInstance] inGroup])
    {
            [inGroupView setVerticalFrame];
    }else{
            [outGroupView setVerticalFrame];
    }
    
}

- (void)setHorizontalFrame
{
    if ([[Friend sharedInstance] inGroup])
    {
        [inGroupView setHorizontalFrame];
    }else{
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
        
    }else{
        [inGroupView setAlpha:0];
        [outGroupView setAlpha:1];
        [outGroupView loadViewInfo];
    }
}

//获取小组信息失败
- (void)groupDataFailed
{
    NSLog(@"BO");
}


@end
