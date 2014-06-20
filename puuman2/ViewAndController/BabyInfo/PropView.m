//
//  PropView.m
//  puman
//
//  Created by 祁文龙 on 13-11-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "PropView.h"
#import "UserInfo.h"
#import "UniverseConstant.h"
#import "CartModel.h"
#import "BabyData.h"

@implementation PropView

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
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(96, 48,384, 346)];
    [self addSubview:bg];
    propWare1 = [[PropWare alloc] init];
    propWare2 = [[PropWare alloc] init];
    propWare3 = [[PropWare alloc] init];
    propWare4 = [[PropWare alloc] init];
    propWare5 = [[PropWare alloc] init];
    [self addSubview:propWare1];
    [self addSubview:propWare2];
    [self addSubview:propWare3];
    [self addSubview:propWare4];
    [self addSubview:propWare5];
    if (![[[UserInfo sharedUserInfo] babyInfo] WhetherBirth])
    {
        if ([UserInfo sharedUserInfo].identity == Mother) {
            [bg setImage:[UIImage imageNamed:@"pic2_equip_baby.png"]];
            [propWare1 setFrame:CGRectMake(188, 48, 80, 108)];
            [propWare2 setFrame:CGRectMake(12, 198, 80, 108)];
            [propWare3 setFrame:CGRectMake(148, 308, 80, 108)];
            [propWare4 setFrame:CGRectMake(460, 96, 80, 108)];
            [propWare5 setFrame:CGRectMake(465, 224, 80, 108)];
            [propWare1 setParentMenu:8 andChildMenu:7];
            [propWare2 setParentMenu:8 andChildMenu:1];
            [propWare3 setParentMenu:6 andChildMenu:6];
            [propWare4 setParentMenu:8 andChildMenu:8];
            [propWare5 setParentMenu:8 andChildMenu:6];
        }
        if ([UserInfo sharedUserInfo].identity == Father) {
            [bg setImage:[UIImage imageNamed:@"pic3_equip_baby.png"]];
            [propWare1 setFrame:CGRectMake(40, 56, 80, 108)];
            [propWare2 setFrame:CGRectMake(16, 224, 80, 108)];
            [propWare3 setFrame:CGRectMake(400, 30, 80, 108)];
            [propWare4 setFrame:CGRectMake(480, 138, 80, 108)];
            [propWare5 setFrame:CGRectMake(452, 250, 80, 108)];
            [propWare1 setParentMenu:10 andChildMenu:1];
            [propWare2 setParentMenu:10 andChildMenu:3];
            [propWare3 setParentMenu:10 andChildMenu:7];
            [propWare4 setParentMenu:10 andChildMenu:6];
            [propWare5 setParentMenu:10 andChildMenu:9];
        }
    }else{
        [bg setImage:[UIImage imageNamed:@"pic1_equip_baby.png"]];
        [propWare1 setFrame:CGRectMake(100, 48, 80, 108)];
        [propWare2 setFrame:CGRectMake(12, 224, 80, 108)];
        [propWare3 setFrame:CGRectMake(452, 48, 80, 108)];
        [propWare4 setFrame:CGRectMake(364, 224, 80, 108)];
        [propWare5 setFrame:CGRectMake(452, 312, 80, 108)];
        [propWare1 setParentMenu:0 andChildMenu:-1];
        [propWare2 setParentMenu:5 andChildMenu:-1];
        [propWare3 setParentMenu:3 andChildMenu:0];
        [propWare4 setParentMenu:2 andChildMenu:-1];
        [propWare5 setParentMenu:7 andChildMenu:-1];
    }
    [self setPropWares];
  
}
- (void)setPropWares
{
    props = [[CartModel sharedCart] getWaresWithOrder];
    NSArray *ware1  = [props objectAtIndex:0];
    NSArray *ware2  = [props objectAtIndex:1];
    NSArray *ware3  = [props objectAtIndex:2];
    NSArray *ware4  = [props objectAtIndex:3];
    NSArray *ware5  = [props objectAtIndex:4];
    if ([ware1 count] > 0) {
        [propWare1 initWithWare:[ware1 objectAtIndex:0]];
    }
    if ([ware2 count] > 0) {
        [propWare2 initWithWare:[ware2 objectAtIndex:0]];
    }
    if ([ware3 count] > 0) {
        [propWare3 initWithWare:[ware3 objectAtIndex:0]];
    }
    if ([ware4 count] > 0) {
        [propWare4 initWithWare:[ware4 objectAtIndex:0]];
    }
    
    if ([ware5 count] > 0) {
        [propWare5 initWithWare:[ware5 objectAtIndex:0]];
    }
    

}
- (void)reloadData
{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
  [self initialization];
}


@end
