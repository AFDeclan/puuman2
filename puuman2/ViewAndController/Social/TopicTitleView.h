//
//  TopicTitleView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "TopicTitleCell.h"

@interface TopicTitleView : UIView<UIColumnViewDataSource, UIColumnViewDelegate>
{
   UIColumnView *_showColumnView;
}

@end
