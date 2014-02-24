//
//  FileManager.h
//  puman
//
//  Created by 陈晔 on 13-11-9.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryFileManager : NSObject

+ (NSString *)fileDirForDiaryType:(NSString *)type;

+ (UIImage *)imageForVideo:(NSString *)filePath;

+ (UIImage *)thumbImageForPath:(NSString *)filePath;

+ (NSString *)thumbImagePathForPath:(NSString *)filePath;

+ (UIImage *)imageForPath:(NSString *)filePath;

//修复由于证书变动导致的应用沙盒目录变动问题
+ (NSString *)fixedFilePath:(NSString *)filePath;

//保存不同类型的日记，若成功返回diaryInfo，否则返回nil
+ (NSDictionary *)saveText:(NSString *)text withPhoto:(UIImage *)photo withTitle:(NSString *)title  andTaskInfo:(NSDictionary *)taskInfo;
+ (NSDictionary *)savePhotos:(NSArray *)photos withAudio:(NSURL *)audioUrl withTitle:(NSString *)title  andTaskInfo:(NSDictionary *)taskInfo;

//保存已经暂存的图片
+ (NSDictionary *)savePhotoWithPaths:(NSArray *)photoPaths withAudio:(NSURL *)audioUrl withTitle:(NSString *)title andTaskInfo:(NSDictionary *)taskInfo;

+ (NSDictionary *)saveVideo:(NSURL *)tempUrl withTitle:(NSString *) title  andTaskInfo:(NSDictionary *)taskInfo;
+ (NSDictionary *)saveAudio:(NSURL *)audioUrl withTitle:(NSString *)title  andTaskInfo:(NSDictionary *)taskInfo;

//暂存图片，返回文件路径
+ (NSString *)saveTmpPhoto:(UIImage *)photo;

@end
