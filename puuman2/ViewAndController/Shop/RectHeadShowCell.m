//
//  RectHeadShowCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RectHeadShowCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "RecomWare.h"
#import "ShopWebViewController.h"
#import "MainTabBarController.h"


@implementation RectHeadShowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        wareArray = [[NSArray alloc] init];
        selectedIndex = 0;
        pointerPic = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 96, 384)];
        [pointerPic setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [pointerPic setDelegate:self];
        [pointerPic setDataSource:self];
        [pointerPic setShowsHorizontalScrollIndicator:NO];
        [pointerPic setShowsVerticalScrollIndicator:NO];
        [pointerPic setBackgroundColor:[UIColor clearColor]];
        [pointerPic setSeparatorColor:[UIColor clearColor]];
        [self.contentView addSubview:pointerPic];
        icon_FlagView = [[TypeButton alloc] initWithFrame:CGRectMake(0, 16, 64, 74) ];
        [icon_FlagView  initWithIconImg:[UIImage imageNamed:@"icon1_rec_shop.png"] andTitle:@"为您推荐" andTitleColor:[UIColor whiteColor] andTitleFont:PMFont3];
        [icon_FlagView setEnabled:NO];
        [icon_FlagView setBackgroundImage:[UIImage imageNamed:@"block1_rec_shop.png"] forState:UIControlStateNormal];
        [icon_FlagView setAdjustsImageWhenDisabled:NO];
        [self.contentView addSubview:icon_FlagView];
        
        rectWareShowView = [[AFImageView alloc] initWithFrame:CGRectMake(96, 80, 496, 384)];
        [self.contentView addSubview:rectWareShowView];
        UIGestureRecognizer *pressShowPic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressShowPic)];
        [rectWareShowView setUserInteractionEnabled:YES];
        [rectWareShowView addGestureRecognizer:pressShowPic];

        
        rectInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 320, 496, 64)];
        [rectWareShowView addSubview:rectInfoView];
        
        UIView *bgInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 496, 64)];
        [bgInfoView setBackgroundColor:[UIColor whiteColor]];
        [bgInfoView setAlpha:0.5];
        [rectInfoView addSubview:bgInfoView];
        
        UIImageView *rmb_icon = [[UIImageView alloc] initWithFrame:CGRectMake(352, 32, 16, 16)];
        [rmb_icon setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
        [rectInfoView addSubview:rmb_icon];
        wareNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 8, 460, 48)];
        [wareNameLabel setBackgroundColor:[UIColor clearColor]];
        [wareNameLabel setFont:PMFont(20)];
        [wareNameLabel setTextColor:PMColor1];
        [rectInfoView addSubview:wareNameLabel];
        warePriceLabel= [[UILabel alloc] initWithFrame:CGRectMake(368, 32, 112, 24)];
        [warePriceLabel setBackgroundColor:[UIColor clearColor]];
        [warePriceLabel setFont:PMFont2];
        [warePriceLabel setTextColor:PMColor6];
        [rectInfoView addSubview:warePriceLabel];
        
    }
    return self;
}

- (void)reloadDataWithData:(NSArray *)showWare;
{
     wareArray = showWare;
    [pointerPic reloadData];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return  [wareArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identity = @"pointerPicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        AFImageView *pointImg = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 96, 96)];
        [cell.contentView addSubview:pointImg];
        [pointImg setTag:10];
        
        UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 96, 96)];
        [cell.contentView addSubview:mask];
        [mask setBackgroundColor:[UIColor blackColor]];
        
        [mask setTag:11];
    }
    
    AFImageView *img = (AFImageView *)[cell.contentView viewWithTag:10];
    RecomWare* rec = [wareArray objectAtIndex:[indexPath row]];
    [img getImage:rec.RWPicLink defaultImage:default_ware_image];
    UIView *mask = [cell.contentView viewWithTag:11];
    if ([indexPath row] == selectedIndex) {
        selectedCell = cell;
        [mask setAlpha:0];
        [rectWareShowView getImage:rec.RWPicLink defaultImage:default_ware_image];
        [self setWareNameWithName:rec.RWName];
        [warePriceLabel setText:[NSString stringWithFormat:@"%0.2f",rec.RWPrice]];
        
    }else{
        [mask setAlpha:0.3];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.tag = indexPath.row;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellSelected:)];
    [cell addGestureRecognizer:tap];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    UIView *mask = [cell viewWithTag:11];
//    
//    if ([indexPath row] != selectedIndex) {
//        
//        [mask setAlpha:0];
//        UITableViewCell *selectedcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
//        [[selectedcell viewWithTag:11] setAlpha:0.3];
//        selectedIndex = [indexPath row];
//        RecomWare* rec = [wareArray objectAtIndex:[indexPath row]];
//        [rectWareShowView getImage:rec.RWPicLink defaultImage:default_ware_image];
//        [self setWareNameWithName:rec.RWName];
//        [warePriceLabel setText:[NSString stringWithFormat:@"%0.2f",rec.RWPrice]];
//    }
}

- (void)cellSelected:(UIGestureRecognizer *)gesRec
{
    UITableViewCell * cell = (UITableViewCell *)gesRec.view;
    if (cell != selectedCell) {
        [cell viewWithTag:11].alpha = 0;
        [selectedCell viewWithTag:11].alpha = 0.3;
        selectedCell = cell;
        NSInteger index = cell.tag;
        selectedIndex = index;
        RecomWare* rec = [wareArray objectAtIndex:index];
        [rectWareShowView getImage:rec.RWPicLink defaultImage:default_ware_image];
        [self setWareNameWithName:rec.RWName];
        [warePriceLabel setText:[NSString stringWithFormat:@"%0.2f",rec.RWPrice]];
    }
}

-(void)pressShowPic{
    
    if ([wareArray count]> selectedIndex) {
        RecomWare* showPicWare = [wareArray objectAtIndex:selectedIndex];
        ShopWebViewController  *webVC = [[ShopWebViewController alloc] initWithNibName:nil bundle:nil];
        [[MainTabBarController sharedMainViewController].view addSubview:webVC.view];
        [webVC setRecWebUrl:showPicWare.RWShopLink wareName:showPicWare.RWName wareId:showPicWare.RWID warePrice:showPicWare.RWPrice shopName:showPicWare.RWShop shopIndex:0 imgLink:showPicWare.RWPicLink];
        [webVC show];
    }
    
    
}


- (void)setWareNameWithName:(NSString *)name
{

    CGSize size = [name sizeWithFont: PMFont(20)];
    if (size.width >460) {
        
        if (size.width>700) {
            name = [name substringToIndex:35];
            name = [name stringByAppendingString:@"..."];
            
        }
        [wareNameLabel setNumberOfLines:2];
        [wareNameLabel setFrame:CGRectMake(18, 8, 460, 48)];
    }else{
        [wareNameLabel setNumberOfLines:1];
        [wareNameLabel setFrame:CGRectMake(18, 8, 460, 24)];
    }
    [wareNameLabel setText:name];
}
@end
