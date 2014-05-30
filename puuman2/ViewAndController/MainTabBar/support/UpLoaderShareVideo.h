//
//  UpLoaderShareVideo.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ASIHTTPRequest.h>

@interface UpLoaderShareVideo : NSObject<ASIHTTPRequestDelegate>
{
     ASIHTTPRequest *_request;
}

- (void)downloadDataFromUrl:(NSString *)url;

@end
