//
//  ToolsDynamicView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsUnitView.h"
#import "JoinView.h"

@interface ToolsDynamicView : ToolsUnitView
{
 
    JoinView *joinView;
}

- (void)refreshStatus;
-(void)keyBoardHidden;

@end