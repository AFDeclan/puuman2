//
//  RectHeadShowCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeButton.h"
#import "AFImageView.h"


@interface RectHeadShowCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>
{
    TypeButton  *icon_FlagView;
    UITableView* pointerPic;
    AFImageView *rectWareShowView;
    UIView *rectInfoView;
    UILabel *wareNameLabel;
    UILabel *warePriceLabel;
    NSArray* wareArray;
    int selectedIndex;
  
}

- (void)reloadDataWithData:(NSArray *)showWare;
@end
