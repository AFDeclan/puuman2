//
//  AsyncImgView.m
//  puuman2
//
//  Created by Declan on 14-4-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AsyncImgView.h"
#import "UIImage+CroppedImage.h"
#import "UIImageView+AnimateFade.h"

static NSOperationQueue * operationQueue;

@implementation AsyncImgView

- (NSOperationQueue *)sharedQueue
{
    if (!operationQueue) {
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setMaxConcurrentOperationCount:1];
    }
    return operationQueue;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cropSize = CGSizeZero;
    }
    return self;
}

- (void)loadImgWithUrl:(NSString *)imgUrl
{
    if ([imgUrl isEqualToString:_url]) return;
    _url = imgUrl;
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(loadImgThread)
                                                                             object:nil];
    [[self sharedQueue] addOperation:operation];
}

- (void)loadImgThread
{
    if ([self getImage:_url defaultImage:nil]) {
        if (_cropSize.width != 0) {
            [self fadeToImage:[UIImage croppedImage:self.image WithHeight:_cropSize.height andWidth:_cropSize.width]];
        }
    }
}

- (void)dataDownloadEnded:(NSData *)data forUrl:(NSString *)url
{
    if (![url isEqualToString:_url]) return;
    UIImage *finalImage = [UIImage imageWithData:data];
    if (!finalImage) return;
    if (_cropSize.width > 0) {
        finalImage = [UIImage croppedImage:finalImage WithHeight:_cropSize.height andWidth:_cropSize.width];
    }
    [self fadeToImage:finalImage];
}

@end
