//
//  UpLoaderShareVideo.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "UpLoaderShareVideo.h"
#import "UniverseConstant.h"

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
    
    NSString *fileDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    fileDir = [fileDir stringByAppendingPathComponent:@"Baby4/video"];
    NSString *fileName =  @"sharevideo";
    fileName = [fileName stringByAppendingPathExtension:@"MOV"];
    NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
    NSData *data = [request responseData];
    if ([data writeToFile:filePath atomically:YES]) {
        PostNotification(Noti_FinishShareVideo, filePath);

    }else{
        NSLog(@"Save ShareVideo failed!");

    }
    [self releaseSelf];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    PostNotification(Noti_FailShareVideo, nil);
    [self releaseSelf];

}

- (void)dealloc
{
    [_request setDelegate:nil];
    [_request cancel];
}


@end