//
//  RecomWare.h
//  puman
//
//  Created by Declan on 14-01-23.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecomWare : NSObject{
}

@property (nonatomic, assign, readonly) NSInteger RWID;
@property (nonatomic, assign, readonly) NSInteger RWStatus;
@property (nonatomic, assign, readonly) CGFloat RWPrice;
@property (nonatomic, retain, readonly) NSString *RWProId;
@property (nonatomic, assign, readonly) NSInteger RWType;
@property (nonatomic, retain, readonly) NSString *RWName;
@property (nonatomic, retain, readonly) NSString *RWShop;
@property (nonatomic, retain, readonly) NSString *RWPicLink;
@property (nonatomic, retain, readonly) NSString *RWPlat;
@property (nonatomic, retain, readonly) NSString *RWShopLink;

@property (nonatomic, retain) NSDictionary *DataDic;

@end
