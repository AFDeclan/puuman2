//
//  DataInfoScrollView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
@interface DataInfoScrollView : UIScrollView<UIColumnViewDataSource, UIColumnViewDelegate,UIScrollViewDelegate>
{
    UIColumnView *dataColumnView;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
