//
//  RecomModel.h
//  PuumanForPhone
//
//  Created by Declan on 14-1-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecomWare.h"
#import "PumanRequest.h"

@interface RecomModel : NSObject <AFRequestDelegate>

@property (nonatomic, retain, readonly) NSMutableArray * topWares;
@property (nonatomic, retain, readonly) NSMutableArray * hotWares;
@property (nonatomic, retain, readonly) NSMutableArray * discountWares;
@property (nonatomic, retain, readonly) NSMutableArray * inUseWares;

@end