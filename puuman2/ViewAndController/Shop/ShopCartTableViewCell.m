//
//  ShopCartTableViewCell.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ShopCartTableViewCell.h"
#import "WareInfoPopViewController.h"
#import "MainTabBarController.h"

@implementation ShopCartTableViewCell
@synthesize ware = _ware;
@synthesize selectedWare = _selectedWare;
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
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    content = [[UIView alloc] initWithFrame:CGRectMake(0, 16, 544, 148)];
    [content setBackgroundColor:PMColor4];
    [self.contentView addSubview:content];
    
    selectedBtn = [[UIButton  alloc] initWithFrame:CGRectMake(24, 58, 32, 32)];
    [selectedBtn addTarget:self action:@selector(selectedOrUnSelected) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:selectedBtn];
    
    wareImgView = [[AFImageView alloc] initWithFrame:CGRectMake(66, 12, 84, 84)];
    [wareImgView setImage:[UIImage imageNamed:default_ware_image]];
    [content addSubview:wareImgView];
    
    wareName  = [[UILabel alloc] initWithFrame:CGRectMake(162, 12, 365, 48)];
    [wareName setTextColor:PMColor2];
    [wareName setBackgroundColor:[UIColor clearColor]];
    [wareName setFont:PMFont2];
    [wareName setText:@"牛真牛牌牛奶粉"];
    [wareName setNumberOfLines:2];
    [content addSubview:wareName];

    
    UIImageView *icon_price = [[UIImageView alloc] initWithFrame:CGRectMake(160, 84, 10, 12)];
    [icon_price setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
    [content addSubview:icon_price];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(176, 78, 128, 24)];
    [priceLabel setFont:PMFont2];
    [priceLabel setTextColor:PMColor1];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setText:@"234.00"];
    [content addSubview:priceLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(66, 12, 450, 96)];
    [content addSubview:btn];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(showDetailWare) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *total_label= [[UILabel alloc] initWithFrame:CGRectMake(420, 118, 64, 16)];
    [total_label setTextColor:PMColor2];
    [total_label setBackgroundColor:[UIColor clearColor]];
    [total_label setFont:PMFont3];
    [total_label setText:@"合计"];
    [content addSubview:total_label];
    
    UILabel *num_label= [[UILabel alloc] initWithFrame:CGRectMake(160, 118, 64, 16)];
    [num_label setTextColor:PMColor2];
    [num_label setBackgroundColor:[UIColor clearColor]];
    [num_label setFont:PMFont3];
    [num_label setText:@"数量"];
    [content addSubview:num_label];
  
    total_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(432, 116, 112, 16)];
    [total_priceLabel setTextColor:PMColor6];
    [total_priceLabel setBackgroundColor:[UIColor clearColor]];
    [total_priceLabel setFont:PMFont2];
    [total_priceLabel setText:@"1248.00"];
    [total_priceLabel setTextAlignment:NSTextAlignmentCenter];
    [content addSubview:total_priceLabel];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(196, 112, 184, 24)];
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:12];
    [view.layer setBorderWidth:1.0];
    [view.layer setBorderColor:[PMColor3 CGColor]];
    [content addSubview:view];
    
    addBtn = [[SelectedButton alloc] initWithFrame:CGRectMake(0, 0, 48, 24)];
    [addBtn setBackgroundColor:PMColor2];
    [addBtn setType:kSelectedLeft];
    [addBtn.icon setImage:[UIImage imageNamed:@"img_reduce_count.png"]];
    [addBtn.icon setFrame:CGRectMake(0, 0, 12, 3)];
    [addBtn adjustSize];
    [addBtn setDelegate:self];
    [view addSubview:addBtn];

  
    
    minusBtn = [[SelectedButton alloc] initWithFrame:CGRectMake(136, 0, 48, 24)];
    [minusBtn setBackgroundColor:PMColor2];
    [minusBtn setType:kSelectedRight];
    [minusBtn.icon setImage:[UIImage imageNamed:@"img_add_count.png"]];
    [minusBtn.icon setFrame:CGRectMake(0, 0, 12, 12)];
    [minusBtn adjustSize];
    [minusBtn setDelegate:self];
    [view addSubview:minusBtn];

    num_wares  = [[UILabel alloc] initWithFrame:CGRectMake(48, 0, 88, 24)];
    [num_wares setTextAlignment:NSTextAlignmentCenter];
    [num_wares setTextColor:PMColor6];
    [num_wares setBackgroundColor:[UIColor clearColor]];
    [num_wares setFont:PMFont2];
    [num_wares setText:@"1"];
    [num_wares setNumberOfLines:2];
    [view addSubview:num_wares];

    
}

- (void)selectedButtonSelectedWithButton:(SelectedButton *)button
{
    if (button == minusBtn) {
        
        count ++;
        num_wares.text = [NSString stringWithFormat:@"%i",count];
        
    } else {
        
        if (count <= 0) {
            
            return;
        }
        count --;
        num_wares.text = [NSString stringWithFormat:@"%i",count];
    
 }
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

- (void)setSelectedWare:(BOOL)selectedWare
{
    _selectedWare = selectedWare;
    if (selectedWare) {
        [selectedBtn setImage:[UIImage imageNamed:@"icon_selected_cart.png"] forState:UIControlStateNormal];
    }else{
        [selectedBtn setImage:[UIImage imageNamed:@"icon_unselected_cart.png"] forState:UIControlStateNormal];

    }
}

- (void)selectedOrUnSelected
{
    _selectedWare = !_selectedWare;
    if (_selectedWare) {
        [selectedBtn setImage:[UIImage imageNamed:@"icon_selected_cart.png"] forState:UIControlStateNormal];

    }else{
        [selectedBtn setImage:[UIImage imageNamed:@"icon_unselected_cart.png"] forState:UIControlStateNormal];

    }
}

- (void)showDetailWare
{
    WareInfoPopViewController *cartVC =[[WareInfoPopViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:cartVC.view];
    [cartVC setControlBtnType:kOnlyCloseButton];
    [cartVC show];

}

@end
