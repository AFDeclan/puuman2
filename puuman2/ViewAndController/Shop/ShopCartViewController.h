//
//  ShopCartViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"
#import "CartTableViewCell.h"
@interface ShopCartViewController : CustomPopViewController<UITableViewDelegate, UITableViewDataSource,CartCellDelegate>
{
    ColorButton *cartShowBtn;
    ColorButton *orderShowBtn;
    ColorButton *orderBtn;
    UITableView * cartTable;
    BOOL isPaid;
    NSInteger unfoldIndex;
    UILabel *noti_empty;
    UIView *emptyNotiView;
}

@end
