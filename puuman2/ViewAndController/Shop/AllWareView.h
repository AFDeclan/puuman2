//
//  AllWareView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
#import "MJRefreshFooterView.h"
#import "ShopAllWareHeaderView.h"
#import "ShopWareInfoView.h"

typedef enum ShopState {
    ShopStateNormal,
    ShopStateFiltered,
    ShopStateInsurance
} ShopState;


@interface AllWareView : UIView<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    ShopAllWareHeaderView *headView;
    UITableView *_shopMallTable;
    ShopState _shopState;
    MJRefreshFooterView *_refreshFooter;
    UILabel *noti_insurance;
    ShopWareInfoView *infoView;
}

-(void)reloadShopMall;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
