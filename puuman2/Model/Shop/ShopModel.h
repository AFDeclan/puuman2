//
//  ShopModel.h
//  puman
//
//  Created by Declan on 13-12-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "UniverseConstant.h"
#import "PumanRequest.h"
#import "ShopClassModel.h"
#import <Foundation/Foundation.h>

#define kSubClassFilterKey      @"二级分类"
#define kAllFilterKey           @"全部"
@interface ShopModel : ShopClassModel <AFRequestDelegate>
{
    //按wid缓存的商品
    NSMutableDictionary *_wares;
    //一级分类下所有商品ID
    NSArray *_allWareIds[kWareTypeCnt];
    //一级分类下的筛选项，二级分类为特殊筛选项，名称为宏定义：kSubClassFilterKey，不包含在该数组中。
    NSMutableArray *_filterKeys[kWareTypeCnt];
    //一级分类下某筛选项对应的筛选值，（以筛选项为key，value为筛选值数组）
    NSMutableDictionary *_filterValues[kWareTypeCnt];
    //一级分类下某筛选项-筛选值对所对应的商品ID，（key:'筛选项-筛选值' value:ID数组）
    NSMutableDictionary *_filteredIds[kWareTypeCnt];
    //一级分类商品
    NSMutableArray *_allWares[kWareTypeCnt];
    //由目前筛选条件_filters计算出的ID列表
    NSArray *_curFilteredIds;
    //_curFilteredIds中<downloadedIndex部分已下载
    NSUInteger _downloadedIndex;
    //生成目前筛选器的时间戳，用于校验异步返回的请求
    NSDate *_curFilterStamp;
    NSMutableArray *_searchedIds;
    BOOL _searchIdsReady;
    
    NSMutableDictionary *_validFilterValues;
    NSMutableArray *_validFilterKeys;
}

@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, assign, readonly) NSInteger classIndex;
@property (nonatomic, assign) NSInteger subClassIndex;
//key:筛选项， value:筛选值
@property (nonatomic, retain, readonly) NSMutableDictionary *filters;
@property (nonatomic, retain, readonly) NSMutableArray *filteredWares;

@property (nonatomic, assign, readonly) BOOL searchOn;
@property (nonatomic, retain) NSString *searchKey;

+ (ShopModel *)sharedInstance;

//筛选项，classIndex:一级分类（从0开始）
- (NSArray *)filterKeys;
//筛选值，classIndex:一级分类（从0开始），keyIndex:筛选项在filterKeys中的Index
- (NSArray *)filterValuesForKeyAtIndex:(NSUInteger)keyIndex;
//是否是已设置的筛选项
- (BOOL)selectedValueAtIndex:(NSUInteger)valueIndex ForKeyAtIndex:(NSUInteger)keyIndex;
//一级分类下全部商品
- (NSArray *)waresForSectionIndex:(NSUInteger)sectionIndex;
- (NSArray *)waresForCurClass;

//设置筛选 0为全部
- (void)setFilterValueIndex:(NSUInteger)valueIndex forKeyIndex:(NSUInteger)keyIndex;
//一级分类
- (UIImage *)curClassIcon;
- (NSString *)curClassTitle;
//二级分类
- (NSInteger)subClassCnt;
- (NSString *)titleForSubClassAtIndex:(NSInteger)subClassIndex;
- (void)setSubClassIndex:(NSInteger)subClassIndex;
- (void)quitSubClass;
//加载更多
- (BOOL)loadMore;
@end
