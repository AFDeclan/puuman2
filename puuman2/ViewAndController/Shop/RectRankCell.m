//
//  RectRankCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RectRankCell.h"
#import "RectRankSubCell.h"
#import "ColorsAndFonts.h"
#import "ShopWebViewController.h"
#import "MainTabBarController.h"

@implementation RectRankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        rectWares = [[NSArray alloc] init];
        icon_FlagView = [[TypeButton alloc] initWithFrame:CGRectMake(0, 0, 64, 74)];
        [icon_FlagView setEnabled:NO];
        [icon_FlagView setAdjustsImageWhenDisabled:NO];
        [self.contentView addSubview:icon_FlagView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataViewRectRanks:(NSArray *)rects andRectTypeIndex:(NSInteger)typeIndex
{
    rectWares = rects;
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(48, 16, 544, 112)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:YES];
    [self.contentView addSubview:_showColumnView];
     [self.contentView bringSubviewToFront:icon_FlagView];
    if (typeIndex == 1) {
        [icon_FlagView initWithIconImg:[UIImage imageNamed:@"icon2_rec_shop.png"] andTitle:@"人气商品" andTitleColor:[UIColor whiteColor] andTitleFont:PMFont3];
        [icon_FlagView setBackgroundImage:[UIImage imageNamed:@"block2_rec_shop.png"] forState:UIControlStateNormal];

    }else if (typeIndex == 2)
    {
         [icon_FlagView initWithIconImg:[UIImage imageNamed:@"icon3_rec_shop.png"] andTitle:@"特惠专区" andTitleColor:[UIColor whiteColor] andTitleFont:PMFont3];
         [icon_FlagView setBackgroundImage:[UIImage imageNamed:@"block3_rec_shop.png"] forState:UIControlStateNormal];
    }else{
        [icon_FlagView initWithIconImg:[UIImage imageNamed:@"icon4_rec_shop.png"] andTitle:@"补货" andTitleColor:[UIColor whiteColor] andTitleFont:PMFont3];
        [icon_FlagView setBackgroundImage:[UIImage imageNamed:@"block4_rec_shop.png"] forState:UIControlStateNormal];

    }
    
    
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    RecomWare *recWare = [rectWares objectAtIndex:index];
    
    ShopWebViewController  *webVC = [[ShopWebViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:webVC.view];
    [webVC setRecWebUrl:recWare.RWShopLink wareName:recWare.RWName wareId:recWare.RWID warePrice:recWare.RWPrice shopName:recWare.RWShop shopIndex:0 imgLink:recWare.RWPicLink];
    [webVC show];

}



- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
   
    return 112;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [rectWares count];
    
}



- (void)scrollViewDidEndDecelerating:(UIColumnView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIColumnView *)scrollView willDecelerate:(BOOL)decelerate;
{
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    static NSString *identify = @"rectRankSubCell";
    RectRankSubCell *cell = (RectRankSubCell *)[columnView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
            cell = [[RectRankSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    [cell bulidCellWithWareData:[rectWares objectAtIndex:index]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
        
}



@end
