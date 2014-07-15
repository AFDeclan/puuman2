//
//  OrderDetailViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderWaresTableViewCell.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initWithContent];

    }
    return self;
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

- (void)initWithContent
{
    
    
    
    cartTable = [[UITableView alloc] initWithFrame:CGRectMake(32, 112, 540, 168)];
    [cartTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cartTable setShowsVerticalScrollIndicator:NO];
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    [cartTable setBackgroundColor:PMColor5];
    [cartTable setBounces:YES];
    [_content addSubview:cartTable];
    
    detailTable = [[UITableView alloc] initWithFrame:CGRectMake(32, 328, 540, 208)];
    [detailTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [detailTable setShowsVerticalScrollIndicator:NO];
    [detailTable setDelegate:self];
    [detailTable setDataSource:self];
    [detailTable setBackgroundColor:PMColor5];
    [detailTable setBounces:YES];
    [_content addSubview:detailTable];
    
    deleteBtn = [[AFColorButton alloc] init];
    [deleteBtn.title setText:@"取消订单"];
    [deleteBtn adjustLayout];
    [deleteBtn setColorType:kColorButtonGrayColor];
    [deleteBtn setDirectionType:kColorButtonLeftUp];
    [deleteBtn resetColorButton];
    [deleteBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:deleteBtn];
    
    paidBtn = [[AFColorButton alloc] init];
    [deleteBtn.title setText:@"付款"];
    [deleteBtn adjustLayout];
    [deleteBtn setColorType:kColorButtonGrayColor];
    [deleteBtn setDirectionType:kColorButtonLeftDown];
    [deleteBtn resetColorButton];
    [paidBtn addTarget:self action:@selector(paidBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:paidBtn];
    SetViewLeftUp(deleteBtn, 592, 480);
    SetViewLeftUp(paidBtn, 592, 520);
    
    UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(32, 280, 540, 32)];
    [priceView setBackgroundColor:PMColor5];
    [_content addSubview:priceView];
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(540 - 16 - 164, 0, 160, 32)];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setTextAlignment:NSTextAlignmentRight];
    [priceLabel setTextColor:PMColor6];
    [priceLabel setFont:PMFont2];
    [priceLabel setText:@"￥2345.00"];
    [priceView addSubview:priceLabel];
}

- (void)deleteBtnPressed
{

}

- (void)paidBtnPressed
{

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == cartTable) {
        return 2;
    }else{
        
        return 0;
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == cartTable) {
        NSString *identifier = @"OrderCell";
        OrderWaresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[OrderWaresTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else{
        NSString *identifier = @"DetailCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;

    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == cartTable) {
        return 80;
    }else{
        return 0;
    }
}




@end
