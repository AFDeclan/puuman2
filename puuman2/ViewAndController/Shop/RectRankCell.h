//
//  RectRankCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "TypeButton.h"
@interface RectRankCell : UITableViewCell<UIColumnViewDataSource, UIColumnViewDelegate>
{
    TypeButton  *icon_FlagView;
    UIColumnView *_showColumnView;
    NSArray *rectWares;
}

- (void)setDataViewRectRanks:(NSArray *)rects andRectTypeIndex:(NSInteger)typeIndex;
@end
