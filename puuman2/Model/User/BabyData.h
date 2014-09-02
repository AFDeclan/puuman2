//
//  BabyData.h
//  puman
//
//  Created by 陈晔 on 13-10-18.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <ASIFormDataRequest.h>
#import "PumanRequest.h"

#define kBabyDataDbName     @"BabyData.sqlite"

#define kBabyData_ID        @"BabyData_ID"
#define kBabyData_Date      @"BabyData_Date"
#define kBabyData_Height    @"BabyData_Height"
#define kBabyData_Weight    @"BabyData_Weight"
#define kBabyData_Uploaded  @"BabyData_Uploaded"

#define kVaccine_ID         @"Vaccine_ID"
#define kVaccine_Name       @"Vaccine_Name"
#define KVaccine_Info       @"Vaccine_Info"
#define kVaccine_SuitMonth  @"Vaccine_SuitMonth"
#define kVaccine_DoneTime   @"Vaccine_DoneTime"
#define kVaccine_Uploaded   @"Vaccine_Uploaded"
#define kVaccine_Order      @"Vaccine_Order"

@interface BabyData : NSObject <AFRequestDelegate>
{
    FMDatabase *_db;
    NSMutableArray *_data;
    NSMutableArray *_vaccine;
    
    BOOL _vaccineUpdating;
}

+ (BabyData *)sharedBabyData;

@property (retain, nonatomic, readonly) NSArray * heightArray;
@property (retain, nonatomic, readonly) NSArray * weightArray;
@property (assign, nonatomic, readonly) float highestHeightRecord;
@property (assign, nonatomic, readonly) float lowestHeightRecord;
@property (assign, nonatomic, readonly) float highestWeightRecord;
@property (assign, nonatomic, readonly) float lowestWeightRecord;

//operations
- (void)reloadData;
- (void)updateData;
- (void)insertRecordAtDate:(NSDate *)date height:(CGFloat)h weight:(CGFloat)w;

- (void)updateVaccineAtIndex:(NSInteger)index withDoneTime:(NSDate *)date;
/*date 传入nil表示取消， 传入正常值表示该疫苗接种时间*/

//data read
- (NSUInteger)recordCount;  //记录总数
- (NSDictionary *)recordAtIndex:(NSUInteger)index; //获取指定记录
- (float)selectHeightWithDate:(NSDate *)date;
- (float)selectWeightWithDate:(NSDate *)date;

- (NSInteger)heightIndexWithIndex:(NSInteger)index;
- (NSInteger)weightIndexWithIndex:(NSInteger)index;

    /*字典结构：
     key:               value:
     kBabyData_ID       (NSInteger)对应数据库中的ID
     kBabyData_Date     (NSDate)记录的日期
     kBabyData_Height   (CGFloat)身高
     kBabyData_Weight   (CGFLoat)体重
     */

- (NSUInteger)vaccineCount;
- (NSDictionary *)vaccineAtIndex:(NSUInteger)index;

- (NSInteger)startAtIndex;
@end
