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
    
    
    
    cartTable = [[UITableView alloc] initWithFrame:CGRectMake(80, 112, 540, 168)];
    [cartTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cartTable setShowsVerticalScrollIndicator:NO];
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    [cartTable setBackgroundColor:PMColor5];
    [cartTable setBounces:YES];
    [_content addSubview:cartTable];
    
   
    
    leftBtn = [[ColorButton alloc] init];
    [leftBtn initWithTitle:@"下一步"  andButtonType:kBlueRight];
    [leftBtn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:leftBtn];
    
    rightBtn = [[ColorButton alloc] init];
    [rightBtn initWithTitle:@"上一步"  andButtonType:kBlueLeft];
    [rightBtn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:rightBtn];
    SetViewLeftUp(leftBtn, 0, 520);
    SetViewLeftUp(rightBtn, 592, 520);
    
     goldView = [[UIView alloc] initWithFrame:CGRectMake(0, 268, 704, 56)];
    [goldView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:goldView];
    
    usePumanView = [[UIView alloc] initWithFrame:CGRectMake(80, 4, 540, 40)];
    [usePumanView setBackgroundColor:PMColor5];
    [goldView addSubview:usePumanView];
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 8, 160, 32)];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setTextAlignment:NSTextAlignmentRight];
    [priceLabel setTextColor:PMColor6];
    [priceLabel setFont:PMFont2];
    [priceLabel setText:@"￥2345.00"];
    [usePumanView addSubview:priceLabel];
    
    UIButton *usePuamnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usePuamnBtn setFrame:CGRectMake(0,0, 112, 40)];
    [usePuamnBtn.layer setMasksToBounds:YES];
    [usePuamnBtn.layer setCornerRadius:10];
    [usePuamnBtn setBackgroundColor:PMColor8];
    [usePuamnBtn setTitle:@"使用扑满币" forState:UIControlStateNormal];
    [usePuamnBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 10, 8, 10)];
    [usePuamnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [usePuamnBtn.titleLabel setFont:PMFont2];
    [usePuamnBtn addTarget:self action:@selector(usePumanClick) forControlEvents:UIControlEventTouchUpInside];
    [usePuamnBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [usePumanView addSubview:usePuamnBtn];
    
    UIImageView *goldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-16, 0, 32, 32)];
    [goldImageView setImage:[UIImage imageNamed:@"icon_gold_image.png"]];
    [usePumanView addSubview:goldImageView];
    
    goldCount = 10;
   
    UILabel *goldCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 16, 224, 15)];
    [goldCountLabel setTextColor:PMColor2];
    [goldCountLabel setText:[NSString stringWithFormat:@"可以使用%d扑满币兑现",goldCount]];
    [goldCountLabel setFont:PMFont2];
    [usePumanView addSubview:goldCountLabel];
    
     modifyPumanView = [[UIView alloc] initWithFrame:CGRectMake(80, 4, 540, 40)];
    [modifyPumanView setBackgroundColor:PMColor5];
    [modifyPumanView setAlpha:0];
    [goldView addSubview:modifyPumanView];
    UIButton *modifyPuamnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modifyPuamnBtn setFrame:CGRectMake(0,0, 112, 40)];
    [modifyPuamnBtn.layer setMasksToBounds:YES];
    [modifyPuamnBtn.layer setCornerRadius:10];
    [modifyPuamnBtn setBackgroundColor:PMColor8];
    [modifyPuamnBtn setTitle:@"修改扑满币" forState:UIControlStateNormal];
    [modifyPuamnBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 10, 8, 10)];
    [modifyPuamnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [modifyPuamnBtn.titleLabel setFont:PMFont2];
    [modifyPuamnBtn addTarget:self action:@selector(modifyPumanClick) forControlEvents:UIControlEventTouchUpInside];
    [modifyPuamnBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [modifyPumanView addSubview:modifyPuamnBtn];
    UIImageView *goldImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(-16, 0, 32, 32)];
    [goldImageView2 setImage:[UIImage imageNamed:@"icon_gold_image.png"]];
    [modifyPumanView addSubview:goldImageView2];
    
//    modifyView = [[UILabel alloc] initWithFrame:CGRectMake(360, 8, 200, 32)];
//    [modifyView setBackgroundColor:[UIColor clearColor]];
//    [modifyPumanView addSubview:modifyView];
    
    UILabel *constLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 8, 128, 32)];
    [constLabel setTextAlignment:NSTextAlignmentLeft];
    [constLabel setTextColor:PMColor2];
    [constLabel setText:[NSString stringWithFormat:@"%@-%d=",priceLabel.text,goldCount]];
    [constLabel setFont:PMFont2];
    [modifyPumanView addSubview:constLabel];
    
    modifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(475, 8, 160, 32)];
    [modifyLabel setTextColor:PMColor6];
    [modifyLabel setFont:PMFont2];
    [modifyLabel setText:@"2554.00"];
    [modifyPumanView addSubview:modifyLabel];
    
    usingPumanView = [[UIView alloc] initWithFrame:CGRectMake(80, 4, 540, 40)];
    [usingPumanView setBackgroundColor:PMColor5];
    [usingPumanView setAlpha:0];
    [goldView addSubview:usingPumanView];
    
     UIButton *usingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usingBtn setBackgroundColor:PMColor8];
    [usingBtn setFrame:CGRectMake(215, 0, 120, 40)];
    [usingBtn.layer setMasksToBounds:YES];
    [usingBtn.layer setCornerRadius:10.f];
    [usingBtn setTitle:@"使用" forState:UIControlStateNormal];
    [usingBtn addTarget:self action:@selector(usingClick) forControlEvents:UIControlEventTouchUpInside];
    [usingBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 10, 8, 10)];
    [usingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [usingBtn.titleLabel setFont:PMFont2];
    [usingBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [usingPumanView addSubview:usingBtn];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 225, 40)];
    [view setBackgroundColor:PMColor2];
    [usingPumanView addSubview:view];
    
    
    reduceCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceCountBtn setBackgroundColor:PMColor2];
    [reduceCountBtn setFrame:CGRectMake(0, 0, 75, 40)];
    [reduceCountBtn setImage:[UIImage imageNamed:@"img_reduce_count.png"] forState:UIControlStateNormal];
    reduceCountBtn.imageEdgeInsets = UIEdgeInsetsMake(18, 32, 18, 32);
    [reduceCountBtn addTarget:self action:@selector(reduceBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:reduceCountBtn];
    
    changeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 75, 40)];
    [changeCountLabel setBackgroundColor:[UIColor clearColor]];
    [changeCountLabel setText:@"2"];
    [changeCountLabel setTextColor:[UIColor whiteColor]];
    [changeCountLabel setFont:PMFont1];
    [changeCountLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:changeCountLabel];
    
     addCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCountBtn setBackgroundColor:PMColor2];
    [addCountBtn setFrame:CGRectMake(150, 0, 75, 40)];
    addCountBtn.imageEdgeInsets = UIEdgeInsetsMake(14, 32, 14, 32);
    [addCountBtn setImage:[UIImage imageNamed:@"img_add_count.png"] forState:UIControlStateNormal];
    [addCountBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addCountBtn];
    
    
}

- (void)modifyPumanClick
{
    [modifyPumanView setAlpha:0];
    [usingPumanView setAlpha:0];
    [usePumanView setAlpha:1];
    [usePumanView addSubview:priceLabel];
}


- (void)usePumanClick
{
    [usingPumanView setAlpha:1];
    [usingPumanView addSubview:priceLabel];
    [usePumanView setAlpha:0];
    [modifyPumanView setAlpha:0];
}

- (void)usingClick
{
    [usePumanView setAlpha:0];
    [usingPumanView setAlpha:0];
    [modifyPumanView setAlpha:1];


}

- (void)addBtn
{
    count ++;
    changeCountLabel.text = [NSString stringWithFormat:@"%i",count];
    
}

- (void)reduceBtn
{
    if (count <= 0) {
        
        return;
    }
    count --;
    changeCountLabel.text = [NSString stringWithFormat:@"%i",count];


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
