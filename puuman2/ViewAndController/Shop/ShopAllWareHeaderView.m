//
//  ShopAllWareHeaderView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopAllWareHeaderView.h"
#import "ColorsAndFonts.h"
#import "ShopClassModel.h"

@implementation ShopAllWareHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:PMColor5];
        icon_ware = [[UIImageView alloc] initWithFrame:CGRectMake(16, 24, 32, 32)];
        [self addSubview:icon_ware];
        icon_tri = [[UIImageView alloc] initWithFrame:CGRectMake(588, 24, 16, 28)];
        [icon_tri setImage:[UIImage imageNamed:@"tri_blue_right.png"]];
        [self addSubview:icon_tri];
        
        partLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 0, 2)];
        [partLine setBackgroundColor:RGBColor(210, 227, 238)];
        [self addSubview:partLine];
        
        wareLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 24, 0, 28)];
        [wareLabel setBackgroundColor:[UIColor clearColor]];
        [wareLabel setFont:PMFont1];
        [wareLabel setTextColor:PMColor6];
        [self addSubview:wareLabel];
        
        moreLabel= [[UILabel alloc] initWithFrame:CGRectMake(548, 24, 40, 28)];
        [moreLabel setBackgroundColor:[UIColor clearColor]];
        [moreLabel setTextAlignment:NSTextAlignmentCenter];
        [moreLabel setFont:PMFont4];
        [moreLabel setTextColor:PMColor6];
        [self addSubview:moreLabel];
      
    }
    return self;
}

- (void)setStatusWithKindIndex:(NSInteger)index andUnfold:(BOOL)unfold
{
    [icon_ware setImage:[ShopClassModel iconForSectionAtIndex:index]];
    NSString *titleName = [ShopClassModel titleForSectionAtIndex:index];
    CGSize size = [titleName sizeWithFont:wareLabel.font];
    [wareLabel setText:titleName];
    CGRect nameFrame = wareLabel.frame;
    nameFrame.size.width = size.width;
    [wareLabel setFrame:nameFrame];
     CGRect partFrame = partLine.frame;
    partFrame.origin.x = nameFrame.origin.x +nameFrame.size.width +2;
    partFrame.size.width = moreLabel.frame.origin.x- partFrame.origin.x;
    [partLine setFrame:partFrame];
    
    if (unfold) {
        [moreLabel setText:@"返回"];
        [icon_tri setImage:[UIImage imageNamed:@"tri_blue_left.png"]];
    }else{
         [moreLabel setText:@"更多"];
        [icon_tri setImage:[UIImage imageNamed:@"tri_blue_right.png"]];
    }
    
}



@end
