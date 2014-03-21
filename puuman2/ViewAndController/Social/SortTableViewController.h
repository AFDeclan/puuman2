//
//  SortTableViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFSelecedTextImgButton.h"


@interface SortTableViewController : UITableViewController
{

    AFSelecedTextImgButton *left_sortBtn;
    AFSelecedTextImgButton *right_sortBtn;
    BOOL leftSelected;
}
- (void)rightSortSelected;
- (void)leftSortSelected;
@end
