//
//  DiaryModel.h
//  try
//
//  Created by 陈晔 on 13-3-30.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#define DBNAME @"userdiaryinfo.sqlite"
#import <Foundation/Foundation.h>
#import "PumanRequest.h"

#define DIARY_FILTER_ALL        0
//(不包含被删除的)
#define DIARY_FILTER_DELETED    1

#define kUserDefault_DiaryUpdateID  @"DiaryUpdateID"

@class UserInfo;
@class FMDatabase;
@class Diary;

@interface DiaryModel : NSObject <AFRequestDelegate>
{
    FMDatabase *db;
    BOOL _sampleDiary, _uploading;
    NSMutableArray *_toDownloadDiaries;
    NSMutableArray *_downloadedDiaries;
    NSMutableArray *_toUploadDiaries;
}

//待更新日记数量
@property (assign, readonly) NSInteger updateCnt;
@property (assign, readonly) NSInteger downloadedCnt;

@property (retain, readonly) NSMutableArray * diaries;
@property (retain, readonly) NSMutableArray * deletedDiaries;

+ (DiaryModel *)sharedDiaryModel;

- (void)reloadData;
- (void)updateDiaryFromServer;

//新增日记，更新数据库以及model的数组
- (BOOL)addNewDiary:(Diary *)d;
//删除日记
- (BOOL)deleteDiary:(Diary *)d;

//关键字搜索
- (NSUInteger)indexForDiarySearchedWithKeyword:(NSString *)keyword;

- (NSInteger)indexForDiaryInDay:(NSDate *)date;

- (NSArray *)diariesInDay:(NSDate *)date;

- (NSUInteger)diaryNotSampleNum;

//日历展示缩略图
- (NSArray *)diaryInfoRelateArray;

//日记更新数据置零
- (void)resetUpdateDiaryCnt;

@end
