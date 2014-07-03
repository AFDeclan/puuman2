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
    
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 5, 54, 54)];
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

}

- (void)selectedButtonSelectedWithButton:(SelectedButton *)button
{
    
   if (button == addCountBtn) {
    
    } else {
    
    }
}


//- (void)initMiddleView
//{
//    middleView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(headView)+ViewHeight(titleView), kScreenWidth, 80)];
//    [middleView setBackgroundColor:PMColor4];
//    [singleProductTableView addSubview:middleView];
//    
//
//    
//    omitButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [omitButton setBackgroundColor:[UIColor clearColor]];
//    [omitButton setFrame:CGRectMake(75, 15 , 80, 24)];
//    [omitButton.layer setMasksToBounds:YES];
//    [omitButton.layer setCornerRadius:12];
//    [omitButton.layer setBorderWidth:1.0];
//    [omitButton.layer setBorderColor:[PMColor3 CGColor]];
//    [omitButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [omitButton setTag:100];
//    [middleView addSubview:omitButton];
//    
//    omitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 60, 20)];
//    [omitLabel setText:@"内蒙古"];
//    [omitLabel setTextColor:PMColor3];
//    [omitLabel setFont:PMFont4];
//    [omitLabel setBackgroundColor:[UIColor clearColor]];
//    [omitButton addSubview:omitLabel];
//    
//    UIImageView *omitImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//    [omitImage setFrame:CGRectMake(72, 8, 6, 8)];
//    [omitImage setBackgroundColor:PMColor3];
//    [omitButton addSubview:omitImage];
//    
//    cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cityButton setBackgroundColor:[UIColor clearColor]];
//    [cityButton setFrame:CGRectMake(160, 15, 95, 24)];
//    [cityButton.layer setMasksToBounds:YES];
//    [cityButton.layer setCornerRadius:12];
//    [cityButton.layer setBorderWidth:1.0];
//    [cityButton.layer setBorderColor:[PMColor3 CGColor]];
//    [cityButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cityButton setTag:101];
//    [middleView addSubview:cityButton];
//    
//    cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 75, 20)];
//    [cityLabel setText:@"鄂尔多私事"];
//    [cityLabel setTextColor:PMColor3];
//    [cityLabel setFont:PMFont4];
//    [cityLabel setBackgroundColor:[UIColor clearColor]];
//    [cityButton addSubview:cityLabel];
//    
//    UIImageView *cityImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//    [cityImage setFrame:CGRectMake(88, 8, 6, 8)];
//    [cityImage setBackgroundColor:PMColor3];
//    [omitButton addSubview:cityImage];
//    
//    
//    chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chooseButton setBackgroundColor:PMColor6];
//    [chooseButton setFrame:CGRectMake(260, 15, 50, 24)];
//    [chooseButton.layer setMasksToBounds:YES];
//    [chooseButton.layer setCornerRadius:12];
//    [chooseButton setTitle:@"有货" forState:UIControlStateNormal];
//    [chooseButton.titleLabel setFont:PMFont3];
//    [chooseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [middleView addSubview:chooseButton];
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(75, 46, 180, 24)];
//    
//    [view.layer setMasksToBounds:YES];
//    [view.layer setCornerRadius:12];
//    [view.layer setBorderWidth:1.0];
//    [view.layer setBorderColor:[PMColor3 CGColor]];
//    [middleView addSubview:view];
//    
//
//}
//
//- (void)initFootView
//{
//    footView = [[UIView alloc] initWithFrame:CGRectMake(0,ViewHeight(headView)+ViewHeight(middleView)+ViewHeight(titleView), kScreenWidth, kScreenHeight-ViewHeight(headView)-ViewHeight(middleView)-ViewHeight(titleView))];
//    [footView setBackgroundColor:[UIColor whiteColor]];
//    [singleProductTableView addSubview:footView];
//    
//    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 28)];
//    [selectView.layer setMasksToBounds:YES];
//    [selectView.layer setCornerRadius:14];
//    [footView addSubview:selectView];
//    
//    productBtn = [[ImgTextButton alloc] initWithFrame:CGRectMake(0, 0, 150,28)];
//    //[productBtn setTitle:@"商品描述" andImg:nil andimgSize:CGSizeZero andStyle:CustomBtnStyle_D2];
//    [productBtn setTitle:@"商品描述"  andselectedImg:nil andunSelectedImg:nil  andimgSize:CGSizeZero andStyle:CustomBtnStyle_D2];
//    [productBtn addTarget:self action:@selector(loadProduct) forControlEvents:UIControlEventTouchUpInside];
//    [productBtn setBackgroundColor:PMColor4];
//    [selectView addSubview:productBtn];
//    
//    userBtn = [[ImgTextButton alloc] initWithFrame:CGRectMake(150, 0, 150, 28)];
//    //[userBtn setTitle:@"用户评价" andImg:nil andimgSize:CGSizeZero andStyle:CustomBtnStyle_D2];
//    [userBtn setTitle:@"用户评价" andselectedImg:nil andunSelectedImg:nil andimgSize:CGSizeZero andStyle:CustomBtnStyle_D2];
//    [userBtn addTarget:self action:@selector(loadUser) forControlEvents:UIControlEventTouchUpInside];
//    [userBtn setBackgroundColor:PMColor4];
//    [selectView addSubview:userBtn];
//    
//    
//    
//    
//    
//    
//    
//}

//- (void)loadProduct
//{
//    [productBtn setActive:YES];
//    [userBtn setActive:NO];
//    
//}
//
//- (void)loadUser
//{
//    [productBtn setActive:NO];
//    [userBtn setActive:YES];
//    
//}
//
//- (void)close
//{
//    [closeBtn setActive:YES];
//    [finishedBtn setActive:NO];
//    
//}
//
//- (void)finished
//{
//    [finishedBtn setActive:YES];
//    [closeBtn setActive:NO];
//    
//    
//}
//
//- (void)btnClick:(UIButton *)button
//{
//    
//    
//    
//}
//
//- (void)selectedButtonSelectedWithButton:(SelectedButton *)button
//{
//    
//    if (button == backBtn) {
//        
//        CATransition *transition = [CATransition pushFromLeft:self];
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        [self.navigationController popViewControllerAnimated:NO];
//    } else if (button == addCountBtn) {
//        
//        count ++;
//        changeCountLabel.text = [NSString stringWithFormat:@"%i",count];
//        
//    } else {
//        
//        if (count <= 0) {
//            
//            return;
//        }
//        count --;
//        changeCountLabel.text = [NSString stringWithFormat:@"%i",count];
//        
//    }
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//    singleProductTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    [singleProductTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [singleProductTableView setSeparatorColor:[UIColor clearColor]];
//    [singleProductTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
//    [singleProductTableView setDelegate:self];
//    [singleProductTableView setDataSource:self];
//    [self.view addSubview:singleProductTableView];
//    [self initHeadView];
//    [self initMiddleView];
//    [self initFootView];
//    
//    
//}
//


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
