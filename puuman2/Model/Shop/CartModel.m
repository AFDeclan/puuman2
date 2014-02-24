//
//  CartModel.m
//  puman
//
//  Created by 陈晔 on 13-9-9.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "CartModel.h"
#import "BabyData.h"
#import "ErrorLog.h"

static CartModel *instance;

@implementation CartModel


+ (CartModel *)sharedCart
{
    if (!instance)
    {
        instance = [[self alloc] init];
    }
    return instance;
}

- (CartModel *)init
{
    self = [super init];
    if (self)
    {
        [self buildCart];
    }
    return self;
}

- (void)buildCart
{
    _uid = [UserInfo sharedUserInfo].UID;
    [self readUserDefault];
    if (_uid != defaultUserID)
    {
        NSInteger max_cdid = 0;
        for (NSDictionary *cartWare in _cartWares_done)
        {
            NSInteger cdid = [[cartWare valueForKey:@"CDID"] integerValue];
            if (cdid > max_cdid) max_cdid = cdid;
        }
        [self updateCartDoneFromServer:max_cdid];
    }
}

- (void)readUserDefault
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _cartWares_done = [[NSMutableArray alloc] initWithArray:[userDefault valueForKey:[self userDefaultKeyForDone]]];
    _cartWares_undo = [[NSMutableArray alloc] initWithArray:[userDefault valueForKey:[self userDefaultKeyForUndo]]];
}

- (void)saveToUserDefault
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:_cartWares_done forKey:[self userDefaultKeyForDone]];
    [userDefault setValue:_cartWares_undo forKey:[self userDefaultKeyForUndo]];
}

- (NSString *)userDefaultKeyForDone
{
    return [NSString stringWithFormat:@"CartDone_User_%d", _uid];
}

- (NSString *)userDefaultKeyForUndo
{
    return [NSString stringWithFormat:@"CartUndo_User_%d", _uid];
}

- (void)updateCartDoneFromServer:(NSInteger)maxCdid
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_GetCartDone;
    [request setTimeOutSeconds:60];
    [request setParam:[NSString stringWithFormat:@"%d", _uid] forKey:@"UID"];
    [request setParam:[NSString stringWithFormat:@"%d", maxCdid] forKey:@"CDID_local"];
    [request setDelegate:self];
    [request setResEncoding:PumanRequestRes_JsonEncoding];
    [request postAsynchronous];
}


- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.resObj && [afRequest.resObj isKindOfClass:[NSArray class]])
    {
        [_cartWares_done addObjectsFromArray:afRequest.resObj];
        [self saveToUserDefault];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_CartDoneReceived object:nil];
    }
}

- (void)update:(BOOL)force
{
    if (!force && _uid == [UserInfo sharedUserInfo].UID) return;
    [self buildCart];
}

- (Ware *)getDoneWareAtIndex:(NSInteger)index
{
    Ware *w = [[Ware alloc] init];
    [w initWithCartDone:[_cartWares_done objectAtIndex:index]];
    return w;
}

- (NSDate *)getDoneTimeAtIndex:(NSInteger)index
{
    NSString *dateStr = [[_cartWares_done objectAtIndex:index] objectForKey:@"receiveTime"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [dateFormatter dateFromString:dateStr];
}

- (NSInteger)flagAtIndex:(NSInteger)index
{
    NSString *flags = [[_cartWares_undo objectAtIndex:index] objectForKey:@"flags"];
    if (!flags) return 0;
    else return [flags integerValue];
}

- (Ware *)getUndoWareAtIndex:(NSInteger)index
{
    Ware *w = [[Ware alloc] init];
    NSInteger wid = [[[_cartWares_undo objectAtIndex:index] objectForKey:@"WID"] integerValue];
    [w getFromUserDefault:wid];
    return w;
}

- (NSDate *)getUndoTimeAtIndex:(NSInteger)index
{
    return [[_cartWares_undo objectAtIndex:index] objectForKey:@"Date"];
}

- (BOOL)wareIsInCart:(Ware *)ware
{
    for (NSDictionary *cartWare in _cartWares_undo)
    {
        if (ware.WID == [[cartWare objectForKey:@"WID"] integerValue])
            return YES;
    }
    return NO;
}

- (void)addWareIntoCart:(Ware *)ware
{
    [ware saveToUserDefault];
    NSDictionary *cartWare = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", ware.WID], @"WID", [NSDate date], @"Date", nil];
    [_cartWares_undo addObject:cartWare];
    [self saveToUserDefault];
}

- (void)deleteWareFromCart:(NSInteger)wid
{
    for (NSInteger i=0; i<[_cartWares_undo count]; i++)
    {
        NSDictionary *cartWare = [_cartWares_undo objectAtIndex:i];
        if ([[cartWare objectForKey:@"WID"] integerValue] == wid)
        {
            [_cartWares_undo removeObjectAtIndex:i];
            [self saveToUserDefault];
            break;
        }
    }
}

- (NSInteger)UndoCount
{
    return [_cartWares_undo count];
}

- (NSInteger)DoneCount
{
    return [_cartWares_done count];
}

- (void)addFlagForWid:(NSInteger)wid
{
    for (int i=0; i<[_cartWares_undo count]; i++)
    {
        NSDictionary *cartWare = [_cartWares_undo objectAtIndex:i];
        if ([[cartWare objectForKey:@"WID"]integerValue] == wid)
        {
            NSInteger flags = [[cartWare objectForKey:@"flags"]integerValue];
            flags ++;
            if (flags > 5) flags = 5;
            NSMutableDictionary *nCartWare = [[NSMutableDictionary alloc]initWithDictionary:cartWare];
            [nCartWare setObject:[NSString stringWithFormat:@"%d", flags] forKey:@"flags"];
            [_cartWares_undo removeObjectAtIndex:i];
            [_cartWares_undo insertObject:nCartWare atIndex:i];
        }
    }
    [self saveToUserDefault];
}

- (void)minusFlagForWid:(NSInteger)wid
{
    for (int i=0; i<[_cartWares_undo count]; i++)
    {
        NSDictionary *cartWare = [_cartWares_undo objectAtIndex:i];
        if ([[cartWare objectForKey:@"WID"]integerValue] == wid)
        {
            NSInteger flags = [[cartWare objectForKey:@"flags"]integerValue];
            flags --;
            if (flags < 0) flags = 0;
            NSMutableDictionary *nCartWare = [[NSMutableDictionary alloc]initWithDictionary:cartWare];
            [nCartWare setObject:[NSString stringWithFormat:@"%d", flags] forKey:@"flags"];
            [_cartWares_undo removeObjectAtIndex:i];
            [_cartWares_undo insertObject:nCartWare atIndex:i];
        }
    }
    [self saveToUserDefault];
}

- (NSArray *)getWaresWithOrder
{
    NSMutableArray  *rankWares = [[NSMutableArray alloc] init];
    
    NSMutableArray *ware1 = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *ware2 = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *ware3 =  [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *ware4 =  [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *ware5 =  [[NSMutableArray alloc] initWithCapacity:1];
  if (![[BabyData sharedBabyData] babyHasBorned]) {
        if ([UserInfo sharedUserInfo].identity == Mother) {
            for (NSDictionary *dic in _cartWares_undo) {
                Ware *w = [[Ware alloc] init];
                NSInteger wid = [[dic objectForKey:@"WID"] integerValue];
                [w getFromUserDefault:wid];
                if (w.WType == 2)
                {
                    [ware1 addObject:w];
                }else if (w.WType == 9 && w.WType2 == 1)
                {
                    [ware2 addObject:w];
                }else if (w.WType == 9&&w.WType2 == 9)
                {
                    [ware3 addObject:w];
                }else if (w.WType == 9&&w.WType2 == 8)
                {
                    [ware4 addObject:w];
                }
                else if (w.WType == 9&&w.WType2 == 6)
                {
                    [ware5 addObject:w];
                }
                
            }

        }
        if ([UserInfo sharedUserInfo].identity == Father) {
            for (NSDictionary *dic in _cartWares_undo) {
                Ware *w = [[Ware alloc] init];
                NSInteger wid = [[dic objectForKey:@"WID"] integerValue];
                [w getFromUserDefault:wid];
                if (w.WType == 1)
                {
                    [ware1 addObject:w];
                }else if (w.WType == 3)
                {
                    [ware2 addObject:w];
                }else if (w.WType == 6)
                {
                    [ware3 addObject:w];
                }else if (w.WType == 8)
                {
                    [ware4 addObject:w];
                }
                else if (w.WType == 4&&w.WType2 == 1)
                {
                    [ware5 addObject:w];
                }
                
            }

        }
    }else{
        for (NSDictionary *dic in _cartWares_undo) {
            Ware *w = [[Ware alloc] init];
            NSInteger wid = [[dic objectForKey:@"WID"] integerValue];
            [w getFromUserDefault:wid];
            if (w.WType == 1)
            {
                [ware1 addObject:w];
            }else if (w.WType == 6)
            {
                [ware2 addObject:w];
            } else if (w.WType == 4&&w.WType2 == 0)
            {
                [ware3 addObject:w];
            }
            else if (w.WType == 3)
            {
                [ware4 addObject:w];
            }
           else if (w.WType == 8)
            {
                [ware5 addObject:w];
            }
            
        }

    }
          [rankWares addObject:ware1];
          [rankWares addObject:ware2];
          [rankWares addObject:ware3];
          [rankWares addObject:ware4];
          [rankWares addObject:ware5];
    
    return rankWares;
}
@end
