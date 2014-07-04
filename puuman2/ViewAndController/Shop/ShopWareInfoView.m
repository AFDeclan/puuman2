//
//  ShopWareInfoView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopWareInfoView.h"
#import "UniverseConstant.h"
#import "CATransition+Custom.h"
#import "ColorsAndFonts.h"
#import "UILabel+AdjustSize.h"

@implementation ShopWareInfoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        
    }
    return self;
}

- (void)refresh
{
    [infoView setFrame:CGRectMake(16, 88, (self.frame.size.width-32), 248)];
    [infoTableView setFrame:CGRectMake(16, 352, (self.frame.size.width-32), 80)];
    [infoTableView reloadData];
    SetViewLeftUp(shareBtn, self.frame.size.width - ViewWidth(shareBtn), 578);
    SetViewLeftUp(addToCart, self.frame.size.width - ViewWidth(shareBtn), 618);
    SetViewLeftUp(backBtn, self.frame.size.width - 8- 54, 5);
    [titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
}


- (void)initialization
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    [headView setBackgroundColor:PMColor5];
    [self addSubview:headView];
    
    infoView = [[UIView alloc] initWithFrame:CGRectMake(16, 88, (self.frame.size.width-32), 248)];
    [infoView setBackgroundColor:PMColor5];
    [self addSubview:infoView];
    
    [self initHeadView];
    [self initInfoView];

    infoTableView = [[UIColumnView alloc] initWithFrame:CGRectMake(16, 352, (self.frame.size.width-32), 80)];
    [infoTableView setBackgroundColor:[UIColor clearColor]];
    [infoTableView setColumnViewDelegate:self];
    [infoTableView setViewDataSource:self];
    [infoTableView setPagingEnabled:YES];
    [self addSubview:infoTableView];
    
    
    shareBtn = [[ColorButton alloc] init];
    [shareBtn initWithTitle:@"分享" andIcon:nil andButtonType:kGrayLeftUp];
    [self addSubview:shareBtn];
    addToCart = [[ColorButton alloc] init];
    [addToCart initWithTitle:@"+加入购物车" andButtonType:kBlueLeftDown];
    [self addSubview:addToCart];
    SetViewLeftUp(shareBtn, self.frame.size.width - ViewWidth(shareBtn), 578);
    SetViewLeftUp(addToCart, self.frame.size.width - ViewWidth(shareBtn), 618);
    
}

- (void)initHeadView
{
    //head
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    [titleLabel setTextColor:PMColor6];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:PMFont1];
    [titleLabel setText:@"单品信息"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:titleLabel];
    
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 8- 54, 5, 54, 54)];
    [backBtn setImage:[UIImage imageNamed:@"ware_info_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];

}

- (void)initInfoView
{
    //info
    wareImgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 248, 248)];
    [wareImgView setImage:[UIImage imageNamed:default_ware_image]];
    [wareImgView setBackgroundColor:[UIColor whiteColor]];
    [infoView addSubview:wareImgView];
    
    wareName  = [[UILabel alloc] initWithFrame:CGRectMake(264, 0, 336, 78)];
    [wareName setTextColor:PMColor2];
    [wareName setBackgroundColor:[UIColor clearColor]];
    [wareName setFont:PMFont2];
    [wareName setText:@"牛真牛牌牛奶粉"];
    [wareName setNumberOfLines:2];
    [infoView addSubview:wareName];
    
    UIImageView *icon_price = [[UIImageView alloc] initWithFrame:CGRectMake(280, 78, 10, 12)];
    [icon_price setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
    [infoView addSubview:icon_price];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(296, 78, 0, 0)];
    [priceLabel setFont:PMFont(32)];
    [priceLabel setTextColor:PMColor6];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setText:@"234."];
    [infoView addSubview:priceLabel];
    [priceLabel adjustSize];
    
    UILabel *price_flag= [[UILabel alloc] initWithFrame:CGRectMake(ViewX(priceLabel)+ViewWidth(priceLabel) , ViewY(priceLabel)+8, 0, 0)];
    [price_flag setFont:PMFont1];
    [price_flag setTextColor:PMColor6];
    [price_flag setBackgroundColor:[UIColor clearColor]];
    [price_flag setText:@"00"];
    [infoView addSubview:price_flag];
    [price_flag adjustSize];
    
    
    UILabel *deliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(264, 170, 48, 24)];
    [deliveryLabel setBackgroundColor:[UIColor clearColor]];
    [deliveryLabel setText:@"送货至"];
    [deliveryLabel setTextColor:PMColor3];
    [deliveryLabel setFont:PMFont2];
    [deliveryLabel setTextAlignment:NSTextAlignmentCenter];
    [infoView addSubview:deliveryLabel];
    
     UILabel *wareNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(264, 208, 48, 24)];
    [wareNumLabel setBackgroundColor:[UIColor clearColor]];
    [wareNumLabel setText:@"数量"];
    [wareNumLabel setTextColor:PMColor3];
    [wareNumLabel setFont:PMFont2];
    [wareNumLabel setTextAlignment:NSTextAlignmentCenter];
    [infoView addSubview:wareNumLabel];

    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(320, 208, 180, 24)];
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:12];
    [view.layer setBorderWidth:1.0];
    [view.layer setBorderColor:[PMColor3 CGColor]];
    [infoView addSubview:view];
    
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

- (void)backBtnPressed
{
    PostNotification(Noti_ShowWareInfo, [NSNumber numberWithBool:NO]);
}

- (void)selectedButtonSelectedWithButton:(SelectedButton *)button
{
    
   if (button == addCountBtn) {
    
    } else {
    
    }
}


#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 128;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    return 4;
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"WareInfoCell";
    UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *bgView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 80)];
        [cell.contentView addSubview:bgView];
        [bgView setBackgroundColor:PMColor5];
        
        UILabel *infoName= [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 88, 24)];
        [infoName setTextColor:PMColor2];
        [infoName setBackgroundColor:[UIColor clearColor]];
        [infoName setFont:PMFont3];
        [infoName setTag:10];
        [cell.contentView addSubview:infoName];
        
        UILabel *detailInfo= [[UILabel alloc] initWithFrame:CGRectMake(16, 36,88, 44)];
        [detailInfo setTextColor:PMColor1];
        [detailInfo setBackgroundColor:[UIColor clearColor]];
        [detailInfo setFont:PMFont2];
        [detailInfo setTag:11];
        [cell.contentView addSubview:detailInfo];
        
    }
    
    UILabel *infoName = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *detailInfo = (UILabel *)[cell.contentView viewWithTag:11];
    [infoName setText:@"产地"];
    [detailInfo setText:@"黑龙江双城"];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView.layer setMasksToBounds:YES];
    return cell;
    
}



@end
