//
//  CartModel.h
//  puman
//
//  Created by 陈晔 on 13-9-9.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ware.h"
#import "UserInfo.h"

@interface CartModel : NSObject <AFRequestDelegate>
{
    NSMutableArray *_cartWares_done;
    NSMutableArray *_cartWares_undo;
    NSInteger _uid;
}

+ (CartModel *)sharedCart;

- (void)update:(BOOL)force;

- (NSInteger)DoneCount;
- (Ware*)getDoneWareAtIndex:(NSInteger)index;
- (NSDate*)getDoneTimeAtIndex:(NSInteger)index;

- (NSInteger)UndoCount;
- (Ware*)getUndoWareAtIndex:(NSInteger)index;
- (NSDate*)getUndoTimeAtIndex:(NSInteger)index;
- (NSInteger)flagAtIndex:(NSInteger)index;

- (void)addFlagForWid:(NSInteger)wid;
- (void)minusFlagForWid:(NSInteger)wid;

- (BOOL)wareIsInCart:(Ware *)ware;
- (void)addWareIntoCart:(Ware*) ware;
- (void)deleteWareFromCart:(NSInteger)wid;
- (NSArray *)getWaresWithOrder;
@end
