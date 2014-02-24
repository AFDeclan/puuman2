//
//  Ware.h
//  puman
//
//  Created by 胡杨林 on 7/4/13.
//  Copyright (c) 2013 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniverseConstant.h"
#import "ASIHTTPRequest.h"

#ifndef _puman_WARE
#define _puman_WARE

#define kShopLinkKey        @"Link"
#define kPriceKey           @"Price"
#define kShopNameKey        @"Name"
#define kShopIndexKey       @"Index"

#define ShopInfoPriority 127

@interface Ware : NSObject<ASIHTTPRequestDelegate>{
    
    NSDictionary *_data;

    NSMutableDictionary *_WMeta;
    
    // 已购商品相关信息
    NSString* _orderTime;
    NSString* _receiveTime;
    NSString* _pro_shop;
    NSInteger _pro_count;
    NSInteger _uidForCartDone;
    NSInteger _CDID;
    NSInteger _flagNum;  // 商品比较时的红旗数量
}

@property (assign, nonatomic, readonly) NSInteger WID;
@property (retain, nonatomic, readonly) NSString *WName;
@property (retain, nonatomic, readonly) NSString *WPicLink;
@property (retain, nonatomic, readonly) NSString *WPicLinkSmall;
@property (assign, nonatomic, readonly) double WPriceLB;
@property (assign, nonatomic, readonly) double WPriceUB;
@property (retain, nonatomic, readonly) NSString *WShop;
@property (assign, nonatomic, readonly) NSInteger WType;
@property (assign, nonatomic, readonly) NSInteger WType2;
@property (retain, nonatomic, readonly) NSString *WDetail;
@property (retain, nonatomic, readonly) NSMutableDictionary *WMeta;
@property (retain, nonatomic, readonly) NSArray *propertyKeys;
@property (retain, nonatomic, readonly) NSArray *propertyVals;
@property (retain, nonatomic, readonly) NSArray *shopInfoList;
@property (assign, nonatomic) BOOL cartDoneWare;

-(void) initWithDictionary:(NSDictionary*) data;
-(void) initWithCartDone:(NSDictionary*) data;
-(void) initWithWare:(Ware*)ware;
-(BOOL) getFromUserDefault:(NSInteger)wid;
- (void)saveToUserDefault;
 
-(void) flag_plus;
-(void) flag_minus;

@end

#endif 
