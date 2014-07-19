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
#import "ShopCartTableViewCell.h"
#import "OrderWaresTableViewCell.h"
#import "OrderWaresHeaderView.h"
#import "OrderWaresFooterView.h"

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
    }
    return self;
}

- (void)initWithContent
{
    
    cartShowBtn = [[AFColorButton alloc] init];
    [cartShowBtn.title setText:@"购物车" ];
    [cartShowBtn setColorType:kColorButtonBlueColor];
    [cartShowBtn setDirectionType:kColorButtonLeftUp];
    [cartShowBtn resetColorButton];
    [cartShowBtn addTarget:self action:@selector(cartShowBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:cartShowBtn];
   
    orderShowBtn= [[AFColorButton alloc] init];
    [orderShowBtn.title setText:@"订单" ];
    [orderShowBtn setColorType:kColorButtonBlueColor];
    [orderShowBtn setDirectionType:kColorButtonLeftDown];
    [orderShowBtn resetColorButton];
    [orderShowBtn addTarget:self action:@selector(orderShowBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:orderShowBtn];
    
    deleteBtn = [[AFColorButton alloc] init];
    [deleteBtn.title setText:@"删除" ];
    [deleteBtn setColorType:kColorButtonRedColor];
    [deleteBtn setDirectionType:kColorButtonLeftUp];
    [deleteBtn resetColorButton];
    [deleteBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:deleteBtn];
    
    orderBtn = [[AFColorButton alloc] init];
    [orderBtn.title setText:@"下单" ];
    [orderBtn setColorType:kColorButtonBlueColor];
    [orderBtn setDirectionType:kColorButtonLeftDown];
    [orderBtn resetColorButton];
    [orderBtn addTarget:self action:@selector(orderBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:orderBtn];
    
 

    SetViewLeftUp(cartShowBtn, 592, 112);
    SetViewLeftUp(orderShowBtn, 592, 152);
    SetViewLeftUp(deleteBtn, 592, 480);
    SetViewLeftUp(orderBtn, 592, 520);

    cartTable = [[UITableView alloc] initWithFrame:CGRectMake(32, 112, 540, 448)];
    [cartTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cartTable setShowsVerticalScrollIndicator:NO];
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    [cartTable setBackgroundColor:[UIColor clearColor]];
    [cartTable setBounces:YES];
    [cartTable setAlpha:1];
    [_content addSubview:cartTable];
    
    orderTable = [[UITableView alloc] initWithFrame:CGRectMake(32, 112, 540, 448)];
    [orderTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [orderTable setShowsVerticalScrollIndicator:NO];
    [orderTable setDelegate:self];
    [orderTable setDataSource:self];
    [orderTable setBackgroundColor:[UIColor clearColor]];
    [orderTable setBounces:YES];
    [orderTable setAlpha:1];
    [_content addSubview:orderTable];
    [cartTable setAlpha:0];
    [orderTable setAlpha:0];
    
//    emptyNotiView = [[UIView alloc] initWithFrame:CGRectMake(216, 256, 224, 144)];
//    [_content addSubview:emptyNotiView];
//    UIImageView  *icon_empty = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 224, 96)];
//    [icon_empty setImage:[UIImage imageNamed:@"pic_cart_blank.png"]];
//    [emptyNotiView addSubview:icon_empty];
//    noti_empty = [[UILabel alloc] initWithFrame:CGRectMake(0, 96, 224, 48)];
//    [noti_empty setFont:PMFont4];
//    [noti_empty setTextColor:PMColor3];
//    [noti_empty setTextAlignment:NSTextAlignmentCenter];
//    [noti_empty setBackgroundColor:[UIColor clearColor]];
//    [emptyNotiView addSubview:noti_empty];
    
    [self cartShowBtnPressed];
   
   
}

- (void)refreshCartTable
{
    [cartTable reloadData];
}
#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == cartTable) {
        return 1;

    }else{
        return 6;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == cartTable) {
        return 2;

    }else{
        return 3;

    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if(tableView == cartTable)
    {
        NSString *identifier = @"CartCell";
        ShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ShopCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell setSelectedWare:YES];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        NSString *identifier = @"OrderCell";
        OrderWaresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[OrderWaresTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
      

    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == cartTable) {
        return 164;
    }else{
        return 80;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderWaresHeaderView *view = [[OrderWaresHeaderView alloc] initWithFrame:CGRectMake(0, 0, 528, 48)];
    [view setSection:section];
    return view;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == cartTable) {
        return 0;
    }
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == cartTable) {
        return 0;
    }else{
        if(section == 1){
            return 32;
        }else{
            return 56;
            
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderWaresFooterView *view = [[OrderWaresFooterView alloc] initWithFrame:CGRectMake(0, 0, 540, 56)];
    [view setSection:section];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//        Ware* w = [[CartModel sharedCart] getUndoWareAtIndex:[indexPath row]];
//        SinglepopViewController *singGoodVC = [[SinglepopViewController alloc] initWithNibName:nil bundle:nil];
//        [singGoodVC setControlBtnType:kOnlyCloseButton];
//        [singGoodVC setTitle:@"单品信息" withIcon:nil];
//        [singGoodVC setWare:w];
//        [[MainTabBarController sharedMainViewController].view addSubview:singGoodVC.view];
//        [singGoodVC show];

}


- (void)cartShowBtnPressed
{
    [self setTitle:@"购物车" withIcon:nil];
    [orderShowBtn unSelected];
    [cartShowBtn selected];
    [cartTable reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        [orderBtn setAlpha:1];
        [cartTable setAlpha:1];
        [orderTable setAlpha:0];
        [deleteBtn setAlpha:1];
    }];
}

- (void)orderShowBtnPressed
{
    [self setTitle:@"我的订单" withIcon:nil];
    [orderShowBtn selected];
    [cartShowBtn unSelected];
    [orderTable reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        [orderBtn setAlpha:0];
        [cartTable setAlpha:0];
        [orderTable setAlpha:1];
        [deleteBtn setAlpha:0];
    }];
}


- (void)orderBtnPressed
{
   


}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            [noti_empty setText: @"您还没有购买的商品哦~"];
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

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
 
    
}

- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}



- (void)finishOut
{
    [super dismiss];
    if ([self.delegate respondsToSelector:@selector(popViewfinished)]) {
        [self.delegate popViewfinished];
    }
    [self.view removeFromSuperview];
}



- (void)deleteBtnPressed
{
    
}

@end
