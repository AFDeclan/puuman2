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
    wareInfoShowed = NO;
    rectView = [[RectWareView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:rectView];
    
    allView = [[AllWareView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
    [allView setAlpha:0];
    [self addSubview:allView];
    wareInfoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(216+648, 0, 0, 688)];
    [wareInfoScrollView setBackgroundColor:PMColor5];
    [self addSubview:wareInfoScrollView];
    
    infoView = [[ShopWareInfoView alloc] initWithFrame:CGRectMake(0, 0, 648, 688)];
    [infoView setBackgroundColor:[UIColor whiteColor]];
    [wareInfoScrollView addSubview:infoView];
    [MyNotiCenter addObserver:self selector:@selector(showWareInfo:) name:Noti_ShowWareInfo object:nil];
    [MyNotiCenter addObserver:self selector:@selector(showAllShop:) name:Noti_ShowAllShopView object:nil];
}

- (void)showWareInfo:(NSNotification *)notification
{
    wareInfoShowed = [[notification object] boolValue];
    [UIView animateWithDuration:0.5 animations:^{
        if (wareInfoShowed) {
            [wareInfoScrollView setBackgroundColor:PMColor2];
            [wareInfoScrollView setFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        }else{
            [wareInfoScrollView setBackgroundColor:[UIColor clearColor]];
            [wareInfoScrollView setFrame:CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height)];
        }
        
    }];
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
    if (wareInfoShowed) {
        [ wareInfoScrollView setFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    }else{
        [wareInfoScrollView setFrame:CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height)];
    }
    
    [infoView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [infoView refresh];
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
    if (wareInfoShowed) {
        [ wareInfoScrollView setFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    }else{
        [wareInfoScrollView setFrame:CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height)];
    }
    
    [infoView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [infoView refresh];
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
