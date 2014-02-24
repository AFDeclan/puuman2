//
//  RecomModel.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "RecomModel.h"
#import "UniverseConstant.h"

@implementation RecomModel

@synthesize topWares = _topWares;
@synthesize hotWares = _hotWares;
@synthesize discountWares = _discountWares;
@synthesize inUseWares = _inUseWares;

- (id)init
{
    if (self = [super init])
    {
        [self loadFromLocal];
        [self updateFromServer];
        [MyNotiCenter addObserver:self selector:@selector(updateFromServer) name:Noti_Refresh object:nil];
    }
    return self;
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
    [AFBaseRequest endRequestFor:self];
}

- (void)loadFromLocal
{
    NSArray *data = [MyUserDefaults valueForKey:kUDK_RecWares];
    [self loadData:data];
}

- (void)saveToLocal:(NSArray *)data
{
    [MyUserDefaults setValue:data forKey:kUDK_RecWares];
}

- (void)loadData:(NSArray *)data
{
    _topWares = [[NSMutableArray alloc] init];
    _hotWares = [[NSMutableArray alloc] init];
    _discountWares = [[NSMutableArray alloc] init];
    for (NSDictionary *recWareData in data)
    {
        RecomWare *recWare = [[RecomWare alloc] init];
        recWare.DataDic = recWareData;
        switch (recWare.RWType) {
            case 4:
                [_topWares addObject:recWare];
                break;
            case 1:
                [_hotWares addObject:recWare];
                break;
            case 2:
                [_discountWares addObject:recWare];
                break;
            default:
                break;
        }
    }
    PostNotification(Noti_RecomWaresUpdated, nil);
}

- (void)updateFromServer
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_GetRecomWares;
    [request setTimeOutSeconds:60];
    [request setDelegate:self];
    [request setResEncoding:PumanRequestRes_JsonEncoding];
    [request postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.resObj && [afRequest.resObj isKindOfClass:[NSArray class]])
    {
        [self loadData:afRequest.resObj];
        [self saveToLocal:afRequest.resObj];
    }
}


@end
