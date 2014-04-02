//
//  CompareCartViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFImageView.h"
#import "ColorButton.h"
#import "Ware.h"
#import "CartTableViewCell.h"
#import "AnimateShowLabel.h"
@interface CompareCartViewController : CustomPopViewController<UITableViewDelegate, UITableViewDataSource,CartCellDelegate>
{
    AFImageView *first_ImgView;
    AFImageView *second_ImgView;
    UILabel *vs;
    UITableView *cartTable;
    UITableView *infoTable;
    ColorButton *first_winBtn;
    ColorButton *second_winBtn;
    Ware * firstWare;
    Ware * secondWare;
    NSInteger firstIndex;
    NSInteger secondIndex;
    
    AnimateShowLabel *info_firstWareName;
    AnimateShowLabel *info_secondWareName;
    AnimateShowLabel *info_firstWarePrice;
    AnimateShowLabel *info_secondWarePrice;
    
    UIView *bg_infoFirst;
    UIView *bg_infoSecond;
    
    NSMutableDictionary *availableCarts;
    NSMutableArray *_propertyKeys;
    NSMutableArray *availableKeys;
    NSMutableArray *_keys;
    NSArray *_sortedKeys;
    NSMutableSet *_keyset;
}

@end
