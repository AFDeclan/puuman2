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
#import "UserInfo.h"
#import "CustomNotiViewController.h"

@interface ShopWebViewController ()

@end
#define WaitTime 2
@implementation ShopWebViewController
@synthesize delegate = _delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _expanded=NO;
        recShop = NO;
        [self initWithContent];

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
    [otherShopButton setTitleFont:PMFont2];
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
    
    
    noti_Name = [[UILabel alloc] initWithFrame:CGRectMake(144, 64, 96, 16)];
    [noti_Name setTextColor:PMColor2];
    [noti_Name setFont:PMFont3];
    [noti_Name setText:@"您在浏览："];
    [noti_Name setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:noti_Name];
    
    noti_Price = [[UILabel alloc] initWithFrame:CGRectMake(144, 96, 96, 16)];
    [noti_Price setTextColor:PMColor2];
    [noti_Price setFont:PMFont3];
    [noti_Price setText:@"价格范围："];
    [noti_Price setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:noti_Price];
    
    
    _lowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(208.0, 96.0, 72.0, 16.0)];
    [_lowPriceLabel setTextColor:PMColor6];
    [_lowPriceLabel setFont:PMFont2];
    [_lowPriceLabel setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:_lowPriceLabel];
    
    _highPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(592.0, 96.0, 72.0, 16.0)];
    [_highPriceLabel setTextColor:PMColor1];
    [_highPriceLabel setFont:PMFont2];
    [_highPriceLabel setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:_highPriceLabel];

    _wName = [[UILabel alloc] initWithFrame:CGRectMake(208.0, 64.0, 432.0, 18.0)];
    [_wName setTextColor:PMColor1];
    [_wName setFont:PMFont2];
    [_wName setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:_wName];

    bg_progress = [[UIView alloc] initWithFrame:CGRectMake(280, 102, 296, 2)];
    [bg_progress setBackgroundColor:PMColor2];
    [_content addSubview:bg_progress];
    
    _progress = [[UIView alloc] init];
    [_progress setBackgroundColor:PMColor6];
    [_content addSubview:_progress];
    

    myWebView = [[UIWebView alloc] init];
    myWebView.delegate = self;
    [_content addSubview:myWebView];
    
    maskWeb = [[UIView alloc] init];
    [maskWeb setBackgroundColor:PMColor1];
    [maskWeb setAlpha:0];
    [_content addSubview:maskWeb];
    
    
    _shopsTableView=[[UITableView alloc]initWithFrame:CGRectMake(752, 128, 0, 888)];
    _shopsTableView.delegate=self;
    _shopsTableView.dataSource=self;
    [_shopsTableView setBackgroundColor:[UIColor clearColor]];
    [_shopsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_content addSubview:_shopsTableView];
    
 
    pointImgView =[ [UIImageView alloc] initWithImage:[UIImage imageNamed:@"point_br_shop.png"]];
    [_content addSubview:pointImgView];
    
    shareBtn =[[ColorButton alloc] init];
    [shareBtn initWithTitle:@"分享" andIcon:[UIImage imageNamed:@"btn_share_diary.png"] andButtonType:kGrayLeftUp];
    [shareBtn addTarget:self action:@selector(shareWare) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:shareBtn];
    shareBtn.alpha = 0;
    
    addBtn = [[ColorButton alloc] init];
    [addBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:addBtn];
    SetViewLeftUp(shareBtn, 640, 656);
    SetViewLeftUp(addBtn, 640, 696);
    
    _shopsInfo=[[NSArray alloc] init];
    _ware=[[Ware alloc] init];
    
}

- (void)shareWare
{

}

- (void)addToCart {
    [addBtn setEnabled:NO];
    [MobClick event:umeng_event_click label:@"addToCart_SingleGoodViewController"];
    [[CartModel sharedCart] addWareIntoCart:_ware];
    [addBtn initWithTitle:@"已加入购物车"  andButtonType:kBlueLeftDown];
    [CustomNotiViewController showNotiWithTitle:@"添加成功" withTypeStyle:kNotiTypeStyleRight];
    [_delegate cartStatusUpdate];
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
    recShop = NO;
    
    if ([[CartModel sharedCart] wareIsInCart:ware])
    {
        [addBtn setEnabled:NO];
        [addBtn initWithTitle:@"已加入购物车"  andButtonType:kBlueLeftDown];
        
    }else{
        [addBtn setEnabled:YES];
        [addBtn initWithTitle:@"+加入购物车"  andButtonType:kBlueLeftDown];
    }
    
    [myWebView.scrollView setDelegate:self];
    _ware=ware;
    _shopsInfo=shopsInfo;
    _shopIndex=index;
   // if (![self keyUrlForPaid])
        [self startTimer:WaitTime];
    [_shopsTableView reloadData];
    _recShopName = [[_shopsInfo objectAtIndex:_shopIndex] objectForKey:kShopNameKey];
    [self loadWebPageWithString:[[shopsInfo objectAtIndex:index] valueForKey:kShopLinkKey]   WithShop:[[shopsInfo objectAtIndex:index] valueForKey:kShopNameKey] WithWare:ware.WName WID:ware.WID ShopIndex:[[[shopsInfo objectAtIndex:index] valueForKey:kShopIndexKey] integerValue]];
}

- (void)otherShop
{
    CGRect frame=_shopsTableView.frame;
    if (_expanded) {
        
        frame.origin.x=760;
        frame.size.width=0;
        [UIView animateWithDuration:0.7
                         animations:^{
                             _shopsTableView.frame=frame;
                             icon_shoptri.transform=CGAffineTransformMakeRotation(0);
                             maskWeb.alpha=0;
                         }completion:^(BOOL finished) {
                              [_shopsTableView reloadData];
                         }];
        
    }else
    {
        frame.origin.x=502;
        frame.size.width=250;
        [UIView animateWithDuration:0.7
                         animations:^{
                             _shopsTableView.frame=frame;
                             icon_shoptri.transform=CGAffineTransformMakeRotation(90*M_PI/180);
                             maskWeb.alpha=0.5;
                         }];
        
    }
    _expanded=!_expanded;

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
    
    if (puumanVC) {
        [puumanVC hidden];
    }
    
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
    [maskWeb setFrame:CGRectMake(16, 128, 736, 896)];
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(128, 0, 768, 768)];
    [myWebView setFrame:CGRectMake(16, 128, 736, 640)];
     [maskWeb setFrame:CGRectMake(16, 128, 736, 640)];
    
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
{
    static NSString *identify = @"OtherShopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(68,0, 96, 64)];
        labelTitle.font = PMFont3;
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.tag = 2;
        [cell.contentView addSubview:labelTitle];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(154, 0, 80, 64)];
        [label setTextAlignment:NSTextAlignmentRight];
        label.font = PMFont3;
        label.textColor = PMColor7;
        label.backgroundColor = [UIColor clearColor];
        label.tag = 3;
        [cell.contentView addSubview:label];
        UIImageView *icon_tri = [[UIImageView alloc] initWithFrame:CGRectMake(16, 18, 16, 28)];
        [icon_tri setImage:[UIImage imageNamed:@"tri_white_left.png"]];
        [cell.contentView addSubview:icon_tri];
        UIImageView *icon_part = [[UIImageView alloc] initWithFrame:CGRectMake(0, 62, 250, 2)];
        [icon_part setImage:[UIImage imageNamed:@"line1_baby.png"]];
        [cell.contentView addSubview:icon_part];
        
        
    }
   
    NSInteger row=indexPath.row;
    if (_shopIndex<=row) {
        row++;
    }
    UILabel *priceLabel = (UILabel *)[cell.contentView viewWithTag:2];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",[[_shopsInfo objectAtIndex:row] objectForKey:kPriceKey]] ;
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:3];
    nameLabel.text = [[_shopsInfo objectAtIndex:row] objectForKey:kShopNameKey];
    [cell setBackgroundColor:PMColor6];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 64;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_payBackViewController)
//    {
//        [_payBackViewController.view removeFromSuperview];
//        _payBackViewController = nil;
//    }
    NSInteger row=[indexPath row];
    if (_shopIndex<=row) {
        row++;
    }
    _shopIndex=row;
    [_timer invalidate];
    _timer = nil;
    if (![self keyUrlForPaid])
        [self startTimer:WaitTime];
    [self loadWebPageWithString:[[_shopsInfo objectAtIndex:row] valueForKey:kShopLinkKey]   WithShop:[[_shopsInfo objectAtIndex:row] valueForKey:kShopNameKey] WithWare:_ware.WName WID:_ware.WID ShopIndex:[[[_shopsInfo objectAtIndex:row] valueForKey:kShopIndexKey] integerValue]];
   
    [self otherShop];
}

- (void)loadWebPageWithString:(NSString*)urlString WithShop:(NSString*) shopName WithWare:(NSString*) wareName WID:(NSInteger)wid ShopIndex:(NSInteger)shopIndex
{
    NSRange identyRange = [urlString rangeOfString:@"APIPUMAN99"];
    NSString *identyString = [NSString stringWithFormat:@"%d_%d_%d", (int)[UserInfo sharedUserInfo].UID, (int)wid, (int)shopIndex];
    if (identyRange.location != NSNotFound) {
        urlString = [urlString stringByReplacingCharactersInRange:identyRange withString:identyString];
    }
    
    //    NSLog(@"url2:%@", urlString);
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
   
    [myWebView loadRequest:request];
    
    if (_ware.WPriceUB == _ware.WPriceLB ) {
        [noti_Price setAlpha:0];
        [bg_progress setAlpha:0];
        [_progress setAlpha:0];
        if ([_shopsInfo count] <= 1) {
            [_shopsTableView setAlpha:0];
            [icon_shoptri setAlpha:0];
            [otherShopButton setAlpha:0];
        }
        
    }else{

        double price = [[[_shopsInfo objectAtIndex:_shopIndex] valueForKey:kPriceKey] doubleValue];
        double width = (price-_ware.WPriceLB)*296/(_ware.WPriceUB-_ware.WPriceLB);
        _progress.frame = CGRectMake(280, 102,width,  3);
        pointImgView.frame=CGRectMake(280+width-16, 88, 32, 20);
        [_lowPriceLabel setText:[NSString stringWithFormat:@"%.2f",_ware.WPriceLB]];
        [_highPriceLabel setText:[NSString stringWithFormat:@"%.2f",_ware.WPriceUB]];
    }
    [_wName setText:wareName];
    
    shopImg.backgroundColor = [UIColor clearColor];
    [shopImg getImage:_ware.WPicLink defaultImage:default_ware_image];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * url =  request.URL.description;
    if (![self keyUrlForPaid]) {
        [self startTimer:WaitTime];
        return YES;
    }
    if ([url rangeOfString:[self keyUrlForPaid]].location != NSNotFound)
    {
        [self startTimer:WaitTime];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
    if (!webView.canGoBack) {
         [backButton unSelected];
        [backButton setEnabled:NO];
    }else{
         [backButton selected];
        [backButton setEnabled:YES];
    }
    if (!webView.canGoForward) {
        [forwardButton unSelected];
        [forwardButton setEnabled:NO];
    }else{
        [forwardButton selected];
        [forwardButton setEnabled:YES];
    }
}

- (void)setRecWebUrl:(NSString *)urlString  wareName:(NSString *)wName wareId:(NSInteger)WID warePrice:(CGFloat)price shopName:(NSString *)sName shopIndex:(NSInteger)shopIndex imgLink:(NSString *)picLink
{
    recShop = YES;
    _recShopName = sName;
    [_shopsTableView setAlpha:0];
    [icon_shoptri setAlpha:0];
    [otherShopButton setAlpha:0];
    [noti_Price setAlpha:0];
    [bg_progress setAlpha:0];
    [_progress setAlpha:0];
    NSRange identyRange = [urlString rangeOfString:@"APIPUMAN99"];
    NSString *identyString = [NSString stringWithFormat:@"%d_%d_%d", [UserInfo sharedUserInfo].UID, WID, shopIndex];
    if (identyRange.location != NSNotFound) {
        urlString = [urlString stringByReplacingCharactersInRange:identyRange withString:identyString];
    }
    
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    [_wName setText:wName];
    [shopImg getImage:picLink defaultImage:default_ware_image];
    if (![self keyUrlForPaid])
        [self startTimer:WaitTime];
    
}


- (NSString *)keyUrlForPaid
{
    if (!recShop) {
        NSInteger shopIndex = [[[_shopsInfo objectAtIndex:0] valueForKey:kShopIndexKey] integerValue];
        switch (shopIndex) {
            case 1:
                //京东商城
                return @"pay.jd.com";
            case 2:
                //当当
                return @"payment.dangdang.com";
            case 3:
                //亚马逊
                return @"www.amazon.cn/gp/buy";
                //        case 4:
                
            default:
                return nil;
        }
    }else{
        
        
        if ([_recShopName isEqualToString:@"京东商城"]) {
            return @"pay.jd.com";
        }else if ([_recShopName isEqualToString:@"当当"]) {
            return @"payment.dangdang.com";
        }else if ([_recShopName isEqualToString:@"亚马逊"]) {
            return @"www.amazon.cn/gp/buy";
        }else{
            return nil;
            
        }
    }
    
}

- (void)startTimer:(NSTimeInterval)interval;
{
    if (puumanVC) {
        [puumanVC hidden];
    }

    if (![UserInfo sharedUserInfo].logined) return;
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(showPayBackView) userInfo:nil repeats:NO];
}

- (void)showPayBackView
{
    puumanVC = [[PuumanShopViewController alloc] initWithNibName:nil bundle:nil];
    [puumanVC setWid:_ware.WID];
    [puumanVC setShop:_recShopName];
    [self.view addSubview:puumanVC.view];
    [puumanVC showPuumanShop];
    
}

@end
