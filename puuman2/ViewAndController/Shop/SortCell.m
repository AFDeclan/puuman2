//
//  SortCell.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "SortCell.h"
#import "UniverseConstant.h"
#import "ShopClassModel.h"
#import "ShopModel.h"
#import "ShopViewController.h"

@implementation SortCell
@synthesize flagTag = _flagTag;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (id)init{
    
    return [self initWithFrame:CGRectMake(0, 0, 96, 88)];
}

- (void)initialization
{
    [self setBackgroundColor:PMColor6];
    UIView *wareShowView = [[UIView alloc] initWithFrame:CGRectMake(20, 16, 56, 56)];
    wareShowView.layer.masksToBounds = YES;
    wareShowView.layer.cornerRadius = 28;
    [self addSubview:wareShowView];
    wareImgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    [wareShowView addSubview:wareImgView];
    
    UIImageView *circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    [wareShowView addSubview:circleImg];
    [circleImg setImage:[UIImage imageNamed:@"ware_circle_bg.png"]];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 72, 96, 16)];
    [titleLabel setFont:PMFont3];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:PMColor1];
    [self addSubview:titleLabel];
    
    selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 96, 88)];
    [selectedBtn addTarget:self action:@selector(selected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectedBtn];

}

- (void)setFlagTag:(NSInteger)flagTag
{
    _flagTag = flagTag;
    [titleLabel setText:[ShopClassModel titleForSectionAtIndex:[ShopModel sharedInstance].sectionIndex andSubType:flagTag]];
    
}

- (void)selected
{
    PostNotification(Noti_HiddenMenu, nil);
    PostNotification(Noti_ShowWareInfo, [NSNumber numberWithBool:NO]);
    [[ShopModel sharedInstance] setSubClassIndex:_flagTag];
    PostNotification(Noti_ShowAllShopView, [NSNumber numberWithBool:YES]);
}

@end
