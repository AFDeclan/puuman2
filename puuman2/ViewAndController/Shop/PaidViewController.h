//
//  PaidViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"
#import "Ware.h"

@interface PaidViewController : CustomPopViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView * cartTable;
    ColorButton *leftBtn;
    ColorButton *rightBtn;
    UILabel *priceLabel;
    UIView *goldView ;
    UIView *usePumanView;
    UIView *usingPumanView;
    UIView *modifyPumanView;
    int goldCount ;
    UIButton *reduceCountBtn;
    UIButton *addCountBtn;
    UILabel *changeCountLabel;
    int count;
    UILabel *modifyLabel;
    UIView *modifyView;
    
   
}
@end
