//
//  ShopMenuCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTitleButton.h"
#import "DetailSortTableViewCell.h"

@protocol ShopMenuDelegate;
@interface ShopMenuCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    MenuTitleButton *titleButton;
    UITableView *subTable;
}
@property(nonatomic,assign)id <ShopMenuDelegate> delegate;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,assign) NSInteger flagNum;
- (void)showSubView;
- (void)hiddenSubView;
@end
@protocol ShopMenuDelegate <NSObject>

- (void)selectedMenuWithCell:(ShopMenuCell *)cell;

@end