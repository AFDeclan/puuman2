//
//  DiaryModel.h
//  try
//
//  Created by 陈晔 on 13-3-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#define DBNAME @"userdiaryinfo.sqlite"
#import <sqlite3.h>
#import <Foundation/Foundation.h>
#import "PumanRequest.h"

//#define DIARY_FILTER_ALL            0
//#define DIARY_FILTER_TEXT           2
//#define DIARY_FILTER_PHOTO          1
//#define DIARY_FILTER_AUDIO          3
//#define DIARY_FILTER_VIDEO          4

#define DIARY_FILTER_ALL        0
//(不包含被删除的)
#define DIARY_FILTER_DELETED    1

#define kDateName       @"date"
#define kTypeName       @"type"
#define kType2Name      @"type2"
#define kTitleName      @"title"
#define kFilePathName   @"filePath"
#define kFilePath2Name  @"filePath2"
#define kDiaryUIdentity @"DiaryUIdentity"
#define kSampleDiary    @"sampleDiary"
#define kDeletedDiary   @"deletedDiary"
#define kTaskDiary      @"taskDiary"
#define vType_Text      @"text"
#define vType_Photo     @"photo"
#define vType_Audio     @"audio"
#define vType_Video     @"video"

#define kUserDefault_DiaryUpdateID  @"DiaryUpdateID"

@class UserInfo;
@class FMDatabase;

@interface DiaryModel : NSObject <AFRequestDelegate>
{
    FMDatabase *db;
    NSMutableArray *diaryInfoArray;
    NSMutableArray *downloadedDiaryInfo;
    BOOL _sampleDiary;
    NSMutableArray *updateDiaryInfo;
}

//待更新日记数量
@property (assign, readonly) NSInteger updateCnt;
@property (assign, readonly) NSInteger downloadedCnt;

+ (DiaryModel *)sharedDiaryModel;

- (void)reloadData;
- (void)updateDiaryFromServer;

//filter类别日记的总数
- (NSUInteger) diaryNumFiltered:(NSUInteger) filter;

//filter类别中编号index的日记信息
- (NSDictionary*) diaryInfoAtIndex:(NSUInteger)index filtered:(NSUInteger)filter;

//新增日记，更新数据库以及model的数组
- (BOOL) addNewDiary:(NSDictionary *)diaryInfo;
//删除日记
- (BOOL) deleteDiary:(NSDictionary *)diaryInfo;

//获取某日期之前最近的日记
- (NSUInteger)indexForDiaryNearDate:(NSDate *)date filtered:(NSUInteger)filter;

//关键字搜索
- (NSUInteger)indexForDiarySearchedWithKeyword:(NSString *)keyword filtered:(NSUInteger) filter;

- (NSInteger)indexForDiaryInDay:(NSDate *)date;

- (NSArray *)diariesInDay:(NSDate *)date;

- (NSUInteger) diaryNotSampleNum;

//日历展示缩略图
- (UIImageView *)thumbnailForCalendar:(NSDate *)date;
- (NSArray *)diaryInfoRelateArraywithFilter:(NSUInteger) filter;
//日记更新数据置零
- (void)resetUpdateDiaryCnt;
@end
