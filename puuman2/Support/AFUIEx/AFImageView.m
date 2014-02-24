//
//  AFImageView.m
//  AFNetwork
//
//  Created by Declan on 13-12-21.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import "AFImageView.h"

@implementation AFImageView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//get image by url, if image not downloaded then return no and display default image
- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName
{
    return [self getImage:url defaultImage:defaultImgName animated:NO];
}

- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName animated:(BOOL)animated
{
    _imgUrl = url;
    //whether url is local path
    id image, imgData;
    BOOL isDefault = NO;
    //whether image has already been downloaded
    if (url != nil) imgData = [[AFDataStore sharedStore] getDataFromUrl:url delegate:self];
    if (!imgData) {
        isDefault = YES;
        if (defaultImgName)
            image = [UIImage imageNamed:defaultImgName];
    }
    else
    {
        image = [UIImage imageWithData:imgData];
    }
    if (animated)
    {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.type = kCATransitionFade;
        [self.layer addAnimation:animation forKey:@"imageFade"];
    }
    [self setImage:image];
    return !isDefault;
}


//update image when download complete
- (void)dataDownloadEnded:(NSData *)data forUrl:(NSString *)url
{
    if (![url isEqualToString:_imgUrl]) return;
    UIImage *finalImage = [UIImage imageWithData:data];
    if (!finalImage) return;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"imageFade"];
    [self setImage:finalImage];
    [_delegate imageView:self imageDownloaded:finalImage];
}

//remove delegate (use when added on tableview cell)
- (void)prepareForReuse{
    [[AFDataStore sharedStore] removeDelegate:self forURL:_imgUrl];
    _imgUrl = nil;
}

@end
