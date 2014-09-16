//
//  ToolsCoinView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsUnitView.h"
#import "PieLayer.h"
#import "PieElement.h"
#import "PieView.h"
#import "NSMutableArray+pieEx.h"
@interface ToolsCoinView : ToolsUnitView<PieLayerDeleagate>
{
    PieView* pieView;
    UILabel *coinFather;
    UILabel *coinMother;
    UIView *coinView;
    UILabel *totalCoin;
}

- (void)addPie;
- (void)changedPie;

@end
