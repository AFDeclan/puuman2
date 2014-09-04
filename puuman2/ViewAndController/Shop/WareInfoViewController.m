//
//  WareInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "WareInfoViewController.h"
#import "UILabel+AdjustSize.h"
#import "UniverseConstant.h"
#import "ShopViewController.h"

@interface WareInfoViewController ()

@end

@implementation WareInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [_titleLabel setText:@"单品信息"];
        [self initContent];
        [self initBasicInfoView];

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




- (void)initContent
{
    
    
    shareBtn = [[AFColorButton alloc] init];
    [shareBtn.title setText:@"分享"];
    [shareBtn setColorType:kColorButtonBlueColor];
    [shareBtn setDirectionType:kColorButtonLeftUp];
    [shareBtn resetColorButton];
    [_content addSubview:shareBtn];
    addToCart = [[AFColorButton alloc] init];
    [addToCart.title setText:@"+加入购物车"];
    [addToCart setColorType:kColorButtonBlueColor];
    [addToCart setDirectionType:kColorButtonLeftDown];
    [addToCart resetColorButton];
    [_content addSubview:addToCart];
    SetViewLeftUp(shareBtn,592, 480);
    SetViewLeftUp(addToCart, 592, 520);
    
    infoView = [[WareInfoView alloc] initWithFrame:CGRectMake(48, 378, 504, 224)];
    [_content addSubview:infoView];
    [infoView setBackgroundColor:[UIColor clearColor]];
    
    [infoView setAlpha:0];
    evaluationView = [[WareEvaluationView alloc] initWithFrame:CGRectMake(48, 378, 528, 160)];
    [_content addSubview:evaluationView];
    [evaluationView setBackgroundColor:PMColor5];
    [evaluationView setAlpha:0];
    
    describeBtn = [[AFSelectedImgButton alloc] initWithFrame:CGRectMake(640, 112, 64, 96)];
    [describeBtn setSelectedImg:[UIImage imageNamed:@"btn_rec1_shop"]];
    [describeBtn setUnSelectedImg:[UIImage imageNamed:@"btn_rec2_shop"]];
    [describeBtn addTarget:self action:@selector(describeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:describeBtn];
    
    evaluateBtn = [[AFSelectedImgButton alloc] initWithFrame:CGRectMake(640, 208, 64, 96)];
    [evaluateBtn setSelectedImg:[UIImage imageNamed:@"btn_all1_shop.png"]];
    [evaluateBtn setUnSelectedImg:[UIImage imageNamed:@"btn_all2_shop.png"]];
    [evaluateBtn addTarget:self action:@selector(evaluateBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:evaluateBtn];
    
    [self describeBtnPressed];
    
    
}

- (void)initBasicInfoView
{
    basicInfoView = [[UIView alloc] initWithFrame:CGRectMake(48, 112, 592, 245)];
    [basicInfoView setBackgroundColor:PMColor5];
    [_content addSubview:basicInfoView];
    wareImgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 248, 248)];
    [wareImgView setImage:[UIImage imageNamed:default_ware_image]];
    [wareImgView setBackgroundColor:[UIColor whiteColor]];
    [basicInfoView addSubview:wareImgView];
    wareName  = [[UILabel alloc] initWithFrame:CGRectMake(264, 0, 336, 78)];
    [wareName setTextColor:PMColor2];
    [wareName setBackgroundColor:[UIColor clearColor]];
    [wareName setFont:PMFont2];
    [wareName setText:@"牛真牛牌牛奶粉"];
    [wareName setNumberOfLines:2];
    [basicInfoView addSubview:wareName];
    
    UIImageView *icon_price = [[UIImageView alloc] initWithFrame:CGRectMake(280, 78, 16, 16)];
    [icon_price setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
    [basicInfoView addSubview:icon_price];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(296, 78, 0, 0)];
    [priceLabel setFont:PMFont(32)];
    [priceLabel setTextColor:PMColor6];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setText:@"234."];
    [basicInfoView addSubview:priceLabel];
    [priceLabel adjustSize];
    
    UILabel *price_flag= [[UILabel alloc] initWithFrame:CGRectMake(ViewX(priceLabel)+ViewWidth(priceLabel) , ViewY(priceLabel)+8, 0, 0)];
    [price_flag setFont:PMFont1];
    [price_flag setTextColor:PMColor6];
    [price_flag setBackgroundColor:[UIColor clearColor]];
    [price_flag setText:@"00"];
    [basicInfoView addSubview:price_flag];
    [price_flag adjustSize];
    
    
    UILabel *deliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(264, 170, 48, 24)];
    [deliveryLabel setBackgroundColor:[UIColor clearColor]];
    [deliveryLabel setText:@"送货至"];
    [deliveryLabel setTextColor:PMColor3];
    [deliveryLabel setFont:PMFont2];
    [deliveryLabel setTextAlignment:NSTextAlignmentCenter];
    [basicInfoView addSubview:deliveryLabel];
    
    UILabel *wareNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(264, 208, 48, 24)];
    [wareNumLabel setBackgroundColor:[UIColor clearColor]];
    [wareNumLabel setText:@"数量"];
    [wareNumLabel setTextColor:PMColor3];
    [wareNumLabel setFont:PMFont2];
    [wareNumLabel setTextAlignment:NSTextAlignmentCenter];
    [basicInfoView addSubview:wareNumLabel];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(320, 208, 180, 24)];
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:12];
    [view.layer setBorderWidth:1.0];
    [view.layer setBorderColor:[PMColor3 CGColor]];
    [basicInfoView addSubview:view];
    
    reduceCountBtn = [[SelectedButton alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
    [reduceCountBtn setBackgroundColor:PMColor2];
    [reduceCountBtn setType:kSelectedLeft];
    [reduceCountBtn.icon setImage:[UIImage imageNamed:@"img_reduce_count.png"]];
    [reduceCountBtn.icon setFrame:CGRectMake(0, 0, 12, 3)];
    [reduceCountBtn adjustSize];
    [reduceCountBtn setDelegate:self];
    [view addSubview:reduceCountBtn];
    
    changeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 80, 24)];
    [changeCountLabel setBackgroundColor:[UIColor clearColor]];
    [changeCountLabel setText:@"1"];
    [changeCountLabel setTextColor:PMColor3];
    [changeCountLabel setFont:PMFont2];
    [changeCountLabel setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:changeCountLabel];
    
    addCountBtn = [[SelectedButton alloc] initWithFrame:CGRectMake(130, 0, 50, 24)];
    [addCountBtn setBackgroundColor:PMColor2];
    [addCountBtn setType:kSelectedRight];
    [addCountBtn.icon setImage:[UIImage imageNamed:@"img_add_count.png"]];
    [addCountBtn.icon setFrame:CGRectMake(0, 0, 12, 12)];
    [addCountBtn adjustSize];
    [addCountBtn setDelegate:self];
    [view addSubview:addCountBtn];
    
    
}

- (void)selectedButtonSelectedWithButton:(SelectedButton *)button
{
    
    if (button == addCountBtn) {
        
    } else {
        
    }
}

- (void)describeBtnPressed
{
    [describeBtn selected];
    [evaluateBtn unSelected];
    [UIView animateWithDuration:0.5 animations:^{
        [infoView setAlpha:1];
        [evaluationView setAlpha:0];
    }];
    
}

- (void)evaluateBtnPressed
{
    [evaluateBtn selected];
    [describeBtn unSelected];
    [UIView animateWithDuration:0.5 animations:^{
        [infoView setAlpha:0];
        [evaluationView setAlpha:1];
    }];
}

- (void)hidden
{
    if ([ShopViewController sharedShopViewController].wareInfoShow) {
        [super hidden];
    }
}

@end
