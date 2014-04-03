//
//  AllTopicView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "TopicContentCell.h"
#import "Forum.h"


@interface AllTopicView : UIView<UIColumnViewDataSource, UIColumnViewDelegate,ForumDelegate,TopicContentCellDelegate>

{

     UIColumnView *_showColumnView;
    
}

- (void)reloadAllTopic;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;

@end
