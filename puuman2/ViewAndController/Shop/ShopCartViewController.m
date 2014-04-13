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
    btn_unpaid = [[ColorButton alloc] init];
    [btn_unpaid initWithTitle:@"未付款"  andButtonType:kBlueLeftUp];
    [btn_unpaid addTarget:self action:@selector(unpaidBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:btn_unpaid];
   
    btn_paid= [[ColorButton alloc] init];
    [btn_paid initWithTitle:@"已付款"  andButtonType:kBlueLeftDown];
    [btn_paid addTarget:self action:@selector(paidBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:btn_paid];
    btn_compared= [[ColorButton alloc] init];
    [btn_compared initWithTitle:@"比一比"  andButtonType:kBlueLeft];
    [btn_compared addTarget:self action:@selector(comparedBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:btn_compared];
    SetViewLeftUp(btn_unpaid, 592, 480);
    SetViewLeftUp(btn_paid, 592, 520);
    SetViewLeftUp(btn_compared, 592, 112);
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
    
    [self unpaidBtnPressed];
   
   
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


- (void)paidBtnPressed
{
    isPaid = YES;
    [self emptyWithPaid:isPaid];
    [btn_compared setAlpha:0];
    [btn_unpaid unSelected];
    [btn_paid selected];
    [cartTable reloadData];
    
}

- (void)unpaidBtnPressed
{
    
    [btn_unpaid selected];
    [btn_paid unSelected];
    isPaid = NO;
    [self emptyWithPaid:isPaid];
    [cartTable reloadData];
   
}

- (void)comparedBtnPressed
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
            [btn_compared setAlpha:0];
        }else{
            [emptyNotiView setAlpha:0];
            [btn_compared setAlpha:1];
        }
    }
}

@end
