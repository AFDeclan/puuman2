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
    ColorButton *btn_unpaid;
    ColorButton *btn_paid;
    ColorButton *btn_compared;
    UITableView * cartTable;
    BOOL isPaid;
}

@end
