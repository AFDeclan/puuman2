//
//  SinglepopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SinglepopViewController.h"
#import "ColorsAndFonts.h"
#import "CartModel.h"
#import "MainTabBarController.h"
#import "CustomNotiViewController.h"

#define ShopNameNum 127
@interface SinglepopViewController ()

@end

@implementation SinglepopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIView *bgInfoView = [[UIView alloc] initWithFrame:CGRectMake(298, 112, 406, 142)];
        [bgInfoView setBackgroundColor:PMColor5];
        [_content addSubview:bgInfoView];
        
        
        UIImageView *rmb_icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 20, 20)];
        [rmb_icon setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
        [bgInfoView addSubview:rmb_icon];
        
        wareImgView = [[AFImageView alloc] initWithFrame:CGRectMake(48, 112, 250, 250)];
        [_content addSubview:wareImgView];
        
        _shopsTableView = [[UITableView alloc] initWithFrame:CGRectMake(48, 362, 250, 246)];
        [_shopsTableView setDataSource:self];
        [_shopsTableView setDelegate:self];
        [_content addSubview:_shopsTableView];
        [_shopsTableView setBackgroundColor:PMColor6];
        [_shopsTableView setSeparatorColor:[UIColor clearColor]];
        [_shopsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_shopsTableView setShowsHorizontalScrollIndicator:NO];
        [_shopsTableView setShowsVerticalScrollIndicator:NO];
    
        _propertyTableView = [[UITableView alloc] initWithFrame:CGRectMake(320, 272, 300, 256)];
        [_propertyTableView setDataSource:self];
        [_propertyTableView setDelegate:self];
        [_content addSubview:_propertyTableView];
        [_propertyTableView setBackgroundColor:[UIColor clearColor]];
        [_propertyTableView setSeparatorColor:[UIColor clearColor]];
        [_propertyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_propertyTableView setShowsHorizontalScrollIndicator:NO];
        [_propertyTableView setShowsVerticalScrollIndicator:NO];

        
        _lowPriceIntLabel = [[UILabel alloc] init];
        _lowPriceIntLabel.backgroundColor = [UIColor clearColor];
        _lowPriceIntLabel.textColor = PMColor6;
        _lowPriceIntLabel.font = PMFont(32);
        [_content addSubview:_lowPriceIntLabel];
        _lowPriceFracLabel = [[UILabel alloc] init];
        _lowPriceFracLabel.backgroundColor = [UIColor clearColor];
        _lowPriceFracLabel.textColor = PMColor6;
        _lowPriceFracLabel.font = PMFont1;
        [_content addSubview:_lowPriceFracLabel];
        _highPriceLabel = [[UILabel alloc] init];
        _highPriceLabel.backgroundColor = [UIColor clearColor];
        _highPriceLabel.textColor = PMColor1;
        _highPriceLabel.font = PMFont1;
        [_content addSubview:_highPriceLabel];
        
      
        wareNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(328, 128,356,64)];
        wareNameLabel.backgroundColor = [UIColor clearColor];
        wareNameLabel.textColor = PMColor1;
        wareNameLabel.font = PMFont1;
        [_content addSubview:wareNameLabel];
    
//        shareBtn =[[ColorButton alloc] init];
//        [shareBtn initWithTitle:@"分享" andIcon:[UIImage imageNamed:@"btn_share_diary.png"] andButtonType:kGrayLeftUp];
//        [shareBtn addTarget:self action:@selector(shareWare) forControlEvents:UIControlEventTouchUpInside];
//        [_content addSubview:shareBtn];
//        SetViewLeftUp(shareBtn, 592, 480);
        
//        addBtn = [[ColorButton alloc] init];
//        [addBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
//        [_content addSubview:addBtn];
//        SetViewLeftUp(addBtn, 592, 520);
        addBtn = [[ColorButton alloc] init];
        [addBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:addBtn];
        SetViewLeftUp(addBtn, 592, 520);

    }
    return self;
}

- (void)initWithContent
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

- (void)setWare:(Ware *)w
{
    _ware = w;
    
    if ([[CartModel sharedCart] wareIsInCart:_ware])
    {
        [addBtn setEnabled:NO];
//        [addBtn initWithTitle:@"已加入购物车"  andButtonType:kBlueLeftDown];
        [addBtn initWithTitle:@"已加入购物车"  andButtonType:kBlueLeft];
        
    }else{
        [addBtn setEnabled:YES];
//        [addBtn initWithTitle:@"+加入购物车"  andButtonType:kBlueLeftDown];
        [addBtn initWithTitle:@"+加入购物车"  andButtonType:kBlueLeft];

    }
    
    //图片
    [wareImgView getImage:w.WPicLink defaultImage:default_ware_image];
    wareNameLabel.textColor = PMColor1;
    wareNameLabel.font=PMFont2;
    
    CGSize Labelsize = [w.WName sizeWithFont:PMFont2 constrainedToSize:CGSizeMake(wareNameLabel.frame.size.width, CGFLOAT_MAX)];
    CGAffineTransform transform =  wareNameLabel.transform;
    wareNameLabel.transform = CGAffineTransformIdentity;
    CGRect frame =  wareNameLabel.frame;
    frame.size.height = Labelsize.height;
    wareNameLabel.frame = frame;
    wareNameLabel.transform = transform;
    wareNameLabel.numberOfLines = 3;
    
    
    
    //名称
    wareNameLabel.text = w.WName;
    //价格
    double lowPrice = w.WPriceLB;
    double highPrice = w.WPriceUB;
    int lowPriceInt = (int)lowPrice;
    double lowPriceFrac = lowPrice - lowPriceInt;
    NSString *intStr = [NSString stringWithFormat:@"%d", lowPriceInt];
    NSString *fracStr;
    if(lowPriceFrac == 0)
        fracStr = @".00";
    else
    {
        fracStr = [NSString stringWithFormat:@"%.2f", lowPriceFrac];
        NSRange range = [fracStr rangeOfString:@"."];
        fracStr = [fracStr substringFromIndex:range.location];
    }
    _lowPriceIntLabel.text = intStr;
    CGSize size = [intStr sizeWithFont:_lowPriceIntLabel.font];
    _lowPriceIntLabel.frame = CGRectMake(336, 202, size.width, size.height);
    
    _lowPriceFracLabel.text = fracStr;
    size = [fracStr sizeWithFont:_lowPriceFracLabel.font];
    _lowPriceFracLabel.frame = CGRectMake(_lowPriceIntLabel.frame.origin.x + _lowPriceIntLabel.frame.size.width, _lowPriceIntLabel.frame.origin.y + _lowPriceIntLabel.frame.size.height - size.height - 4, size.width, size.height);
    
    NSString *highStr = [NSString stringWithFormat:@"~%.2f", highPrice];
    _highPriceLabel.text = highStr;
    size = [highStr sizeWithFont:_highPriceLabel.font];
    _highPriceLabel.frame = CGRectMake(_lowPriceFracLabel.frame.origin.x + _lowPriceFracLabel.frame.size.width, _lowPriceFracLabel.frame.origin.y, size.width, size.height);
    
    //商店
    [self buildShopsInfo];
    [_shopsTableView reloadData];
    //商品信息
    [self buildPropertiesInfo];
    [_propertyTableView reloadData];
    
}

#pragma mark - Table view delegation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _shopsTableView)
    {
        return [_shopsInfo count];
    }
    else
    {
        
        return [_detail_propertyKeys count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (tableView == _shopsTableView)
        {
            return 64;
        }
        else
        {
            
            return 24;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _shopsTableView)
    {
        static NSString *identify = @"ShopCell";
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *priceLabel = (UILabel *)[cell.contentView viewWithTag:2];
        priceLabel.text = [NSString stringWithFormat:@"￥%@",[[_shopsInfo objectAtIndex:indexPath.row] objectForKey:kPriceKey]] ;
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:3];
        nameLabel.text = [[_shopsInfo objectAtIndex:indexPath.row] objectForKey:kShopNameKey];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    else {
        static NSString *identify = @"WarePropetyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(68,0, 96, 64)];
            labelTitle.font = PMFont2;
            labelTitle.textColor = PMColor2;
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.tag = 1;
            [cell.contentView addSubview:labelTitle];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 80, 64)];
            label.font = PMFont2;
            label.textColor = PMColor2;
            label.backgroundColor = [UIColor clearColor];
            label.tag = 2;
            [cell.contentView addSubview:label];
            
            
        }
        UILabel *labelTitle = (UILabel *)[cell viewWithTag:1];
        NSString *oldkey = [_detail_propertyKeys objectAtIndex:indexPath.row];
        NSString *key = [[oldkey componentsSeparatedByString:@"|"] lastObject];
        NSString *value = [_ware.WMeta objectForKey:oldkey];
        NSString *propertyTitleStr = [NSString stringWithFormat:@"%d、%@：", indexPath.row+1, key];
        labelTitle.text = propertyTitleStr;
        CGSize sizeTitle = [propertyTitleStr sizeWithFont:labelTitle.font];
        labelTitle.frame = CGRectMake(32, -4, sizeTitle.width, 56);
        
        UILabel *label = (UILabel *)[cell viewWithTag:2];
        NSString *propertyStr = [NSString stringWithFormat:@"%@",value];
        label.text = propertyStr;
        CGSize size = [propertyStr sizeWithFont:label.font];
        label.frame = CGRectMake(32+sizeTitle.width, -4, size.width, 56);
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _shopsTableView)
    {
        [self showWebViewWithShopAtIndex:indexPath.row];
    }
}

#pragma mark - 数据处理

- (void)buildShopsInfo
{
    _shopsInfo = [[NSMutableArray alloc] init];
    // 获取商店列表
    NSString *shop = _ware.WShop;
    NSArray *shopList = nil;
    if( shop != nil && [shop length] > 0 )
        shopList = [shop componentsSeparatedByString:@"/"];
    
    // 价格列表和商品链接列表
    NSDictionary* meta = _ware.WMeta;
    
    NSString *link, *price, *name;
    
    for( NSString * s in shopList )
    {
        link = [meta objectForKey:[NSString stringWithFormat:@"%d|shoplink%@",ShopNameNum,s]];
        if( link != nil )
        {
            NSString* pkey = nil;
            int ps = [s intValue];
            switch(ps){
                case 1:
                    pkey =[NSString stringWithFormat:@"%d|京东价",ShopNameNum];
                    break;
                case 2:
                    pkey = [NSString stringWithFormat:@"%d|当当价",ShopNameNum];
                    break;
                case 3:
                    pkey = [NSString stringWithFormat:@"%d|亚马逊价",ShopNameNum];
                    break;
                case 4:
                    pkey = [NSString stringWithFormat:@"%d|苏宁价",ShopNameNum];
                    break;
                    
            }
            // price = [meta objectForKey:[NSString stringWithFormat:@"shopprice%@",s]];
            if ( pkey != nil ){
                price = [meta objectForKey:pkey];
                if (price == nil) price = @"";
                if ([price doubleValue] <= 0) continue;
                name = [self shopNameForShopIndex:s];
                NSDictionary *shopInfo = [NSDictionary dictionaryWithObjectsAndKeys:link, kShopLinkKey, price, kPriceKey, name, kShopNameKey, s, kShopIndexKey, nil];
                [_shopsInfo addObject:shopInfo];
            }
        }
    }
    [_shopsInfo sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double price1 = [[obj1 objectForKey:kPriceKey] doubleValue];
        double price2 = [[obj2 objectForKey:kPriceKey] doubleValue];
        if (price1 < price2) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
}

- (NSString *)shopNameForShopIndex:(NSString *)shopIndex
{
    switch ([shopIndex integerValue]) {
        case 1:
            return @"京东商城";
        case 2:
            return @"当当网";
        case 3:
            return @"亚马逊";
        case 4:
            return @"苏宁";
        default:
            return @"其他商城";
    }
    
}

- (void)buildPropertiesInfo
{
    NSMutableArray *propertyKeys = [[NSMutableArray alloc] init];
    _detail_propertyKeys = [[NSMutableArray alloc] init];
    for (NSString *key in _ware.WMeta)
    {
        if ([[key componentsSeparatedByString:@"|"] count] > 1)
        {
            NSInteger priority = [[[key componentsSeparatedByString:@"|"]objectAtIndex:0] integerValue];
            if (priority < 100) [propertyKeys addObject:key];
        }
    }
    _propertyKeys = [propertyKeys sortedArrayUsingComparator:^NSComparisonResult(id key1, id key2){
        NSInteger priority1 = [[[key1 componentsSeparatedByString:@"|"]objectAtIndex:0] integerValue];
        NSInteger priority2 = [[[key2 componentsSeparatedByString:@"|"]objectAtIndex:0] integerValue];
        if (priority1 < priority2) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    for (int i = 0; i < [_propertyKeys count]; i++) {
        NSCharacterSet *characters = [[NSCharacterSet
                                       characterSetWithCharactersInString:[_propertyKeys objectAtIndex:i]]  invertedSet];
        NSRange userNameRange = [@"shoplink" rangeOfCharacterFromSet:characters];
        if (userNameRange.location != NSNotFound) {
            [_detail_propertyKeys addObject:[_propertyKeys  objectAtIndex:i]];
        }
        
    }
    
}

#pragma mark - 浏览器
- (void)showWebViewWithShopAtIndex:(NSInteger)index
{
    ShopWebViewController  *webVC = [[ShopWebViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:webVC.view];
    [webVC setWare:_ware shops:_shopsInfo firstIndex:index];
    [webVC show];
    [webVC setShopDelegate:self];
}


//- (void)showWebView:(NSDictionary *)shopInfo
//{
//    NSString *url = [shopInfo valueForKey:kShopLinkKey];
//    NSString *shopName = [shopInfo valueForKey:kShopNameKey];
//    NSString *shopIndex = [shopInfo valueForKey:kShopIndexKey];
//    CGFloat price = [[shopInfo valueForKey:kPriceKey] doubleValue];
//    webView = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
//    BlurView *blurView = [BlurView showViewController:webView withViewFrame:CGRectMake(80, 128, 688, 895)];
//    [webView viewDidLoad:url WithShop:shopName WithWare:_ware.WName WithStatus:@"NOR" WID:_ware.WID ShopIndex:[shopIndex integerValue]];
//    payback = [[PayBack alloc] initWithFrame:CGRectMake( 128, 32, 624, 90) AndStatus:@"NOR"];
//    [payback setShop:shopName];
//    [payback setWID:_ware.WID];
//    [payback setAlpha:0];
//    [payback setUpperBound:0.1 * price];
//    [payback setParentBlurView:blurView];
//    [blurView addSubview:payback];
//    [UIView animateWithDuration:0.5 animations:^{
//        payback.alpha = 1;
//    }];
//
//
//}


#pragma mark - 按键响应

- (void)addToCart {
    
    [addBtn setEnabled:NO];
    [MobClick event:umeng_event_click label:@"addToCart_SingleGoodViewController"];
    [[CartModel sharedCart] addWareIntoCart:_ware];
    [addBtn initWithTitle:@"已加入购物车"  andButtonType:kBlueLeftDown];
    [CustomNotiViewController showNotiWithTitle:@"添加成功" withTypeStyle:kNotiTypeStyleRight];

}

- (void)shareWare
{

}



- (void)cartStatusUpdate
{
    if ([[CartModel sharedCart] wareIsInCart:_ware])
    {
        [addBtn setEnabled:NO];
        [addBtn initWithTitle:@"已加入购物车"  andButtonType:kBlueLeftDown];
       
    }else{
        [addBtn setEnabled:YES];
        [addBtn initWithTitle:@"+加入购物车"  andButtonType:kBlueLeftDown];
    }
}



- (void)singleInfoButtonUnpress
{
    [self.view removeFromSuperview];
}

- (void)viewDidUnload {

    [super viewDidUnload];
}


@end
