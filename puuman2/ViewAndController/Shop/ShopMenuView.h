//
//  ShopMenuView.h
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import "RankView.h"
@interface ShopMenuView : UIView
{
    RankView  *rankView;
    MenuView  *menuView;
    NSTimer *_timerToFoldDrawer;

}

- (void)updateRankView;
- (void)reloadRankView;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;
- (void)selectedParentIndex:(NSInteger)parentIndex andChildIndex:(NSInteger)childIndex;
@end
