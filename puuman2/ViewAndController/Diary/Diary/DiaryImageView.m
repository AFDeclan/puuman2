//
//  DiaryImageView.m
//  puuman2
//
//  Created by Declan on 14-4-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryImageView.h"
#import "DiaryFileManager.h"
#import "UIImageView+AnimateFade.h"
#import "UIImage+CroppedImage.h"


static NSOperationQueue * operationQueue;

@implementation DiaryImageView

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

- (void)loadImgWithPath:(NSString *)imgPath
{
    if ([_path isEqualToString:imgPath]) return;
    _path = imgPath;
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(loadImgThread)
                                                                             object:nil];
    [[self sharedQueue] addOperation:operation];
}

- (void)loadThumbImgWithPath:(NSString *)imgPath
{
    if ([_path isEqualToString:imgPath]) return;
    _path = imgPath;
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(loadThumbImgThread)
                                                                             object:nil];
    [[self sharedQueue] addOperation:operation];
}

- (void)loadVideoImgWithPath:(NSString *)path
{
    if ([_path isEqualToString:path]) return;
    _path = path;
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(loadVideoImgThread)
                                                                             object:nil];
    [[self sharedQueue] addOperation:operation];
}

- (void)loadThumbImgThread
{
    _img = [DiaryFileManager thumbImageForPath:_path];
    if (_cropSize.width != 0) {
        _img = [UIImage croppedImage:_img WithHeight:_cropSize.height andWidth:_cropSize.height];
    }
    [self performSelectorOnMainThread:@selector(setImg) withObject:nil waitUntilDone:NO]
    ;
}

- (void)loadImgThread
{
    _img = [DiaryFileManager imageForPath:_path];
    if (_cropSize.width != 0) {
        _img = [UIImage croppedImage:_img WithHeight:_cropSize.height andWidth:_cropSize.height];
    }
    [self performSelectorOnMainThread:@selector(setImg) withObject:nil waitUntilDone:NO];
}

- (void)loadVideoImgThread
{
    _img = [DiaryFileManager imageForVideo:_path];
    if (_cropSize.width != 0) {
        _img = [UIImage croppedImage:_img WithHeight:_cropSize.height andWidth:_cropSize.height];
    }
    [self performSelectorOnMainThread:@selector(setImg) withObject:nil waitUntilDone:NO];
}

- (void)setImg
{
    [self fadeToImage:_img];
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    _path = nil;
}

@end
