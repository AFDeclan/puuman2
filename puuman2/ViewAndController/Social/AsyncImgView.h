//
//  AsyncImgView.h
//  puuman2
//
//  Created by Declan on 14-4-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"

@interface AsyncImgView : AFImageView
{
    NSString *_url;
}

@property (nonatomic, assign) CGSize cropSize;

- (void)loadImgWithUrl:(NSString *)imgUrl;


@end
