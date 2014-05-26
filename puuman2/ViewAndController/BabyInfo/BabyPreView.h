//
//  BabyPreView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "UIColumnView.h"
#import "BabyPreTableViewCell.h"
#import "ControlScrollView.h"

@interface BabyPreView : BabyInfoContentView<UIColumnViewDataSource, UIColumnViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,ControlScrollDelegate>
{

    UIColumnView *_showColumnView;
    ControlScrollView *_controlView;
    UIScrollView *_titles;
    UIScrollView *_points;
    UIView *bgLine;
    int selectedIndex;
    UIScrollView *bgScrollView;
    BOOL scrolled;
}
@property (nonatomic,assign)BOOL columnImgBMode;
- (void)refresh;
- (void)scrollToToday;
@end
