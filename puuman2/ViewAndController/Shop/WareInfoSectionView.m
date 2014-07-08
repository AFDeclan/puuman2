//
//  WareInfoSectionView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "WareInfoSectionView.h"

@implementation WareInfoSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        
    }
    return self;
}

- (void)initialization
{
    describeBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 64, 96)];
    [describeBtn setSelectedImg:[UIImage imageNamed:@"btn_rec1_shop"] andUnselectedImg:[UIImage imageNamed:@"btn_rec2_shop"]];
    [describeBtn addTarget:self action:@selector(describeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:describeBtn];
    
    evaluateBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 96, 64, 96)];
    [evaluateBtn setSelectedImg:[UIImage imageNamed:@"btn_all1_shop.png"] andUnselectedImg:[UIImage imageNamed:@"btn_all2_shop.png"]];
    [evaluateBtn addTarget:self action:@selector(evaluateBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:evaluateBtn];
    
    
}

- (void)refresh
{
    [self describeBtnPressed];
    
}

- (void)describeBtnPressed
{
    [describeBtn selected];
    [evaluateBtn unSelected];
    
}

- (void)evaluateBtnPressed
{
    [evaluateBtn selected];
    [describeBtn unSelected];
}


@end
