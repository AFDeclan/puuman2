//
//  AllTopicView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicSelectButton.h"
#import "ColorButton.h"
#import "UIColumnView.h"
#import "TopicShowedCell.h"

@interface AllTopicView : UIView<UIColumnViewDataSource,UIColumnViewDelegate>
{
    TopicSelectButton *leftBtn;
    TopicSelectButton *rightBtn;
    ColorButton *rewardBtn;
    ColorButton *participateBtn;
    UIColumnView *_showColumnView;
    
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
