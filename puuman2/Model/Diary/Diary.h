//
//  Diary.h
//  puuman model
//
//  Created by Declan on 14-5-6.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "FileUploader.h"

#define DiaryTypeStrNone      @""
#define DiaryTypeStrText      @"text"
#define DiaryTypeStrPhoto     @"photo"
#define DiaryTypeStrAudio     @"audio"
#define DiaryTypeStrVideo     @"video"
#define DiaryTypeStrPhoto_More  @"photo_more"
#define DiaryTypeStrPhoto_Single @"photo_single"

#define DiaryMetaKeyWhetherBabyData     @"IsBabyData"       //是否是身高体重生成的日记
#define DiaryMetaKeyTaskId              @"TaskId"
#define DiaryMetaKeyRewarded            @"Rewarded"         //是否已打赏

typedef enum DiaryContentTypes {
    DiaryContentTypeNone,
    DiaryContentTypeText,
    DiaryContentTypePhoto,
    DiaryContentTypeAudio,
    DiaryContentTypeVideo
} DiaryContentTypes;

typedef void (^DiaryRecallBlock)(BOOL);

@interface Diary : NSObject <UploaderDelegate>
{
    NSMutableDictionary * _blocks;
}

@property (nonatomic, retain) NSDate * DCreateTime;
@property (nonatomic, assign) NSInteger UTID;
@property (nonatomic, assign) NSInteger UID;
@property (nonatomic, assign) UserIdentity UIdentity;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, assign) DiaryContentTypes type1;
@property (nonatomic, assign) DiaryContentTypes type2;
@property (nonatomic, retain) NSString * type1Str;
@property (nonatomic, retain) NSString * type2Str;
@property (nonatomic, retain) NSArray * filePaths1;
@property (nonatomic, retain) NSArray * filePaths2;
@property (nonatomic, retain) NSArray * urls1;
@property (nonatomic, retain) NSArray * urls2;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, assign) NSInteger uploaded;   //0未上传，1已上传，2信息待更新
@property (nonatomic, assign) BOOL sampleDiary;
@property (nonatomic, retain) NSMutableDictionary * meta;

//metas
- (BOOL)createdByBabyData;                  //是否身高体重相关
- (void)setCreatedByBabyData:(BOOL)whether; //设置是否身高体重相关
- (NSInteger)taskId;                        //相关联任务id
- (void)setTaskId:(NSInteger)tid;           //设置相关联任务id
- (BOOL)rewarded;                           //是否已打赏
- (BOOL)reward:(CGFloat)cnt;                             //打赏
- (void)setRewarded;

- (void)setUrls1WithMainUrl:(NSString *)url andSubcnt:(NSInteger)cnt;
- (void)setUrls2WithMainUrl:(NSString *)url andSubcnt:(NSInteger)cnt;
//下载日记内容（同步方法，需再后台线程调用）
- (void)download;
//重新下载某一日记内容，异步方法
- (void)redownloadContent1AtIndex:(NSInteger)index withRecall:(DiaryRecallBlock)block;
- (void)redownloadContent2AtIndex:(NSInteger)index withRecall:(DiaryRecallBlock)block;
//上传，同步方法
- (BOOL)uploadDiary;        //上传文件和信息
- (BOOL)uploadDiaryInfo;    //更新信息


@end
