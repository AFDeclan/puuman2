//
//  LocationCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "LocationCell.h"
#import "UniverseConstant.h"

@implementation LocationCell
@synthesize choose = _choose;
@synthesize flagIndex = _flagIndex;

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
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(24, 0, 32, 32)];
    [icon setImage:[UIImage imageNamed:@"icon_selected_cart.png"]];
    [self.contentView addSubview:icon];

 
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(icon)+ViewX(icon)+16, 0, 120, 32)];
    [locationLabel setFont:PMFont2];
    [locationLabel setText:@"北京"];
    [locationLabel setTextColor:PMColor2];
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:locationLabel];
    [MyNotiCenter addObserver:self selector:@selector(selectedLocation:) name:Noti_SelectedLocation object:nil];
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

- (void)selectedLocation:(NSNotification *)notification
{
    NSInteger selectedNum = [[notification object] integerValue];
    if (selectedNum == _flagIndex) {
        [icon setAlpha:1];
    }else{
        [icon setAlpha:0];
    }
}

- (void)setChoose:(BOOL)choose
{
    _choose = choose;
    if (_choose) {
        [icon setAlpha:1];
    }else{
        [icon setAlpha:0];

    }
    
}
@end
