//
//  RecomWare.m
//  puman
//
//  Created by iOptimize on 13-7-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "RecomWare.h"
#import "UniverseConstant.h"

@implementation RecomWare

@synthesize RWID = _RWID;
@synthesize RWName = _RWName;
@synthesize RWPicLink = _RWPicLink;
@synthesize RWPlat = _RWPlat;
@synthesize RWPrice = _RWPrice;
@synthesize RWProId = _RWProId;
@synthesize RWShop = _RWShop;
@synthesize RWStatus = _RWStatus;
@synthesize RWType = _RWType;
@synthesize RWShopLink = _RWShopLink;

@synthesize DataDic = _DataDic;

-(void)setDataDic:(NSDictionary *)DataDic
{
    _DataDic = DataDic;
    _RWID = [[DataDic objectForKey:@"WRID"] integerValue];
    _RWName = [DataDic objectForKey:@"RName"];
    _RWStatus = [[DataDic objectForKey:@"RStatus"] integerValue];
    _RWProId = [DataDic objectForKey:@"pro_id"];
    _RWType = [[DataDic objectForKey:@"WType"] integerValue];
    _RWPrice = [[DataDic objectForKey:@"RPrice"] doubleValue];
    _RWShop = [DataDic objectForKey:@"RShop"];
    _RWPlat = [DataDic objectForKey:@"RPlat"];
    _RWPicLink = [DataDic objectForKey:@"RPicLink"];
    _RWShopLink = [DataDic objectForKey:@"RLink"];
}


@end
