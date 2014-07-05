//
//  ShopCartViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"

@interface ShopCartViewController : CustomPopViewController<UITableViewDelegate, UITableViewDataSource>
{
    ColorButton *cartShowBtn;
    ColorButton *orderShowBtn;
    ColorButton *orderBtn;
    ColorButton *deleteBtn;

    UITableView * cartTable;
    UITableView * orderTable;
    UILabel *noti_empty;
    UIView *emptyNotiView;
}

@end
