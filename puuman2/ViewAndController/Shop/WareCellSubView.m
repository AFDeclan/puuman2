//
//  WareCellSubView.m
//  puman
//
//  Created by 陈晔 on 13-9-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "UniverseConstant.h"
#import "WareCellSubView.h"
#import "Ware.h"
#import "AFImageView.h"
#import "ShopViewController.h"

@implementation WareCellSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _wareImageView = [[AFImageView alloc] initWithFrame:CGRectMake(12, 0, 176, 176)];
        [self addSubview:_wareImageView];
        
        
        
        UIImageView  *_maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 136, 176, 40)];
        [_maskView setBackgroundColor:[UIColor whiteColor]];
        [_maskView setAlpha:0.5];
        [_wareImageView addSubview:_maskView];
    
        UIImageView *icon_rmb = [[UIImageView alloc] initWithFrame:CGRectMake(12, 148, 16, 16)];
        [icon_rmb setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
        [_wareImageView addSubview:icon_rmb];
        
        
        
        
        UITapGestureRecognizer *tapMask = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [self addGestureRecognizer:tapMask];
        
        _lowPriceIntLabel = [[UILabel alloc] init];
        _lowPriceIntLabel.backgroundColor = [UIColor clearColor];
        _lowPriceIntLabel.textColor = PMColor6;
        _lowPriceIntLabel.font = PMFont(28);
        [self addSubview:_lowPriceIntLabel];
        _lowPriceFracLabel = [[UILabel alloc] init];
        _lowPriceFracLabel.backgroundColor = [UIColor clearColor];
        _lowPriceFracLabel.textColor = PMColor6;
        _lowPriceFracLabel.font = PMFont2;
        [self addSubview:_lowPriceFracLabel];
        _highPriceLabel = [[UILabel alloc] init];
        _highPriceLabel.backgroundColor = [UIColor clearColor];
        _highPriceLabel.textColor = PMColor1;
        _highPriceLabel.font = PMFont2;
        [self addSubview:_highPriceLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 192, 176, 30)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = PMFont3;
        _nameLabel.textColor = PMColor1;
        [self addSubview:_nameLabel];
        
        _shopCntLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 234, 128, 12)];
        _shopCntLabel.backgroundColor = [UIColor clearColor];
        _shopCntLabel.font = PMFont3;
        _shopCntLabel.textColor = PMColor2;
        [self addSubview:_shopCntLabel];

    }
    return self;
}

- (void)setWare:(Ware *)ware
{
    _ware = ware;
    if (!ware)
    {
        [self setNoWare];
        return;
    }
    //设置图片
    [_wareImageView getImage:ware.WPicLink defaultImage:default_ware_image];
    //设置名称
    [_nameLabel setText:ware.WName];
    //设置商家数
    NSString *shopsStr = ware.WShop;
    NSArray *shops = [shopsStr componentsSeparatedByString:@"/"];
    [_shopCntLabel setText:[NSString stringWithFormat:@"卖家数：%d", [shops count]]];
    //设置价格
    double lowPrice = ware.WPriceLB;
    double highPrice = ware.WPriceUB;
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
    _lowPriceIntLabel.frame = CGRectMake(40, 144, size.width, size.height);
    
    _lowPriceFracLabel.text = fracStr;
    size = [fracStr sizeWithFont:_lowPriceFracLabel.font];
    _lowPriceFracLabel.frame = CGRectMake(_lowPriceIntLabel.frame.origin.x + _lowPriceIntLabel.frame.size.width, _lowPriceIntLabel.frame.origin.y + _lowPriceIntLabel.frame.size.height - size.height-2, size.width, size.height);

    NSString *highStr = [NSString stringWithFormat:@"~%.2f", highPrice];
    _highPriceLabel.text = highStr;
    size = [highStr sizeWithFont:_highPriceLabel.font];
    _highPriceLabel.frame = CGRectMake(_lowPriceFracLabel.frame.origin.x + _lowPriceFracLabel.frame.size.width, _lowPriceFracLabel.frame.origin.y, size.width, size.height);
}

- (void)setNoWare
{
    [_wareImageView setImage:nil];
    self.alpha = 0;
}

- (void)tapped
{
    if (_ware)
    {
        //[[ShopViewController sharedShopViewController] showWare:_ware];
    }
}

- (void)prepareForReuse
{
    self.alpha = 1;
    [_wareImageView prepareForReuse];
    _ware = nil;
    _shopCntLabel.text = @"卖家数：";
    _lowPriceFracLabel.text = @"";
    _lowPriceIntLabel.text = @"";
    _highPriceLabel.text = @"";
    _nameLabel.text = @"";
}

@end
