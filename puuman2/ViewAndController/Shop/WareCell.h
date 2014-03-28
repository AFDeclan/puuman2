//
//  WareCell.h
//  puman
//
//  Created by 陈晔 on 13-9-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WareCellSubView;
@interface WareCell : UITableViewCell
{
    NSArray *_wares;
    WareCellSubView *_wareView[3];
}

- (void)setWares:(NSArray *)wares;

@end
