//
//  ShopCartViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopCartViewController.h"
#import "CartTableViewCell.h"
#import "CartModel.h"
#import "MainTabBarController.h"
#import "CompareCartViewController.h"

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
    [self unpaidBtnPressed];
}

- (void)refreshCartTable
{
    unfoldIndex = -1;
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
 
    
    [cell buildCellWithPaid:isPaid andWareIndex:[indexPath row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}



- (void)paidBtnPressed
{
    isPaid = YES;
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
    [btn_compared setAlpha:1];
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



@end
