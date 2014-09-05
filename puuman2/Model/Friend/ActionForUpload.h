//
//  ActionForUpload.h
//  puuman model
//
//  Created by Declan on 14-3-29.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"
#import "PumanRequest.h"

@class Group;

@interface ActionForUpload : Action <AFRequestDelegate>
{
    PumanRequest *_req;
}

@property (assign, nonatomic) Group * group;

- (void)upload;

@end
