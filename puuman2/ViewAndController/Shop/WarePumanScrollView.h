//
//  WarePumanScrollView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-2-15.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "RulerScrollView.h"

@interface WarePumanScrollView : RulerScrollView
{
    float rangeFrom;
    float rangeTo;
}
- (void)setDialScrollRangeFrom:(float)from To:(float)to;
@end
