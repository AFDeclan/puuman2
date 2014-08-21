//
//  OrderWaresHeaderView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-24.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "OrderWaresHeaderView.h"
#import "UniverseConstant.h"
#import "OrderDetailViewController.h"
#import "MainTabBarController.h"

@implementation OrderWaresHeaderView
@synthesize section = _section;
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
    [self setBackgroundColor:[UIColor whiteColor]];
    content = [[UIView alloc] initWithFrame:CGRectMake(0, 16, 540, 32)];
    [content setBackgroundColor:PMColor5];
    [self addSubview:content];
    
    icon_status = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 12, 12)];
    [content addSubview:icon_status];
    
    label_status = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 36, 32)];
    [label_status setBackgroundColor:[UIColor clearColor]];
    [label_status setTextAlignment:NSTextAlignmentCenter];
    [label_status setFont:PMFont3];
    [content addSubview:label_status];
    info_date = [[UILabel alloc] initWithFrame:CGRectMake(68, 0, 160, 32)];
    [info_date setBackgroundColor:[UIColor clearColor]];
    [info_date setTextAlignment:NSTextAlignmentCenter];
    [info_date setTextColor:PMColor3];
    [info_date setFont:PMFont4];
    [content addSubview:info_date];
    
    label_detail = [[UILabel alloc] initWithFrame:CGRectMake(540 - 64, 0, 64, 32)];
    [label_detail setBackgroundColor:[UIColor clearColor]];
    [label_detail setTextColor:PMColor2];
    [label_detail setFont:PMFont3];
    [label_detail setText:@"详细"];
    [label_detail setTextAlignment:NSTextAlignmentCenter];
    [content addSubview:label_detail];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(540 - 64, 0, 64, 32)];
    [button addTarget:self action:@selector(selected) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [self  addSubview:button];

    
}

- (void)setSection:(NSInteger)section
{
    _section = section;
    if (section  == 0) {
        [label_status setText:@"待付款"];
        [icon_status setImage:[UIImage imageNamed:@"order_paid_icon.png"]];
        [label_status setTextColor:PMColor6];
        [info_date setText:@"2014.03.04 20:30 下单"];

    }else if(section  == 1)
    {
        [label_status setText:@"已付款"];
        [icon_status setImage:[UIImage imageNamed:@"order_paid_icon.png"]];
        [label_status setTextColor:PMColor2];
        [info_date setText:@"2014.03.04 20:30 下单"];

        
    }else{
        [label_status setText:@"已收货"];
        [icon_status setImage:[UIImage imageNamed:@"order_paid_icon.png"]];
        [label_status setTextColor:PMColor2];
        [info_date setText:@"2014.03.04 20:30 下单"];

    }
}

- (void)selected
{
    OrderDetailViewController *detailVC =[[OrderDetailViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:detailVC.view];
    [detailVC setControlBtnType:kOnlyCloseButton];
    [detailVC setTitle:@"订单详情" withIcon:nil];
    [detailVC show];
}
@end
