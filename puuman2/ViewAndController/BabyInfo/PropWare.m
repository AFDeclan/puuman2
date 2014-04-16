//
//  PropWare.m
//  puman
//
//  Created by 祁文龙 on 13-11-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "PropWare.h"
#import "ColorsAndFonts.h"
#import "SinglepopViewController.h"
#import "MainTabBarController.h"
#import "ShopViewController.h"
#import "ShopModel.h"

@implementation PropWare

- (id)init
{
    
    self = [super init];
    if (self) {
       
        w_Pic = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [w_Pic setImage:[UIImage imageNamed:@"pic_default_baby_ware.png"]];
        [w_Pic setBackgroundColor:[UIColor clearColor]];
        [self addSubview:w_Pic];
        w_Name = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 80, 28)];
        [w_Name setTextColor:PMColor4];
        [w_Name setTextAlignment:NSTextAlignmentCenter];
        [w_Name setBackgroundColor:[UIColor clearColor]];
        [w_Name setFont:PMFont2];
        [self addSubview:w_Name];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [button addTarget:self action:@selector(detailInfo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}
- (void)setParentMenu:(NSInteger)index andChildMenu:(NSInteger)num
{
    parentMenu = index;
    childMenu = num;
     if (index == 0 && num == -1) {
          [w_Name setText:@"选奶粉"];
     }else if (index == 5 && num == -1)
     {
          [w_Name setText:@"选童车童床"];
     }else if (index == 3 && num == 0)
     {
          [w_Name setText:@"选奶瓶"];
     }else if (index == 2 && num == -1)
     {
          [w_Name setText:@"选尿布"];
     }else if (index == 7 && num == -1)
     {
          [w_Name setText:@"选玩具"];
     }else if (index == 8 && num == 7) {
         [w_Name setText:@"选营养品"];
     }else if (index == 8 && num == 1)
     {
         [w_Name setText:@"选胎教产品"];
     }else if (index == 6 && num == 6)
     {
         [w_Name setText:@"选抱枕"];
     }else if (index == 8 && num == 8)
     {
         [w_Name setText:@"选彩妆"];
     }else if (index == 8 && num == 6)
     {
         [w_Name setText:@"选防辐射服"];
     }else if (index == 10 && num == 9) {
         [w_Name setText:@"选书籍"];
     }else if (index == 10 && num == 3)
     {
         [w_Name setText:@"选男式皮具"];
     }else if (index == 10 && num == 1)
     {
         [w_Name setText:@"选男式护肤品"];
     }else if (index == 10 && num == 6)
     {
         [w_Name setText:@"选酒水饮料"];
     }else if (index == 10 && num == 7)
     {
         [w_Name setText:@"选电子产品"];
     }

    
    
}
- (void)detailInfo
{
//    [MobClick event:umeng_event_click label:@"DetailInfo_PropWare"];
//    if (_ware) {
//        SingleGoodViewController *singleGoodViewController = [[SingleGoodViewController alloc]initWithNibName:@"SingleGoodViewController" bundle:nil];
//        [BlurView showViewController:singleGoodViewController withVerticalViewFrame:CGRectMake(12, 296, 736, 521) andHorizontalViewFrame:CGRectMake(140, 80, 736, 521)];
//        [singleGoodViewController setWare:_ware];
//    }else{
//  
//        [[MainViewController sharedMainViewController] scrollToShopWithParentIndex:parentMenu andChildIndex:childMenu];
//    }
    
    if(_ware) {
        SinglepopViewController *singGoodVC = [[SinglepopViewController alloc] initWithNibName:nil bundle:nil];
        [singGoodVC setControlBtnType:kOnlyCloseButton];
        [singGoodVC setTitle:@"单品信息" withIcon:nil];
        [singGoodVC setWare:_ware];
        [[MainTabBarController sharedMainViewController].view addSubview:singGoodVC.view];
        [singGoodVC show];
    }else{
        [[MainTabBarController sharedMainViewController] goToShopWithParentIndex:parentMenu andChildIndex:childMenu];
    }
    

}
- (void)initWithWare:(Ware *)ware
{
    _ware = ware;
    [w_Pic getImage:ware.WPicLink defaultImage:default_ware_image];
    [w_Name setText:ware.WName];
    
}

@end
