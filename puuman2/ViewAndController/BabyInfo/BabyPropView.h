//
//  BabyPropView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "PropView.h"

@interface BabyPropView : BabyInfoContentView
{
    PropView *babyPropView;
}
- (void)refresh;
@end
