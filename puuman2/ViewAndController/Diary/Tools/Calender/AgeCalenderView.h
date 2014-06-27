//
//  AgeCalenderView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"

@interface AgeCalenderView : UIView<UIColumnViewDataSource, UIColumnViewDelegate>
{
    UIColumnView *calendarColumnView;

}
@end
