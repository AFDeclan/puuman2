//
//  ToolsCoinView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsCoinView.h"
#import "UserInfo.h"

@implementation ToolsCoinView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];

    }
    return self;
}

- (void)initialization
{
    self.layer.masksToBounds = YES;
    [super initialization];
    [self setContentView];
}
- (void)setContentView
{
    [content setFrame:CGRectMake(0, 0, 240, 288+64)];

    pieView = [[PieView alloc] initWithFrame:CGRectMake(20, 80, 200, 180)];
    [content addSubview:pieView];
    
    pieView.pieLayerDelegate = self;
    [pieView setBackgroundColor:[UIColor clearColor]];
    [pieView setAlpha:0];
    [self animateStartEnd];
    
    [self addPressedWithValue:[[UserInfo sharedUserInfo] UCorns] atIndex:0 color: PMColor6];
    [self addPressedWithValue:[[UserInfo sharedUserInfo] UCorns_connect] atIndex:1 color:PMColor8];
    
    coinView = [[UIView alloc] initWithFrame:CGRectMake(40, 68, 160, 216)];
    [content addSubview:coinView];
    [coinView setBackgroundColor:[UIColor clearColor]];
   
    coinMother = [[UILabel alloc] initWithFrame:CGRectMake(0, -4, 160, 20)];
    [coinMother setBackgroundColor:[UIColor clearColor]];
    [coinMother setTextColor:PMColor6];
    [coinMother setFont:PMFont2];
    [coinMother setTextAlignment:NSTextAlignmentCenter];
    [coinView addSubview:coinMother];
    
    coinFather = [[UILabel alloc] initWithFrame:CGRectMake(0, 196, 160, 20)];
    [coinFather setBackgroundColor:[UIColor clearColor]];
    [coinFather setTextColor:PMColor6];
    [coinFather setFont:PMFont2];
    [coinFather setTextAlignment:NSTextAlignmentCenter];
    [coinView addSubview:coinFather];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(19, 40, 122, 122)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    bgView.layer.cornerRadius = 61;
    [bgView setAlpha:0.3];
    [coinView addSubview:bgView];
    
    totalCoin = [[UILabel alloc] initWithFrame:CGRectMake(19, 40, 122, 122)];
    [totalCoin setBackgroundColor:[UIColor clearColor]];
    [totalCoin setTextColor:PMColor6];
    [totalCoin setFont:PMFont2];
    [totalCoin setTextAlignment:NSTextAlignmentCenter];
    [coinView addSubview:totalCoin];
    
    UILabel  *totalLabel= [[UILabel alloc] initWithFrame:CGRectMake(19, 106, 122, 20)];
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    [totalLabel setTextColor:PMColor6];
    [totalLabel setFont:PMFont(14)];
    [totalLabel setText:@"共同资产"];
    [totalLabel setTextAlignment:NSTextAlignmentCenter];
    [coinView addSubview:totalLabel];
    [coinView setAlpha:0];
    
}

- (void)refreshInfo
{
    [pieView setFinishLoad:NO];
    [pieView setBackgroundColor:[UIColor clearColor]];
    [coinView setAlpha:0];
    [self animateChangeVal:0 andIndex:0];
    [self animateChangeVal:0 andIndex:1];
    [self animateStartEnd];

}

- (void)addPie
{
    if ([[UserInfo sharedUserInfo] UCorns]+[[UserInfo sharedUserInfo] UCorns_connect] != 0) {

    if ([UserInfo sharedUserInfo].identity == Mother) {
        [self animateChangeVal:1-[[UserInfo sharedUserInfo] UCorns]/([[UserInfo sharedUserInfo] UCorns]+[[UserInfo sharedUserInfo] UCorns_connect]) andIndex:0];
        [self animateChangeVal:1-[[UserInfo sharedUserInfo] UCorns_connect]/([[UserInfo sharedUserInfo] UCorns]+[[UserInfo sharedUserInfo] UCorns_connect]) andIndex:1];
        
        [coinMother setText:[NSString stringWithFormat:@"妈妈%0.1f",[[UserInfo sharedUserInfo] UCorns]]];
        [coinFather setText:[NSString stringWithFormat:@"爸爸%0.1f",[[UserInfo sharedUserInfo] UCorns_connect]]];

    }else{
        [self animateChangeVal:1-[[UserInfo sharedUserInfo] UCorns_connect]/([[UserInfo sharedUserInfo] UCorns]+[[UserInfo sharedUserInfo] UCorns_connect]) andIndex:0];
        [self animateChangeVal:1-[[UserInfo sharedUserInfo] UCorns]/([[UserInfo sharedUserInfo] UCorns]+[[UserInfo sharedUserInfo] UCorns_connect]) andIndex:1];
        [coinFather setText:[NSString stringWithFormat:@"爸爸%0.1f",[[UserInfo sharedUserInfo] UCorns]]];
        [coinMother setText:[NSString stringWithFormat:@"妈妈%0.1f",[[UserInfo sharedUserInfo] UCorns_connect]]];

    }
    [totalCoin setText:[NSString stringWithFormat:@"%0.1f",[[UserInfo sharedUserInfo] UCorns]+[[UserInfo sharedUserInfo] UCorns_connect]]];

    [pieView setAlpha:1];
    [pieView setFinishLoad:YES];
    }else{
        [coinFather setText:[NSString stringWithFormat:@"爸爸%0.1f",[[UserInfo sharedUserInfo] UCorns]]];
        [coinMother setText:[NSString stringWithFormat:@"妈妈%0.1f",[[UserInfo sharedUserInfo] UCorns_connect]]];
        [coinView setAlpha:1];
        
    }
}

- (void)addPressedWithValue:(float)value atIndex:(NSInteger)index color:(UIColor *)color
{
    PieElement* newElem = [PieElement pieElementWithValue:value color:color];

    [pieView.layer insertValues:@[newElem] atIndexes:@[@(index)] animated:YES];

}


- (void)animateStartEnd
{
    float startAngle;
    float  pre = ([[UserInfo sharedUserInfo] UCorns_connect])/([[UserInfo sharedUserInfo] UCorns] + [[UserInfo sharedUserInfo] UCorns_connect]);
    if ([UserInfo sharedUserInfo].identity == Mother) {
        if ([[UserInfo sharedUserInfo] UCorns] > [[UserInfo sharedUserInfo] UCorns_connect]) {
            startAngle = 360- 360 *(pre + (0.5-pre)/2);
            
        }else{
            startAngle = 360- 360 *(pre - (pre-0.5)/2);
            
        }
    }else{
    
        if ([[UserInfo sharedUserInfo] UCorns] > [[UserInfo sharedUserInfo] UCorns_connect]) {
            startAngle = 360 *(pre + (0.5-pre)/2);
        
        }else{
            startAngle = 360 *(pre - (pre-0.5)/2);
        }
    }
  
       float endAngle = 360 + startAngle;
    [pieView.layer setStartAngle:startAngle endAngle:endAngle animated:YES];
}


- (void)finishedAnimate
{
    [coinView setAlpha:1];
}

- (void)animateChangeVal:(float)value andIndex:(NSInteger)index
{
    if(pieView.layer.values.count == 0)return;
    [PieElement animateChanges:^{
            [pieView.layer.values[index] setVal:value];
    }];
}


+(float)heightWithTheIndex:(NSInteger)index
{
    return 288+64;
}

@end
