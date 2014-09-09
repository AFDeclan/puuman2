//
//  ReplyForUpload.m
//  puuman model
//
//  Created by Declan on 14-3-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "UniverseConstant.h"

#import "UserInfo.h"
#import "ReplyForUpload.h"
#import "PumanRequest.h"
#import "FileUploader.h"
#import "DateFormatter.h"
#import "Forum.h"

@implementation ReplyForUpload

- (void)upload
{
    NSAssert(self.TID > 0, @"TID未设置！");
    NSAssert(self.RTitle, @"RTitle未设置！");
    NSAssert(self.texts || self.photos, @"内容未设置！");
    if (!_uploading) [NSThread detachNewThreadSelector:@selector(uploadThread) toTarget:self withObject:nil];
}

- (void)uploadThread
{
    _uploading = YES;
    FileUploader *uploader = [[FileUploader alloc] init];
    NSString *dir = [NSString stringWithFormat:@"Forum/TopicReply/%ld", (long)self.TID];
    NSString *namePrefix = [DateFormatter stringFromDatetime:[NSDate date]];
    NSInteger index = 0;
    NSMutableArray * textUrls = [[NSMutableArray alloc] init];
    NSMutableArray * photoUrls = [[NSMutableArray alloc] init];
    for (NSString *text in self.texts) {
//        NSString * name = [NSString stringWithFormat:@"%@_%d.txt", namePrefix, index++];
//        BOOL upRet = [uploader uploadDataSync:[text dataUsingEncoding:NSUTF8StringEncoding] toDir:dir fileName:name];
//        if (upRet) {
//            [textUrls addObject:uploader.targetUrl];
//        } else {
//            [self fail];
//            return;
//        }
        [textUrls addObject:text];
    }
    index = 0;
    for (UIImage *photo in self.photos) {
        NSString * name = [NSString stringWithFormat:@"%@_%ld.jpg", namePrefix, (long)index++];
        BOOL upRet = [uploader uploadDataSync:UIImageJPEGRepresentation(photo, 0.8) toDir:dir fileName:name];
        if (upRet) {
            [photoUrls addObject:uploader.targetUrl];
        } else {
            [self fail];
            return;
        }
    }
    PumanRequest *req = [[PumanRequest alloc] init];
    req.urlStr = kUrl_UploadTopicReply;
    [req setIntegerParam:[UserInfo sharedUserInfo].UID forKey:@"UID"];
    [req setIntegerParam:self.TID forKey:@"TID"];
    [req setParam:self.RTitle forKey:@"RTitle"];
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:textUrls forKey:Reply_Content_Text];
    [content setValue:photoUrls forKey:Reply_Content_Photo];
    [req setParam:content forKey:@"RContent" usingFormat:AFDataFormat_Json];
    [req postSynchronous];
    if (req.result != PumanRequest_Succeeded) {
        [self fail];
    } else {
        [self suc];
    }
}

- (void)fail
{
    _uploading = NO;
    [[Forum sharedInstance] performSelectorOnMainThread:@selector(replyUploadFailed:) withObject:self waitUntilDone:NO];
}

- (void)suc
{
    _uploading = NO;
    [[Forum sharedInstance] performSelectorOnMainThread:@selector(replyUploaded:) withObject:self waitUntilDone:NO];
}

@end
