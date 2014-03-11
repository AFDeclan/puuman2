//
//  PhotoMoreDiaryCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryCell.h"
#import "UIColumnView.h"

@interface PhotoMoreDiaryCell : DiaryCell<UIColumnViewDataSource, UIColumnViewDelegate>
{

    NSArray *_photoPaths;
    UIColumnView *_showColumnView;
    int selectedIndex;
    UILabel *titleLabel;
}
@end
