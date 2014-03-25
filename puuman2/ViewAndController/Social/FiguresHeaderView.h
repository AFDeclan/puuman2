//
//  FiguresHeaderView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"

@interface FiguresHeaderView : UIView<UIColumnViewDataSource, UIColumnViewDelegate>
{
    UIImageView *icon_head;
    UILabel *noti_label;
    UILabel *info_title;
    UIColumnView *figuresColumnView;
    
    
}
@end
