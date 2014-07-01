//
//  ShopMenuView.h
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopMenuCell.h"

@interface ShopMenuView : UIView<UITableViewDataSource,UITableViewDelegate,ShopMenuDelegate>
{
    UITableView *menuTable;
}

-(void)setVerticalFrame;
-(void)setHorizontalFrame;
@end
