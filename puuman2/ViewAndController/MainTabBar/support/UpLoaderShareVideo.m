//
//  UpLoaderShareVideo.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "UpLoaderShareVideo.h"
#import "UniverseConstant.h"
#import "DiaryFileManager.h"
#import "Diary.h"

@implementation UpLoaderShareVideo

static NSMutableArray *instanceList;


- (void)retainSelf
{
    if (!instanceList)
        instanceList = [[NSMutableArray alloc] init];
    [instanceList addObject:self];
}

- (void)releaseSelf
{
    [instanceList removeObject:self];
}
- (void)downloadDataFromUrl:(NSString *)url
{
    if (url) {
        [self retainSelf];
        _request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
        [_request setDownloadProgressDelegate:self];
        //[_request setUploadProgressDelegate:self];
        [_request setRequestMethod:@"GET"];
        [_request setDelegate:self];
        [_request startAsynchronous];
    }
  
}

- (void)setProgress:(float)newProgress
{
    PostNotification(Noti_RefreshProgressAutoVideo, [NSNumber numberWithDouble:newProgress]);
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (_request == request) {
        NSString *fileDir = [DiaryFileManager fileDirForDiaryType:DiaryTypeStrVideo];
        NSString *fileName =  @"sharevideo";
        fileName = [fileName stringByAppendingPathExtension:@"MOV"];
        NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
        NSData *data = [request responseData];
        
        if ([data writeToFile:filePath atomically:YES]) {
            PostNotification(Noti_FinishShareVideo, filePath);
        }else{
            NSLog(@"save file fail");
        }
        
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (_request == request) {
        PostNotification(Noti_FailShareVideo, nil);
        [self releaseSelf];
    }
    

}

- (void)dealloc
{
    [_request setDelegate:nil];
    [_request cancel];
}


@end
