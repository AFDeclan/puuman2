//
//  ShopWebViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopWebViewController.h"
#import "MainTabBarController.h"
#import "CartModel.h"

@interface ShopWebViewController ()

@end

@implementation ShopWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
        [self initWithContent];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)initWithContent
{
    bg_content = [[UIView alloc] initWithFrame:CGRectMake(0, 16, 768, 1008)];
    [bg_content setBackgroundColor:PMColor5];
    [_content addSubview:bg_content];
    [self initCloseBtn];
    
    shopImg = [[AFImageView alloc] initWithFrame:CGRectMake(16, 8, 112, 112)];
    [shopImg setBackgroundColor:PMColor6];
    [_content addSubview:shopImg];

    
    icon_shoptri = [[UIImageView alloc] initWithFrame:CGRectMake(736, 88, 16, 28)];
    [icon_shoptri setImage:[UIImage imageNamed:@"tri_blue_right.png"]];
    [_content addSubview:icon_shoptri];
    
    otherShopButton  = [[AFTextImgButton alloc] initWithFrame:CGRectMake(640, 88, 96, 28)];
    [otherShopButton setTitle:@"其他商城" andImg:nil  andButtonType:kButtonTypeSix];
    [otherShopButton setTitleLabelColor:PMColor6];
    [otherShopButton addTarget:self action:@selector(otherShop) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:otherShopButton];
    
   
    
    backButton  = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(144, 24,32, 32)];
    [backButton setSelectedImg:[UIImage imageNamed:@"btn_back_br_shop.png"] andUnselectedImg:[UIImage imageNamed:@"btn_back2_br_shop.png"] andTitle:@"" andButtonType:kButtonTypeSeven andSelectedType:kNoneClear];
    [backButton addTarget:self action:@selector(backButtonPush) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:backButton];
    [backButton unSelected];
    forwardButton = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(192, 24, 32, 32)];
    [forwardButton setSelectedImg:[UIImage imageNamed:@"btn_back3_br_shop.png"] andUnselectedImg:[UIImage imageNamed:@"btn_back4_br_shop.png"] andTitle:@"" andButtonType:kButtonTypeSeven andSelectedType:kNoneClear];
    [forwardButton addTarget:self action:@selector(forwardButtonPush) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:forwardButton];
    [forwardButton unSelected];
    reloadButton = [[AFTextImgButton alloc] initWithFrame:CGRectMake(240, 24, 32, 32)];
    [reloadButton setTitle:@"" andImg:[UIImage imageNamed:@"btn_refresh_br_shop.png"]  andButtonType:kButtonTypeSeven];
    [reloadButton setIconFrame:CGRectMake(0, 0, 24, 24)];
    [reloadButton addTarget:self action:@selector(reloadButtonPush) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:reloadButton];
    
       shareBtn =[[ColorButton alloc] init];
    [shareBtn initWithTitle:@"分享" andIcon:[UIImage imageNamed:@"btn_share_diary.png"] andButtonType:kGrayLeftUp];
    [shareBtn addTarget:self action:@selector(shareWare) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:shareBtn];
    addBtn = [[ColorButton alloc] init];
    [addBtn initWithTitle:@"+加入购物车"  andButtonType:kBlueLeftDown];
    [addBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:addBtn];
    SetViewLeftUp(shareBtn, 592, 480);
    SetViewLeftUp(addBtn, 592, 520);

    _shopsTableView=[[UITableView alloc]initWithFrame:CGRectMake(760, 128, 0, 888)];
    _shopsTableView.delegate=self;
    _shopsTableView.dataSource=self;
    [_shopsTableView setBackgroundColor:[UIColor clearColor]];
    [_shopsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myWebView = [[UIWebView alloc] init];
    [_content addSubview:myWebView];
    _shopsInfo=[[NSArray alloc] init];
    _ware=[[Ware alloc] init];
    
}

- (void)shareWare
{

}

- (void)addToCart {
    
    [MobClick event:umeng_event_click label:@"addToCart_SingleGoodViewController"];
    [[CartModel sharedCart] addWareIntoCart:_ware];
    //    [CustomAlertView showInView:nil content:[NSString stringWithFormat:@"   您将商品 %@ 加入了购物车", _ware.WName]];
}

- (void)backButtonPush {
    
    [MobClick event:umeng_event_click label:@"Back_WebViewController"];
    if (myWebView.canGoBack)
    {
        [myWebView goBack];
    }
}

- (void)forwardButtonPush {
    [MobClick event:umeng_event_click label:@"Forward_WebViewController"];
    if (myWebView.canGoForward)
    {
        [myWebView goForward];
    }
}

- (void)reloadButtonPush {
    [MobClick event:umeng_event_click label:@"Reload_WebViewController"];
    [myWebView reload];
}






- (void)setWare:(Ware *)ware shops:(NSArray *)shopsInfo firstIndex:(NSInteger)index
{

    if ([shopsInfo count]==1) {
        otherShopButton.alpha = 0;
        icon_shoptri.alpha = 0;
    }
    [myWebView.scrollView setDelegate:self];
    _ware=ware;
    _shopsInfo=shopsInfo;
    shopIndex=index;
//    if (![self keyUrlForPaid])
//        [self startTimer:WaitTime];
    [_shopsTableView reloadData];
    
   // [self loadWebPageWithString:[[shopsInfo objectAtIndex:index] valueForKey:kShopLinkKey]   WithShop:[[shopsInfo objectAtIndex:index] valueForKey:kShopNameKey] WithWare:ware.WName WID:ware.WID ShopIndex:[[[shopsInfo objectAtIndex:index] valueForKey:kShopIndexKey] integerValue]];
}

- (void)otherShop
{

}

- (void)initCloseBtn
{
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(702, 32, 48, 48)];
    [_closeBtn setImage:[UIImage imageNamed:@"btn_close1.png"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_closeBtn];
}

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    
}


- (void)closeBtnPressed
{
    myWebView.delegate = nil;
    [myWebView stopLoading];
    [self hidden];
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
    [self.view removeFromSuperview];
}

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(0, 0, 768, 1024)];
    [myWebView setFrame:CGRectMake(16, 128, 736, 896)];
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(128, 0, 768, 768)];
    [myWebView setFrame:CGRectMake(16, 128, 736, 640)];
    
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

#pragma mark - Table view delegation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shopsInfo count]-1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{        static NSString *identify = @"ShopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:identify owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    int row=indexPath.row;
    if (shopIndex<=row) {
        row++;
    }
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:1];
    priceLabel.text = [[_shopsInfo objectAtIndex:row] objectForKey:kPriceKey];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    nameLabel.text = [[_shopsInfo objectAtIndex:row] objectForKey:kShopNameKey];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_payBackViewController)
//    {
//        [_payBackViewController.view removeFromSuperview];
//        _payBackViewController = nil;
//    }
//    int row=indexPath.row;
//    if (_index<=row) {
//        row++;
//    }
//    _index=row;
//    [_timer invalidate];
//    _timer = nil;
//    if (![self keyUrlForPaid])
//        [self startTimer:WaitTime];
//    [self loadWebPageWithString:[[_shopsInfo objectAtIndex:row] valueForKey:kShopLinkKey]   WithShop:[[_shopsInfo objectAtIndex:row] valueForKey:kShopNameKey] WithWare:_ware.WName WID:_ware.WID ShopIndex:[[[_shopsInfo objectAtIndex:row] valueForKey:kShopIndexKey] integerValue]];
//    [_shopsTableView reloadData];
//    [self otherShops:self.otherShopButton];
}


@end
