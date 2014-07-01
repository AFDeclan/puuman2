//
//  ShopCartViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopCartViewController.h"
#import "CartModel.h"
#import "MainTabBarController.h"
#import "CompareCartViewController.h"
#import "SinglepopViewController.h"

@interface ShopCartViewController ()

@end

@implementation ShopCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initWithContent];
        [MyNotiCenter addObserver:self selector:@selector(refreshCartTable) name:Noti_RefreshCartWare object:nil];
        [MyNotiCenter addObserver:self selector:@selector(unFoldAtIndex:) name:Noti_UnFoldCartWare object:nil];
    }
    return self;
}

- (void)initWithContent
{
    isPaid = NO;
    unfoldIndex = -1;
    
    cartShowBtn = [[ColorButton alloc] init];
    [cartShowBtn initWithTitle:@"购物出"  andButtonType:kBlueLeftUp];
    [cartShowBtn addTarget:self action:@selector(cartShowBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:cartShowBtn];
   
    orderShowBtn= [[ColorButton alloc] init];
    [orderShowBtn initWithTitle:@"订单"  andButtonType:kBlueLeftDown];
    [orderShowBtn addTarget:self action:@selector(orderShowBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:orderShowBtn];
    
    orderBtn= [[ColorButton alloc] init];
    [orderBtn initWithTitle:@"下单"  andButtonType:kBlueLeft];
    [orderBtn addTarget:self action:@selector(orderBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:orderBtn];
    
    SetViewLeftUp(cartShowBtn, 592, 480);
    SetViewLeftUp(orderShowBtn, 592, 520);
    SetViewLeftUp(orderBtn, 592, 112);
    
    cartTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 112, 528, 448)];
    [cartTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cartTable setShowsVerticalScrollIndicator:NO];
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    [cartTable setBackgroundColor:[UIColor clearColor]];
    [cartTable setBounces:YES];
    [cartTable setAlpha:1];
    [_content addSubview:cartTable];
    emptyNotiView = [[UIView alloc] initWithFrame:CGRectMake(216, 256, 224, 144)];
    [_content addSubview:emptyNotiView];
    UIImageView  *icon_empty = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 224, 96)];
    [icon_empty setImage:[UIImage imageNamed:@"pic_cart_blank.png"]];
    [emptyNotiView addSubview:icon_empty];
    noti_empty = [[UILabel alloc] initWithFrame:CGRectMake(0, 96, 224, 48)];
    [noti_empty setFont:PMFont4];
    [noti_empty setTextColor:PMColor3];
    [noti_empty setTextAlignment:NSTextAlignmentCenter];
    [noti_empty setBackgroundColor:[UIColor clearColor]];
    [emptyNotiView addSubview:noti_empty];
    
    [self cartShowBtnPressed];
   
   
}

- (void)refreshCartTable
{
    unfoldIndex = -1;
    [self emptyWithPaid:isPaid];
    [cartTable reloadData];
}
#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (isPaid)
    {
        return [[CartModel sharedCart] DoneCount];
    }else
    {
        return [[CartModel sharedCart] UndoCount];
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *identify = @"ShopTableCell";
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell =  [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (isPaid) {
         [cell setUnflod:NO];
    }else{
        if ([indexPath row] == unfoldIndex) {
            [cell setUnflod:YES];
        }else{
            [cell setUnflod:NO];
        }
    }
    [cell setDelegate:self];
    [cell buildCellWithPaid:isPaid andWareIndex:[indexPath row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPaid) {
       // Ware* w = [[CartModel sharedCart] getDoneWareAtIndex:[indexPath row]];
    }else{
        Ware* w = [[CartModel sharedCart] getUndoWareAtIndex:[indexPath row]];
        SinglepopViewController *singGoodVC = [[SinglepopViewController alloc] initWithNibName:nil bundle:nil];
        [singGoodVC setControlBtnType:kOnlyCloseButton];
        [singGoodVC setTitle:@"单品信息" withIcon:nil];
        [singGoodVC setWare:w];
        [[MainTabBarController sharedMainViewController].view addSubview:singGoodVC.view];
        [singGoodVC show];
    }
    
    
}


- (void)cartShowBtnPressed
{
    isPaid = YES;
    [self emptyWithPaid:isPaid];
    [orderShowBtn unSelected];
    [cartShowBtn selected];
    [cartTable reloadData];
    [orderBtn setAlpha:1];

}

- (void)orderShowBtnPressed
{
    [orderBtn setAlpha:0];
    [orderShowBtn selected];
    [cartShowBtn unSelected];
    isPaid = NO;
    [self emptyWithPaid:isPaid];
    [cartTable reloadData];
   
}


- (void)orderBtnPressed
{
   
    CompareCartViewController *cartVC =[[CompareCartViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:cartVC.view];
    [cartVC setControlBtnType:kOnlyCloseButton];
    [cartVC setTitle:@"比一比" withIcon:[UIImage imageNamed:@"icon_compare3_shop.png"]];
    [cartVC show];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)unFoldAtIndex:(NSNotification *)notification
{

    unfoldIndex = [[notification object] integerValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)emptyWithPaid:(BOOL)paid
{
    
    if (paid) {
        if ([[CartModel sharedCart] DoneCount] == 0) {
            [noti_empty setText: @"您还没有已付款的商品哦~"];
            [emptyNotiView setAlpha:1];
        }else{
          [emptyNotiView setAlpha:0];
        }
    }else{
        if ([[CartModel sharedCart] UndoCount] == 0) {
            [noti_empty setText:@"还没给宝宝挑选商品哦~"];
              [emptyNotiView setAlpha:1];
            [orderBtn setAlpha:0];
        }else{
            [emptyNotiView setAlpha:0];
            [orderBtn setAlpha:1];
        }
    }
}

@end
