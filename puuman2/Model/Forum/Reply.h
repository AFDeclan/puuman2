//
//  Reply.h
//  puuman2
//
//  Created by Declan on 14-3-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reply : NSObject
{
    
}

@property (assign, nonatomic, readonly) NSInteger TID;
@property (assign, nonatomic, readonly) NSInteger UID;
@property (retain, nonatomic, readonly) NSString * RTitle;
@property (retain, nonatomic, readonly) NSDate * RCreateTime;

@property (retain, nonatomic, readonly) NSArray * textUrls;
@property (retain, nonatomic, readonly) NSArray * photoUrls;

@property (retain, nonatomic) NSDictionary *data;

@end
