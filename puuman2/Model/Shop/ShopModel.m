//
//  ShopModel.m
//  puman
//
//  Created by Declan on 13-12-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "ShopModel.h"
#import "Ware.h"
#import "PumanRequest.h"
#import <FMDatabase.h>

static ShopModel * instance;

const NSInteger kBatchCnt = 12;

@implementation ShopModel

@synthesize classIndex = _classIndex;
@synthesize subClassIndex = _subClassIndex;
@synthesize filters = _filters;
@synthesize filteredWares = _filteredWares;

@synthesize searchOn = _searchOn;
@synthesize searchKey = _searchKey;

+ (ShopModel *)sharedInstance
{
    if (!instance) instance = [[ShopModel alloc] init];
    return instance;
}

- (id)init
{
    if (self = [super init])
    {
        _wares = [[NSMutableDictionary alloc] init];
        _filters = [[NSMutableDictionary alloc] init];
        _filteredWares = [[NSMutableArray alloc] init];
        for (int i=0; i<kWareTypeCnt; i++)
        {
            _allWares[i] = [[NSMutableArray alloc] init];
            _filteredIds[i] = [[NSMutableDictionary alloc] init];
            _filterValues[i] = [[NSMutableDictionary alloc] init];
            _filterKeys[i] = [[NSMutableArray alloc] init];
        }
    }
    _classIndex = -1;
    _sectionIndex = -1;
    [self performSelectorInBackground:@selector(initData) withObject:nil];
    return self;
}

- (void)initData
{
    [self readFilterData];
    [self loadInitWares];
    if (_filteredWares.count == 0 && _classIndex > -1)
    {
        [self computeCurFilteredIds];
        [self loadMore];
    }
    [self updateFilterDbFromServer];
}

#pragma mark - Interface

//筛选项，classIndex:一级分类（从0开始）
- (NSArray *)filterKeys
{
    if (_classIndex >= kWareTypeCnt || _classIndex < 0) return nil;
//    return _filterKeys[_classIndex];
    return _validFilterKeys;
}

//筛选值，classIndex:一级分类（从0开始）
- (NSArray *)filterValuesForKeyAtIndex:(NSUInteger)keyIndex
{
    if (keyIndex >= [[self filterKeys] count]) return nil;
    NSString *key = [[self filterKeys] objectAtIndex:keyIndex];
//    return [_filterValues[_classIndex] valueForKey:key];
    return [_validFilterValues valueForKey:key];
}

- (BOOL)selectedValueAtIndex:(NSUInteger)valueIndex ForKeyAtIndex:(NSUInteger)keyIndex
{
    if (keyIndex >= _validFilterKeys.count) return NO;
    NSString *key = [_validFilterKeys objectAtIndex:keyIndex];
    if (valueIndex == 0)
        return [_filters valueForKey:key] == nil;
    else
    {
        NSArray *values = [_validFilterValues objectForKey:key];
        valueIndex --;
        if (valueIndex >= values.count) return NO;
        NSString *value = [values objectAtIndex:valueIndex];
        return [[_filters valueForKey:key] isEqualToString:value];
    }
}

//一级分类下全部商品
- (NSArray *)waresForSectionIndex:(NSUInteger)sectionIndex
{
    NSInteger classIndex = [ShopClassModel classIndexForSectionAtIndex:sectionIndex];
    if (classIndex < 0) return nil;
    else return [self waresForClassIndex:classIndex];
}

- (NSArray *)waresForClassIndex:(NSUInteger)classIndex
{
    if (classIndex >= kWareTypeCnt) return nil;
    return _allWares[classIndex];
}

- (NSArray *)waresForCurClass
{
    return [self waresForClassIndex:_classIndex];
}


//设置一级分类
- (void)setSectionIndex:(NSInteger)sectionIndex
{
    _searchOn = NO;
    if (_sectionIndex == sectionIndex) return;
    _sectionIndex = sectionIndex;
    _classIndex = [ShopClassModel classIndexForSectionAtIndex:sectionIndex];
    if (_classIndex < 0)
    {
        _validFilterKeys = nil;
        _validFilterValues = nil;
        return;
    }
    _subClassIndex = -1;
    [_filters removeAllObjects];
    _filteredWares = [[NSMutableArray alloc] initWithArray:_allWares[_classIndex]];
    _curFilteredIds = [[NSMutableArray alloc] initWithArray:_allWareIds[_classIndex]];
    if ([_filteredWares count] == 0) _downloadedIndex = 0;
    else
    {
        _downloadedIndex = 0;
        Ware *lastWare = [_filteredWares lastObject];
        for (id wid in _allWareIds[_classIndex])
            if ([wid integerValue] == lastWare.WID)
            {
                _downloadedIndex = [_allWareIds[_classIndex] indexOfObject:wid];
                break;
            }
    }
    _curFilterStamp = [NSDate date];
    _validFilterKeys = _filterKeys[_classIndex];
    _validFilterValues = _filterValues[_classIndex];
}

//设置筛选
- (void)setFilterValueIndex:(NSUInteger)valueIndex forKeyIndex:(NSUInteger)keyIndex
{
    if (valueIndex == 0) [self setFilterAllForKeyIndex:keyIndex];
    valueIndex --;
    if (keyIndex >= [_validFilterKeys count]) return;
    NSString *key = [_validFilterKeys objectAtIndex:keyIndex];
    if (valueIndex >= [[_validFilterValues valueForKey:key] count]) return;
    NSString *value = [[_validFilterValues valueForKey:key] objectAtIndex:valueIndex];
    [self setFilterValue:value forKey:key];
    [self computeFilteredWares];
    [self computeValidFilters];
}

- (void)setFilterValue:(NSString *)value forKey:(NSString *)key
{
    if (!value)
        [self setFilterAllForKey:key];
    else if (![_filters valueForKey:key])
    {
        [_filters setValue:value forKey:key];
        NSString *filterKey = [NSString stringWithFormat:@"%@-%@", key, value];
        NSArray *filteredId = [_filteredIds[_classIndex] valueForKey:filterKey];
        _curFilteredIds = [self intersectionIds:_curFilteredIds with:filteredId];
    }
    else
    {
        [_filters setValue:value forKey:key];
        [self computeCurFilteredIds];
    }
}

- (void)setFilterAllForKeyIndex:(NSUInteger)keyIndex
{
    if (keyIndex >= [_filterKeys[_classIndex] count]) return;
    NSString *key = [_filterKeys[_classIndex] objectAtIndex:keyIndex];
    [self setFilterAllForKey:key];
    [self computeFilteredWares];
    [self computeValidFilters];
}

- (void)setFilterAllForKey:(NSString *)key
{
    if ([[_filters allKeys] count] == 1)
        _filters = [[NSMutableDictionary alloc] init];
    else [_filters setValue:nil forKey:key];
    [self computeCurFilteredIds];
}

//二级分类
- (NSInteger)subClassCnt
{
    return [ShopClassModel subTypeCntForSectionAtIndex:_sectionIndex];
}

- (NSString *)titleForSubClassAtIndex:(NSInteger)subClassIndex
{
    return [ShopClassModel titleForSectionAtIndex:_sectionIndex andSubType:subClassIndex];
}

- (void)setSubClassIndex:(NSInteger)subClassIndex
{
    if (subClassIndex < 0)
    {
        [self quitSubClass];
        return;
    }    
    _subClassIndex = subClassIndex;
    NSString *key = kSubClassFilterKey;
    NSString *value = [NSString stringWithFormat:@"%d", subClassIndex];
    if ([[_filters valueForKey:key] isEqualToString:value]) return;
    [_filters setValue:value forKey:key];
    [self computeCurFilteredIds];
    [self computeFilteredWares];
    [self computeValidFilters];
}

- (void)quitSubClass
{
    _subClassIndex = -1;
    NSString *key = kSubClassFilterKey;
    if (![_filters valueForKey:key]) return;
    [_filters setValue:nil forKey:key];
    [self computeCurFilteredIds];
    [self computeFilteredWares];
}

- (UIImage *)curClassIcon
{
    return [ShopClassModel iconForSectionAtIndex:_classIndex];
}

- (NSString *)curClassTitle
{
    if (_searchOn)
        return [NSString stringWithFormat:@"搜索 - %@", _searchKey];
    if (_subClassIndex == -1)
        return [ShopClassModel titleForSectionAtIndex:_sectionIndex];
    else
        return [ShopClassModel titleForSectionAtIndex:_sectionIndex andSubType:_subClassIndex];
}

//搜索相关
- (void)setSearchKey:(NSString *)searchKey
{
    _searchKey = searchKey;
    if (!([[_searchKey stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]))
    {
        _searchOn = YES;
        _searchIdsReady = NO;
        [self computeCurFilteredIds];
        [self computeFilteredWares];
        [self loadSearchIds];
    }
}

//加载更多
- (BOOL)loadMore
{
    if (_searchOn && !_searchIdsReady) return YES;
    if (_downloadedIndex >= [_curFilteredIds count]) return NO;
    if (!_searchOn && _classIndex < 0) return NO;
    NSMutableArray *toLoadIds = [[NSMutableArray alloc] init];
    for (NSInteger i = _downloadedIndex; i < _downloadedIndex+kBatchCnt; i++) {
        if (i >= [_curFilteredIds count]) break;
        NSString * wid = [_curFilteredIds objectAtIndex:i];
        if (![self cachedWareForID:wid])
            [toLoadIds addObject:[_curFilteredIds objectAtIndex:i]];
    }
    PumanRequest *request = [[PumanRequest alloc] init];
    request.tag = 1;
    request.urlStr = kUrl_GetWareListWithWID;
    request.delegate = self;
    [request setParam:toLoadIds forKey:@"WIDs" usingFormat:AFDataFormat_Json];
    request.resEncoding = PumanRequestRes_JsonEncoding;
    request.userInfo = [NSDictionary dictionaryWithObject:_curFilterStamp forKey:@"filterStamp"];
    [request postAsynchronous];
    return YES;
}

#pragma mark - 搜索
- (void)loadSearchIds
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.tag = 2;
    request.urlStr = kUrl_SearchWareIds;
    request.delegate = self;
    [request setIntegerParam:_classIndex+1 forKey:@"Type"];
    [request setIntegerParam:_subClassIndex forKey:@"SubType"];
    [request setParam:_searchKey forKey:@"Key"];
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
}

#pragma mark - NetWork

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    if (afRequest.tag == 3)
    {
        //筛选数据库
        if (afRequest.result == PumanRequest_Succeeded)
        {
            NSData *resData = afRequest.httpRequest.responseData;
            if (resData)
            {
                NSError *error;
                NSString *tempPath = [NSString stringWithFormat:@"%@_temp", [self filePathForDownloadedDb]];
                [resData writeToFile:tempPath atomically:YES];
                FMDatabase *db = [FMDatabase databaseWithPath:tempPath];
                if ([db open])
                {
                    NSString *sql = @"SELECT * FROM summary";
                    FMResultSet *rs = [db executeQuery: sql];
                    if (![rs next]) return;
                    [db close];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePathForDownloadedDb]])
                    {
                        [[NSFileManager defaultManager] removeItemAtPath:[self filePathForDownloadedDb] error:&error];
                        if (error)
                        {
                            [ErrorLog errorLog:@"Remove originFilterDb Failed" fromFile:@"ShopModel" error:error];
                        }
                    }
                    [[NSFileManager defaultManager] moveItemAtPath:tempPath toPath:[self filePathForDownloadedDb] error:&error];
                    if (error)
                    {
                        [ErrorLog errorLog:@"Move FilterDb Failed" fromFile:@"ShopModel" error:error];
                    }
                    else
                    {
                        [self setLocalDbTimeStamp];
                        [self readFilterData];
                        [self loadInitWares];
                    }
                }
            }
        }
        return;
    }
    else if (afRequest.tag == 2)
    {
        if ([[afRequest.params valueForKey:@"Key"] isEqualToString:_searchKey] &&
            [[afRequest.params valueForKey:@"Type"] integerValue] == _classIndex+1 &&
            [[afRequest.params valueForKey:@"SubType"] integerValue] == _subClassIndex &&
            _searchOn)
        {
            if ([afRequest.resObj isKindOfClass:[NSArray class]])
            {
                NSArray *res = afRequest.resObj;
                _searchedIds = [[NSMutableArray alloc] initWithCapacity:res.count];
                for (int i=0; i<res.count; i++)
                {
                    [_searchedIds addObject:[[res objectAtIndex:i] objectForKey:@"WID"]];
                }
            }
            [self computeCurFilteredIds];
            [self computeFilteredWares];
            _searchIdsReady = YES;
            [self loadMore];
        }
        return;
    }
    NSArray *wares = [self wareListFromDictionaryList:afRequest.resObj];
    for (Ware *ware in wares)
        [self cacheWare:ware];
    switch (afRequest.tag) {
        case 0:
            //init wares
            [MyUserDefaults setValue:afRequest.resObj forKey:kUDK_InitWares];
            for (NSInteger i=0; i<kWareTypeCnt; i++)
            {
                [_allWares[i] removeAllObjects];
                for (id wid in _allWareIds[i])
                {
                    if ([self cachedWareForID:wid])
                        [_allWares[i] addObject:[self cachedWareForID:wid]];
                    else break;
                }
            }
            PostNotification(Noti_ReloadShopMall, nil);
            break;
            
        case 1:
            if ([[afRequest.userInfo valueForKey:@"filterStamp"] isEqualToDate:_curFilterStamp])
            {
                NSInteger added = 0;
                for (NSInteger i=_downloadedIndex; i<_downloadedIndex+kBatchCnt; i++)
                {
                    if (i >= [_curFilteredIds count]) break;
                    NSString * wid = [_curFilteredIds objectAtIndex:i];
                    if ([self cachedWareForID:wid])
                    {
                        [_filteredWares addObject:[self cachedWareForID:wid]];
                        added ++;
                    }
                }
                _downloadedIndex += added;
                PostNotification(Noti_ReloadShopMall, nil);
            }
            break;
    }
}

- (NSArray *)wareListFromDictionaryList:(NSArray *)list
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for( NSDictionary* item in list )
    {
        Ware* ware = [[Ware alloc] init];
        [ware initWithDictionary:item];
        [array addObject:ware];
    }
    return array;
}


#pragma mark - Compute
//检测筛选值是否有效（添加后是否还包含商品)
- (BOOL)filterValue:(NSString *)value isValidForKey:(NSString *)key
{
    NSString *oValue = [_filters valueForKey:key];
    if ([oValue isEqualToString:value]) return YES;
    [self setFilterValue:value forKey:key];
    BOOL valid = _curFilteredIds.count > 0;
    [self setFilterValue:oValue forKey:key];
    return valid;
}

- (void)computeValidFilters
{
    _validFilterValues = [[NSMutableDictionary alloc] init];
    _validFilterKeys = [[NSMutableArray alloc] init];
    for (NSString *key in _filterKeys[_classIndex])
    {
        NSInteger cnt = 0;
        NSMutableArray *validValues = [[NSMutableArray alloc] init];
        for (NSString *value in [_filterValues[_classIndex] objectForKey:key])
        {
            if ([self filterValue:value isValidForKey:key])
            {
                cnt ++;
                [validValues addObject:value];
            }
        }
        if (cnt > 1 || [_filters valueForKey:key])
        {
            [_validFilterKeys addObject:key];
            [_validFilterValues setObject:validValues forKey:key];
        }
    }
}

//计算筛选出的Ware列表 _filteredWares
- (void)computeFilteredWares
{
    [_filteredWares removeAllObjects];
    for (id Id in _curFilteredIds)
    {
        if ([self cachedWareForID:Id])
            [_filteredWares addObject:[self cachedWareForID:Id]];
        else {
            _downloadedIndex = [_curFilteredIds indexOfObject:Id];
            break;
        }
    }
    _curFilterStamp = [NSDate date];
}

//计算筛选出的WID列表 _curFilteredIds
- (void)computeCurFilteredIds
{
    if (_searchOn)
        _curFilteredIds = _searchedIds;
    else
        _curFilteredIds = _allWareIds[_classIndex];
    for (NSString *key in _filters.keyEnumerator)
    {
        NSString *value = [_filters valueForKey:key];
        NSString *filterKey = [NSString stringWithFormat:@"%@-%@", key, value];
        NSArray *filteredId = [_filteredIds[_classIndex] valueForKey:filterKey];
        _curFilteredIds = [self intersectionIds:_curFilteredIds with:filteredId];
    }
}

- (NSArray *)intersectionIds:(NSArray *)list1 with:(NSArray *)list2
{
    NSInteger l1 = [list1 count], l2 = [list2 count];
    NSInteger p1 = 0, p2 = 0;
    NSMutableArray *intersection = [[NSMutableArray alloc] init];
    while (p1 < l1 && p2 < l2)
    {
        NSInteger wid1 = [[list1 objectAtIndex:p1] integerValue];
        NSInteger wid2 = [[list2 objectAtIndex:p2] integerValue];
        if (wid1 == wid2)
        {
            [intersection addObject:[list1 objectAtIndex:p1]];
            p1++;
            p2++;
        }
        else if (wid1 < wid2)
            p1 ++;
        else p2 ++;
    }
    return intersection;
}

#pragma mark - Cache

- (Ware *)cachedWareForID:(NSString *)wid
{
    return [_wares objectForKey:wid];
}

- (void)cacheWare:(Ware *)ware
{
    NSString *widStr = [NSString stringWithFormat:@"%d", ware.WID];
    [_wares setValue:ware forKey:widStr];
}

#pragma mark - Load Filter Keys and Values

- (void)readFilterData
{
    FMDatabase *db= [FMDatabase databaseWithPath:[self filePathForDb]];
    if (![db open]) {
        [ErrorLog errorLog:@"Could not open db." fromFile:@"ShopModel.m" error:nil];
        NSLog(@"Could not open db. ShopModel");
    }
    //获取筛选项-键
    NSString *sql = @"SELECT * FROM summary";
    FMResultSet *rs = [db executeQuery: sql];
    NSMutableArray *fieldName[kWareTypeCnt], *prefix[kWareTypeCnt], *keyId[kWareTypeCnt];
    for (int i=0; i<kWareTypeCnt; i++)
    {
        fieldName[i] = [[NSMutableArray alloc] init];
        prefix[i] = [[NSMutableArray alloc] init];
        keyId[i] = [[NSMutableArray alloc] init];
    }
    while ([rs next])
    {
        NSInteger type = [rs intForColumn:@"WType"]-1;
        if (type >= kWareTypeCnt || type < 0) continue;
        NSString *keyName = [rs stringForColumn:@"FieldName"];
        [fieldName[type] addObject:keyName];
        [prefix[type] addObject:[rs stringForColumn:@"Prefix"]];
        [keyId[type] addObject:[rs stringForColumn:@"KeyID"]];
    }
    //获取筛选项-取值
    for (int type=0; type<kWareTypeCnt; type++)
    {
        for (int i=0; i<[fieldName[type] count]; i++)
        {
            NSString *key = [fieldName[type] objectAtIndex:i];
            NSString *pref = [prefix[type] objectAtIndex:i];
            NSString *kID = [keyId[type] objectAtIndex:i];
            NSString *tableName = [NSString stringWithFormat:@"%@level", pref];
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE KeyID = %@ ORDER BY Priority", tableName, kID];
            FMResultSet *rs = [db executeQuery: sql];
            NSMutableArray *values = [[NSMutableArray alloc] init];
            while ([rs next]) {
                NSString *value = [rs stringForColumn:@"KeyName"];
                [values addObject:value];
                NSString *priority = [rs stringForColumn:@"Priority"];
                //获取wids
                NSString *tableName_wid = [NSString stringWithFormat:@"%@wid", pref];
                NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE KeyID = %@ AND Priority = %@ ORDER BY WPriority", tableName_wid, kID, priority];
                FMResultSet *rs2 = [db executeQuery: sql];
                NSMutableArray *wids = [[NSMutableArray alloc] init];
                while ([rs2 next]) {
                    [wids addObject:[rs2 stringForColumn:@"WID"]];
                }
                NSString *identity = [self IdentityForFilterKey:key andValue:value];
                [_filteredIds[type] setValue:wids forKey:identity];
            }
            [_filterValues[type] setValue:values forKey:key];
            if (![key isEqualToString:kSubClassFilterKey] && ![key isEqualToString:kAllFilterKey])
                [_filterKeys[type] addObject:key];
        }
        _allWareIds[type] = [_filteredIds[type] valueForKey:[self IdentityForFilterKey:kAllFilterKey andValue:kAllFilterKey]];
    }
    [db close];
}

- (NSString *)filePathForDb
{
    NSString *downloadedPath = [self filePathForDownloadedDb];
    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadedPath])
        return downloadedPath;
    return [[NSBundle mainBundle] pathForResource:@"filter-2" ofType:@"sqlite"];
}

- (NSString *)filePathForDownloadedDb
{
    NSString *fileDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [fileDir stringByAppendingPathComponent:@"FilterDb.sqlite"];
    return filePath;
}

- (void)updateFilterDbFromServer
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.tag = 3;
    request.urlStr = kUrl_GetWareFilterDb;
    request.delegate = self;
    [request setParam:[self localDbTimeStamp] forKey:@"LocalTimeStamp"];
//    request.resEncoding = PumanRequestRes_XmlEncoding;
    request.feedBackIdentity = NO;
    [request postAsynchronous];
}

- (NSString *)localDbTimeStamp
{
    return [MyUserDefaults valueForKey:kUDK_FilterDbLocalVersion];
}

- (void)setLocalDbTimeStamp
{
    NSString *stamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    [MyUserDefaults setValue:stamp forKey:kUDK_FilterDbLocalVersion];
}

#pragma mark - other

- (NSString *)IdentityForFilterKey:(NSString *)key andValue:(NSString *)value
{
    return [NSString stringWithFormat:@"%@-%@", key, value];
}

//载入商城首页的商品（每一个分类各6个）
- (void)loadInitWares
{
    NSArray *wares = [self wareListFromDictionaryList:[MyUserDefaults valueForKey:kUDK_InitWares]];
    for (Ware *ware in wares) [self cacheWare:ware];
    for (NSInteger i=0; i<kWareTypeCnt; i++)
    {
        [_allWares[i] removeAllObjects];
        for (id wid in _allWareIds[i])
        {
            if ([self cachedWareForID:wid])
                [_allWares[i] addObject:[self cachedWareForID:wid]];
            else break;
        }
    }
    NSMutableArray *toLoadIds = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<kWareTypeCnt; i++)
    {
        for (NSInteger j=0; j<6; j++)
        {
            if (j >= [_allWareIds[i] count]) break;
            [toLoadIds addObject:[_allWareIds[i] objectAtIndex:j]];
        }
    }
    PumanRequest *request = [[PumanRequest alloc] init];
    request.tag = 0;
    request.urlStr = kUrl_GetWareListWithWID;
    request.delegate = self;
    [request setParam:toLoadIds forKey:@"WIDs" usingFormat:AFDataFormat_Json];
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
}

@end
