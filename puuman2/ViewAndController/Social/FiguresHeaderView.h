//
//  FiguresHeaderView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "AnimateShowLabel.h"

@interface FiguresHeaderView : UIView<UIColumnViewDataSource, UIColumnViewDelegate>
{
    UIImageView *icon_head;
    AnimateShowLabel *noti_label;
    UITextField *info_title;
    UIButton *modifyBtn;
    UIColumnView *figuresColumnView;
  
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
