//
//  BabyPreView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "UIColumnView.h"

@interface BabyPreView : BabyInfoContentView<UIColumnViewDataSource, UIColumnViewDelegate,UIScrollViewDelegate>
{

    UIColumnView *_showColumnView;
    UIScrollView *_controlView;
    UIScrollView *_titles;
    UIScrollView *_points;
    UIView *bgLine;
    int selectedIndex;
}
@property (nonatomic,assign)BOOL columnImgBMode;
- (void)refresh;
- (void)scrollToToday;
@end
