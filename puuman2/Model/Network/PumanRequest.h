//
//  PumanRequest.h
//  puman
//
//  Created by Declan on 13-12-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetwork.h"

enum PumanRequestResult {
    PumanRequest_Succeeded = -1,
    PumanRequest_OtherError = 0,
    PumanRequest_TimeOut = 1
    };

typedef enum{
    PumanRequestRes_NoneEncoding,
    PumanRequestRes_JsonEncoding,
    PumanRequestRes_XmlEncoding
}PumanRequestResEncoding;

@interface PumanRequest : AFBaseRequest

@property (assign, nonatomic) PumanRequestResEncoding resEncoding;
@property (assign, nonatomic) BOOL feedBackIdentity;



@end
