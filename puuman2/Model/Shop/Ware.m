//
//  Ware.m
//  puman
//
//  Created by 胡杨林 on 7/4/13.
//  Copyright (c) 2013 创始人团队. All rights reserved.
//

#import "Ware.h"

@implementation Ware

@synthesize WID = _WID;
@synthesize WName = _WName;
@synthesize WPicLink = _WPicLink;
@synthesize WPicLinkSmall = _WPicLinkSmall;
@synthesize WPriceLB = _WPriceLB;
@synthesize WPriceUB = _WPriceUB;
@synthesize WShop = _WShop;
@synthesize WType = _WType;
@synthesize WType2 = _WType2;
@synthesize WDetail = _WDetail;
@synthesize WMeta = _WMeta;
@synthesize propertyKeys = _propertyKeys;
@synthesize propertyVals = _propertyVals;
@synthesize shopInfoList = _shopInfoList;

-(void) initWithDictionary:(NSDictionary *)data{
    if( data == nil )
        return;
    _data = data;
    _WID = [[data objectForKey:@"WID"] integerValue];
    _WShop = [data objectForKey:@"WShop"];
    _WType = [[data objectForKey:@"WType"] integerValue];
    _WType2 = [[data objectForKey:@"WType2"] integerValue];
    _WPriceLB = [[data objectForKey:@"WPriceLB"] doubleValue];
    _WPriceUB = [[data objectForKey:@"WPriceUB"] doubleValue];
    _WName = [data objectForKey:@"WName"];
    _WPicLink = [data objectForKey:@"WPicLink"];
    _WPicLinkSmall = [data objectForKey:@"WPicLinkSmall"];
    _WDetail = [data objectForKey:@"WDetail"];
    id f = [data objectForKey:@"WFlagNum"];
    if( f == nil )
        _flagNum = 0;
    else
        _flagNum = [f integerValue];
    _WMeta = [[NSMutableDictionary alloc] init];
    
    if( [[data objectForKey:@"WareMeta"] isEqualToString:@"yes"] ){
        NSEnumerator* enumerator = [data keyEnumerator];
        id obj = [enumerator nextObject];
        while( obj != nil ){
            if( ![obj hasPrefix:@"W"]){
                id val = [data objectForKey:obj];
                if( val != nil )
                   [_WMeta setValue:val forKey:obj];
            }
            obj = [enumerator nextObject];
        }
        [_WMeta setValue:@"yes" forKey:@"hasWare"];
    }else
        [_WMeta setValue:@"no" forKey:@"hasWare"];
    
    self.cartDoneWare = NO;
}

-(void) initWithCartDone:(NSDictionary *)data{
    if( data == nil )
        return;
    _WID = [[data objectForKey:@"WID"] integerValue];
    _WPriceLB = [[data objectForKey:@"pro_price"] doubleValue];
    _WName = [data objectForKey:@"WName"];
    _WPicLink = [data objectForKey:@"wpiclink"];
    _WPicLinkSmall = [data objectForKey:@"WPicLinkSmall"];
    _pro_shop = [data objectForKey:@"shop"];
    
    _orderTime = [NSString stringWithString:[data objectForKey:@"orderTime"]];
    _receiveTime = [NSString stringWithString:[data objectForKey:@"receiveTime"]];
    _CDID = [[data objectForKey:@"CDID"] integerValue];
    _pro_count = [[data objectForKey:@"pro_vol"] integerValue];
    _flagNum = 0;
    _uidForCartDone = [[data objectForKey:@"uid"] integerValue];
    
    [self setCartDoneWare:YES];
//    //[self getImage];
}



-(void) initWithWare:(Ware*)ware{
    if( ware == nil )
        return;
    _WID = ware.WID;
    id tp = ware.WShop;
    if( tp == nil )
        _WShop = @"";
    else
        _WShop = [NSString stringWithString:tp];
    
    tp = ware.WName;
    if( tp == nil)
        _WName = @"";
    else
        _WName = [NSString stringWithString:tp];
    
    tp = ware.WPicLink;
    if( tp == nil )
        _WPicLink = @"";
    else
        _WPicLink = [[NSString alloc] initWithString:tp];
    
    _WPicLinkSmall = [[NSString alloc] initWithString:ware.WPicLinkSmall];
    
    _WType = ware.WType;
    _WType2 = ware.WType2;
    _WPriceLB = ware.WPriceLB;
    _WPriceUB = ware.WPriceUB;
    _flagNum = [ware getFlags];
    
    _WMeta = [[NSMutableDictionary alloc] initWithDictionary:ware.WMeta];
}


-(NSString*) description{
    return [NSString stringWithFormat:@"WID:%d\nWType:%d\nWShop:%@\nWName:%@\nWPriceLB:%.2f\nWPriceUB:%.2f\nImageUrl:%@",_WID, _WType, _WShop, _WName, _WPriceLB, _WPriceUB, _WPicLink ];
}

- (BOOL)getFromUserDefault:(NSInteger)mid{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* dic = [userDefault objectForKey:[NSString stringWithFormat:@"Ware%d", mid]];
    [self initWithDictionary:dic];
    self.cartDoneWare = NO;
    if (dic) return YES;
    else return NO;
}

- (void)saveToUserDefault
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:_data forKey:[NSString stringWithFormat:@"Ware%d", _WID]];
}

- (NSInteger) getFlags
{
    return _flagNum;
}

-(NSString*)getStringFromInteger:(NSInteger)value{
    return [[NSString alloc] initWithFormat:@"%d", value];
}

-(NSString*)getStringFromDouble:(double)value{
    return [[NSString alloc] initWithFormat:@"%.2f", value];
}

-(void)flag_plus{
    if( _flagNum == 5 )
        return;
    _flagNum++;
}

-(void)flag_minus{
    if( _flagNum == 0 )
        return;
    _flagNum--;
}

- (void)buildPropertiesInfo
{
    NSMutableArray *allKeys = [[NSMutableArray alloc] init];
    NSMutableArray *propertyVals = [[NSMutableArray alloc] init];
    NSMutableArray *propertyKeys = [[NSMutableArray alloc] init];
    for (NSString *key in _WMeta)
    {
        if ([[key componentsSeparatedByString:@"|"] count] > 1)
        {
            NSInteger priority = [[[key componentsSeparatedByString:@"|"]objectAtIndex:0] integerValue];
            if (priority < 100) [allKeys addObject:key];
        }
    }
    NSArray *sortedKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id key1, id key2){
        NSInteger priority1 = [[[key1 componentsSeparatedByString:@"|"]objectAtIndex:0] integerValue];
        NSInteger priority2 = [[[key2 componentsSeparatedByString:@"|"]objectAtIndex:0] integerValue];
        if (priority1 < priority2) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    for (int i = 0; i < [sortedKeys count]; i++) {
        NSString *key = [sortedKeys objectAtIndex:i];
        NSRange userNameRange = [key rangeOfString:@"shoplink"];
        if (userNameRange.location == NSNotFound) {
            [propertyKeys addObject:[[key componentsSeparatedByString:@"|"] lastObject]];
            [propertyVals addObject:[_WMeta valueForKey:key]];
        }
    }
    _propertyKeys = propertyKeys;
    _propertyVals = propertyVals;
}

- (void)buildShopInfoList
{
    NSMutableArray *shopsInfo = [[NSMutableArray alloc] init];
    // 获取商店列表
    NSString *shop = _WShop;
    NSArray *shopList = nil;
    if( shop != nil && [shop length] > 0 )
        shopList = [shop componentsSeparatedByString:@"/"];
    
    // 价格列表和商品链接列表
    
    NSString *link, *price, *name;
    
    for( NSString * s in shopList )
    {
        link = [_WMeta objectForKey:[NSString stringWithFormat:@"%d|shoplink%@", ShopInfoPriority, s]];
        if( link != nil )
        {
            NSString* pkey = nil;
            int ps = [s intValue];
            switch(ps){
                case 1:
                    pkey =[NSString stringWithFormat:@"%d|京东价",ShopInfoPriority];
                    break;
                case 2:
                    pkey = [NSString stringWithFormat:@"%d|当当价",ShopInfoPriority];
                    break;
                case 3:
                    pkey = [NSString stringWithFormat:@"%d|亚马逊价",ShopInfoPriority];
                    break;
                case 4:
                    pkey = [NSString stringWithFormat:@"%d|苏宁价",ShopInfoPriority];
                    break;
            }
            if ( pkey != nil ){
                price = [_WMeta objectForKey:pkey];
                if (price == nil) price = @"";
                if ([price doubleValue] <= 0) continue;
                name = [self shopNameForShopIndex:s];
                NSDictionary *shopInfo = [NSDictionary dictionaryWithObjectsAndKeys:link, kShopLinkKey, price, kPriceKey, name, kShopNameKey, s, kShopIndexKey, nil];
                [shopsInfo addObject:shopInfo];
            }
        }
    }
    [shopsInfo sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double price1 = [[obj1 objectForKey:kPriceKey] doubleValue];
        double price2 = [[obj2 objectForKey:kPriceKey] doubleValue];
        if (price1 < price2) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    _shopInfoList = shopsInfo;
}

- (NSString *)shopNameForShopIndex:(NSString *)shopIndex
{
    switch ([shopIndex integerValue]) {
        case 1:
            return @"京东商城";
        case 2:
            return @"当当网";
        case 3:
            return @"亚马逊";
        case 4:
            return @"苏宁";
        default:
            return @"其他商城";
    }
    
}

- (NSArray *)propertyKeys
{
    if (!_propertyKeys) [self buildPropertiesInfo];
    return _propertyKeys;
}

- (NSArray *)propertyVals
{
    if (!_propertyVals) [self buildPropertiesInfo];
    return _propertyVals;
}

- (NSArray *)shopInfoList
{
    if (!_shopInfoList) [self buildShopInfoList];
    return _shopInfoList;
}
@end
