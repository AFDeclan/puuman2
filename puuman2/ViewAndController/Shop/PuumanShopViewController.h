//
//  PuumanShopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "WarePumanScrollView.h"
#import "Ware.h"

@interface PuumanShopViewController : CustomPopViewController<RulerScrollDelegate>
{
    UIButton *showBtn;
    BOOL showed;
      WarePumanScrollView *rulerPumanUse;
    float pumanUsed;
    UILabel *label_use;
    UILabel *noti_have;
    
}

@property (assign, nonatomic) NSInteger wid;
@property (retain, nonatomic) NSString *shop;
- (void)showPuumanShop;
- (void)hidden;
@end
