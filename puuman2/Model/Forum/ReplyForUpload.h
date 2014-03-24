//
//  ReplyForUpload.h
//  puuman2
//
//  Created by Declan on 14-3-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyForUpload : NSObject
{
    BOOL _uploading;
}

@property (assign, nonatomic) NSInteger TID;
@property (retain, nonatomic) NSString * RTitle;
@property (retain, nonatomic) NSArray * texts;
@property (retain, nonatomic) NSArray * photos;

- (void)upload;

@end
