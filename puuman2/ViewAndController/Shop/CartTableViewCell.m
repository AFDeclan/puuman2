//
//  CartTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CartTableViewCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation CartTableViewCell
@synthesize  isCompare = _isCompare;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        wareImg = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [wareImg getImage:@"" defaultImage:@"default_ware_image                                                                                                                           "];
        [self.contentView addSubview:wareImg];
        infoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 0, 448, 80)];
        [infoScrollView setBackgroundColor:PMColor5];
        [infoScrollView setContentSize:CGSizeMake(528, 80)];
        [infoScrollView setDelegate:self];
        [infoScrollView setShowsHorizontalScrollIndicator:NO];
        [infoScrollView setShowsVerticalScrollIndicator:NO];
        [self.contentView addSubview:infoScrollView];
        
        wareName = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, 428, 16)];
        wareName.backgroundColor = [UIColor clearColor];
        wareName.textColor = PMColor1;
        wareName.font = PMFont3;
        [infoScrollView addSubview:wareName];
        UIImageView *rmb_icon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 48, 12, 12)];
        [rmb_icon setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
        [infoScrollView addSubview:rmb_icon];

        
        warePrice= [[UILabel alloc] initWithFrame:CGRectMake(28, 46, 320, 24)];
        warePrice.backgroundColor = [UIColor clearColor];
        warePrice.textColor = PMColor6;
        warePrice.font = PMFont1;
        [infoScrollView addSubview:warePrice];
        
        wareTime= [[UILabel alloc] init];
        wareTime.backgroundColor = [UIColor clearColor];
        wareTime.textColor = PMColor3;
        wareTime.font = PMFont4;
        [infoScrollView addSubview:wareTime];
        
        wareShop= [[UILabel alloc] initWithFrame:CGRectMake(352, 48, 80, 10)];
        wareShop.backgroundColor = [UIColor clearColor];
        wareShop.textColor = PMColor3;
        wareShop.font = PMFont4;
        [wareShop setTextAlignment:NSTextAlignmentRight];
        [infoScrollView addSubview:wareShop];
        
        delBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(448, 0, 80, 80)];
        [delBtn setTitle:@"" andImg:[UIImage imageNamed:@"icon_delete_shop.png"] andButtonType:kButtonTypeOne];
        [delBtn setIconFrame:CGRectMake(0, 0, 36, 36)];
        [delBtn addTarget:self action:@selector(delBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [delBtn setBackgroundColor:[UIColor redColor]];
        [infoScrollView addSubview:delBtn];
        time_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [time_icon setImage:[UIImage imageNamed:@"icon_time_shop.png"]];
        [infoScrollView addSubview:time_icon];
       
        
    }
    return self;
}

- (void)setTimeIconLocation
{

    CGSize size = [wareTime.text sizeWithFont:PMFont4];
    [wareTime setFrame:CGRectMake(432-size.width, 64, size.width, size.height)];
    SetViewLeftUp(time_icon, 64, wareTime.frame.origin.x-14);
    
}

- (void)buildCellWithWare:(Ware *)ware  flagCount:(NSInteger)flagCount wareTime:(NSString *)wt
{
    wareName.text = ware.WName;
    warePrice.text = [NSString stringWithFormat:@"%.2f~%.2f", ware.WPriceLB, ware.WPriceUB];
   // wareShop.text = ware.WShop;
    wareTime.text = wt;
    [self setTimeIconLocation];
    [wareImg getImage:ware.WPicLink defaultImage:default_ware_image];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    float x = scrollView.contentOffset.x;
    if (x>=80) {
       
     //  PostNotification(Noti_CartCellShowDelBtn, [NSNumber numberWithInteger:self.tag]);
        scrollView.pagingEnabled=NO;
        if (x>=160) {
            scrollView.contentOffset=CGPointMake(160, 0);
        }
        
    }else if (x<0) {
        scrollView.pagingEnabled=NO;
        
        if (x<-80) {
            scrollView.contentOffset=CGPointMake(-80, 0);
        }
        
    }else
    {
        scrollView.pagingEnabled=YES;
       
    }
    
}

- (void)delBtnPressed
{
    [MobClick event:umeng_event_click label:@"Delete_ShopInfoLeftCell"];
  //  PostNotification(Noti_DeleteCartWare, [NSNumber numberWithInteger:_ware.WID]);

}

- (void)setIsCompare:(BOOL)isCompare
{

}

@end
