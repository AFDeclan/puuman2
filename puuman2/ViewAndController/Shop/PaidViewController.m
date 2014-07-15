//
//  PaidViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PaidViewController.h"
#import "OrderWaresTableViewCell.h"

@interface PaidViewController ()

@end

@implementation PaidViewController

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
    
   
    
    leftBtn = [[AFColorButton alloc] init];
    [leftBtn.title setText:@"下一步" ];
    [leftBtn setColorType:kColorButtonBlueColor];
    [leftBtn setDirectionType:kColorButtonRight];
    [leftBtn resetColorButton];
    [leftBtn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:leftBtn];
    
    rightBtn = [[AFColorButton alloc] init];
    [rightBtn.title setText:@"上一步" ];
    [rightBtn setColorType:kColorButtonBlueColor];
    [rightBtn setDirectionType:kColorButtonLeft];
    [rightBtn resetColorButton];
    [rightBtn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:rightBtn];
    SetViewLeftUp(leftBtn, 0, 520);
    SetViewLeftUp(rightBtn, 592, 520);
    
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

- (void)leftBtnPressed
{
    
}

- (void)rightBtnPressed
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"OrderCell";
    OrderWaresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OrderWaresTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
