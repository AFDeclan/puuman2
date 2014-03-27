//
//  RectRankSubCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RectRankSubCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
@implementation RectRankSubCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        iconWare =[[AFImageView alloc] initWithFrame:CGRectMake(8, 0, 96, 96)];
        [self.contentView addSubview:iconWare];
        
        UIView *infoVeiw= [[UIView alloc] initWithFrame:CGRectMake(0, 72, 112, 24)];
        [infoVeiw setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:infoVeiw];
        UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 112, 24)];
        [mask setBackgroundColor:[UIColor whiteColor]];
        [mask setAlpha:0.5];
        [infoVeiw addSubview:mask];
        
        UIImageView *rmb_icon = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 16, 16)];
        [rmb_icon setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
        [infoVeiw addSubview:rmb_icon];

        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 92, 24)];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setFont:PMFont2];
        [priceLabel setTextColor:PMColor6];
        [infoVeiw addSubview:priceLabel];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 112, 12)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:PMFont3];
        [nameLabel setTextColor:PMColor1];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:nameLabel];
    }
    return self;
}

- (void)bulidCellWithWareData:(RecomWare *)ware
{
    [priceLabel setText:[NSString stringWithFormat:@"%0.2f",ware.RWPrice]];
    [nameLabel setText:ware.RWName];
    [iconWare getImage:ware.RWPicLink defaultImage:default_ware_image];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
