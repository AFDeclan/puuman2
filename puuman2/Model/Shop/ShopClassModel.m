//
//  ShopClassModel.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-21.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ShopClassModel.h"
#import "UserInfo.h"

static NSString *iconImageName[15] = {@"icon_milk_shop.png", @"icon_food_shop.png", @"icon_diaper_shop.png", @"icon_bottle_shop.png", @"icon_wash_shop.png", @"icon_bed_shop.png", @"icon_clothes_shop.png", @"icon_toy_shop.png", @"icon_mom_shop.png",@"",@"icon_father_shop.png", @"icon_health_shop.png",@"icon_abroad_shop.png", @"icon_hospital_shop.png"};

static NSString *iconImageName2[15] = {@"icon2_milk_shop.png", @"icon2_food_shop.png", @"icon2_diaper_shop.png", @"icon2_bottle_shop.png", @"icon2_wash_shop.png", @"icon2_bed_shop.png", @"icon2_clothes_shop.png", @"icon2_toy_shop.png", @"icon2_mom_shop.png",@"",@"icon2_father_shop.png", @"icon2_health_shop.png",@"icon2_abroad_shop.png", @"icon2_hospital_shop.png"};

static NSString *subTypeName[15][11] = {{@"一段奶粉", @"二段奶粉", @"三段奶粉", @"四段奶粉", @"特殊配方", @"羊奶粉", @"成人奶粉", @"初乳"},
    {@"汁&泥", @"肉松饼干", @"米粉米糊", @"面条稀饭", @"油盐酱醋"},
    {@"新生儿", @"小码尿片", @"中码尿片", @"大码尿片", @"加大尿片", @"成长尿裤", @"纸巾湿巾"},
    {@"奶瓶", @"奶嘴", @"吸奶器", @"温奶", @"卫生消毒", @"餐具", @"牙胶安抚", @"水杯水壶", @"辅助用品"},
    {@"洗发沐浴", @"护肤保湿", @"浴室用品", @"浴巾毛巾", @"清洁用品", @"护理用品", @"口水巾"},
    {@"婴儿床", @"手推车", @"三轮车", @"学步车", @"脚踏车", @"电动车", @"健身车", @"安全座椅", @"餐椅摇椅"},
    {@"上衣/肚兜", @"裤子", @"套装", @"鞋帽袜", @"连身衣", @"睡袋抱被", @"睡枕抱枕", @"床单被褥", @"凉席蚊帐", @"安全用品"},
    {@"益智玩具", @"毛绒布艺", @"模型玩具", @"积木拼插", @"遥控/电动", @"娃娃玩具", @"动漫玩具", @"健身玩具", @"DIY玩具"},
    {@"背婴带", @"胎教产品", @"妈妈护理", @"产后塑身", @"孕妇装", @"孕妇内衣", @"防辐射服", @"孕妇食品", @"妈妈美容"},
    {@""},
    {@"男士洁面",@"面部护理",@"剃须护理",@"箱包皮具",@"时尚休闲",@"绅士西装",@"酒水饮料",@"智能设备",@"虚拟充值",@"男士其他",@"送给老婆"},
    {@"营养摄取",@"清火开胃",@"常用医药"}
};

static NSString *TitleNameForType[15] = {@"奶粉", @"营养辅食", @"尿裤纸巾", @"喂养", @"洗护", @"童车童床", @"家私服饰", @"益智玩具", @"妈妈专区", @"", @"爸爸专区", @"营养健康", @"海淘一族", @"医疗保障", };
static int motherFlag[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8,  11, 12, 13};
static int fatherFlag[12] = {0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13};
static int subTypeCnt[14] = {8, 5, 7, 9, 7, 9, 10, 9, 9, 0, 11, 3, 0, 0};

@implementation ShopClassModel

//分类总数
+ (NSInteger)sectionCnt
{
    return 12;
}

//第index类的图标
+ (UIImage *)iconForSectionAtIndex:(NSInteger)index
{
    if (index >= [self sectionCnt]) return nil;
    NSString *iconName = iconImageName[[self classIndexForSectionAtIndex:index]];
    return [UIImage imageNamed:iconName];
}

+ (UIImage *)icon2ForSectionAtIndex:(NSInteger)index
{
    if (index >= [self sectionCnt]) return nil;
    NSString *iconName = iconImageName2[[self classIndexForSectionAtIndex:index]];
    return [UIImage imageNamed:iconName];
}

//第index类的标题
+ (NSString *)titleForSectionAtIndex:(NSInteger)index
{
    if (index >= [self sectionCnt]) return nil;
    return TitleNameForType[[self classIndexForSectionAtIndex:index]];
}

//第index类的子类数量
+ (NSInteger)subTypeCntForSectionAtIndex:(NSInteger)index
{
    if (index >= [self sectionCnt]) return 0;
    NSInteger SectionIndex = [self classIndexForSectionAtIndex:index];
    return subTypeCnt[SectionIndex];
}
    
//第index类第dubIndex子类的标题
+ (NSString *)titleForSectionAtIndex:(NSInteger)index andSubType:(NSInteger)subIndex
{
    if (subIndex >= [self subTypeCntForSectionAtIndex:index]) return nil;
    NSInteger SectionIndex = [self classIndexForSectionAtIndex:index];
    return subTypeName[SectionIndex][subIndex];
}

//第index类的index (不同身份不一样)
+ (NSInteger)classIndexForSectionAtIndex:(NSInteger)index
{
    if (index >= [self sectionCnt] || index < 0) return -1;
    int *flag = ([UserInfo sharedUserInfo].identity == Father) ? fatherFlag : motherFlag;
    return flag[index];
}

@end

