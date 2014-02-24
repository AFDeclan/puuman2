//
//  ShopClassModel.h
//  PuumanForPhone
//
//  Created by Declan on 14-1-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopClassModel : NSObject

//分类总数
+ (NSInteger)sectionCnt;

//第index类的图标
+ (UIImage *)iconForSectionAtIndex:(NSInteger)index;
+ (UIImage *)icon2ForSectionAtIndex:(NSInteger)index;

//第index类的标题
+ (NSString *)titleForSectionAtIndex:(NSInteger)index;

//第index类的子类数量
+ (NSInteger)subTypeCntForSectionAtIndex:(NSInteger)index;

//第index类第dubIndex子类的标题
+ (NSString *)titleForSectionAtIndex:(NSInteger)index andSubType:(NSInteger)subIndex;

//第index类的index (不同身份不一样)
+ (NSInteger)classIndexForSectionAtIndex:(NSInteger)index;

@end
