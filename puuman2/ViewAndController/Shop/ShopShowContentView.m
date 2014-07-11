//
//  ShopShowContentView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopShowContentView.h"

@implementation ShopShowContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    rectView = [[RectWareView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:rectView];
    
    allView = [[AllWareView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
    [allView setAlpha:0];
    [self addSubview:allView];
    
    [MyNotiCenter addObserver:self selector:@selector(showAllShop:) name:Noti_ShowAllShopView object:nil];
}


- (void)showAllShop:(NSNotification *)notification
{
    if ([[notification object] boolValue]) {
        [UIView animateWithDuration:0.5 animations:^{
            [allView setAlpha:1];
            [rectView setAlpha:0];
        }];
        [allView  reloadShopMall];

    }else{
        [ShopModel sharedInstance].sectionIndex = -1;
        [ShopModel sharedInstance].subClassIndex = -1;
        PostNotification(Noti_RefreshMenu, nil);
        [UIView animateWithDuration:0.5 animations:^{
            [rectView setAlpha:1];
            [allView setAlpha:0];
        }];

    }
}



- (void)setVerticalFrame
{
    
  
    if (rectView) {
        [rectView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [rectView setVerticalFrame];
    }
    
    if (allView) {
        [allView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [allView setVerticalFrame];
    }


}

- (void)setHorizontalFrame
{
  
    
      if (rectView) {
        [rectView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [rectView setVerticalFrame];
    }
    
    if (allView) {
        [allView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [allView setVerticalFrame];
    }
    
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
