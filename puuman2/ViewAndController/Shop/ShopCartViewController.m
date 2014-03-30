//
//  ShopCartViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopCartViewController.h"
#import "CartTableViewCell.h"

@interface ShopCartViewController ()

@end

@implementation ShopCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initWithContent];
    }
    return self;
}

- (void)initWithContent
{
    isPaid = NO;
    btn_unpaid = [[ColorButton alloc] init];
    [btn_unpaid initWithTitle:@"未付款"  andButtonType:kBlueLeftDown];
    [btn_unpaid addTarget:self action:@selector(unpaidBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:btn_unpaid];
   
    btn_paid= [[ColorButton alloc] init];
    [btn_paid initWithTitle:@"已付款"  andButtonType:kBlueLeftDown];
    [btn_paid addTarget:self action:@selector(paidBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:btn_paid];
    btn_compared= [[ColorButton alloc] init];
    [btn_compared initWithTitle:@"比一比"  andButtonType:kBlueLeftDown];
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
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPaid) {
        static NSString *identify = @"ShopPaidCell";
        CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell =  [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        static NSString *identify = @"ShopUnPaidCell";
        CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell =  [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}



- (void)paidBtnPressed
{
    isPaid = YES;
    [btn_compared setAlpha:0];
}

- (void)unpaidBtnPressed
{
    isPaid = NO;
    [btn_compared setAlpha:1];

}

- (void)comparedBtnPressed
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
