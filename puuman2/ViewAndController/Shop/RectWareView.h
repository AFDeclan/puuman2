//
//  RectWareView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecomModel.h"
@interface RectWareView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *rectTable;
    RecomModel *_model;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
