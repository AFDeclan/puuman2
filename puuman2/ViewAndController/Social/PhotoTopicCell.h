//
//  PhotoTopicCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicCell.h"
#import "UIColumnView.h"

@interface PhotoTopicCell : TopicCell<UIColumnViewDataSource, UIColumnViewDelegate>
{
    NSArray *_photoPaths;
    UIColumnView *_showColumnView;
}
@end
