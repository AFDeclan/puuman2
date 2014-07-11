//
//  OrderWaresTableViewCell.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "OrderWaresTableViewCell.h"
#import "WareInfoPopViewController.h"
#import "MainTabBarController.h"

@implementation OrderWaresTableViewCell
@synthesize ware = _ware;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    [self.contentView setBackgroundColor:PMColor5];
    
    wareImgView = [[AFImageView alloc] initWithFrame:CGRectMake(16, 8, 56, 56)];
    [wareImgView setImage:[UIImage imageNamed:@"shopping_default.png"]];
    [self.contentView addSubview:wareImgView];
    
    wareName  = [[UILabel alloc] initWithFrame:CGRectMake(88, 16, 168, 32)];
    [wareName setTextColor:PMColor2];
    [wareName setBackgroundColor:[UIColor clearColor]];
    [wareName setFont:PMFont3];
    [wareName setText:@"牛真牛牌牛奶粉"];
    [wareName setNumberOfLines:2];
    [self.contentView addSubview:wareName];
    
    UIImageView *icon_price = [[UIImageView alloc] initWithFrame:CGRectMake(88, 44, 10, 12)];
    [icon_price setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
    [self.contentView addSubview:icon_price];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 40, 128, 24)];
    [priceLabel setFont:PMFont2];
    [priceLabel setTextColor:PMColor1];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setText:@"128.00"];
    [self.contentView addSubview:priceLabel];
    
    orderNum = [[UILabel alloc] initWithFrame:CGRectMake(540 - 44, 16, 44, 32)];
    [orderNum setFont:PMFont1];
    [orderNum setTextColor:PMColor2];
    [orderNum setText:@"x5"];
    [orderNum setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:orderNum];
    [self.contentView setBackgroundColor:PMColor5];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 540, 80)];
    [self.contentView addSubview:btn];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(showDetailWare) forControlEvents:UIControlEventTouchUpInside];

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWare:(Ware *)ware
{
    _ware = ware;
    wareName.text = ware.WName;
    [wareImgView getImage:ware.WPicLink defaultImage:@""];
    priceLabel.text = [NSString stringWithFormat:@"%f",ware.WPriceLB];
    
}

- (void)showDetailWare
{
    WareInfoPopViewController *cartVC =[[WareInfoPopViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:cartVC.view];
    [cartVC setControlBtnType:kOnlyCloseButton];
    [cartVC show];
    
}

@end
