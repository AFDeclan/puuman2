//
//  AFImageButton.m
//  AFNetwork
//
//  Created by Declan on 13-12-21.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import "AFImageButton.h"

@implementation AFImageButton

@synthesize imgUrl = _imgUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName
{
    return [self getImage:url defaultImage:defaultImgName animated:NO];
}

//get image by url, if image not downloaded then return no and display default image
- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName animated:(BOOL)animated
{
    _imgUrl = url;
    //whether url is local path
    id image, imgData;
    BOOL isDefault = NO;
    //whether image has already been downloaded
    imgData = [[AFDataStore sharedStore] getDataFromUrl:url delegate:self];
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
    [self setImage:image forState:UIControlStateNormal];
    return !isDefault;
}


//update image when download complete
- (void)dataDownloadEnded:(NSData *)data forUrl:(NSString *)url
{
    if (![url isEqualToString:_imgUrl]) return;
    UIImage *finalImage = [UIImage imageWithData:data];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"imageFade"];
    [self setImage:finalImage forState:UIControlStateNormal];
}

//remove delegate (use when added on tableview cell)
- (void)prepareForReuse{
    [[AFDataStore sharedStore] removeDelegate:self forURL:_imgUrl];
    _imgUrl = nil;
}


@end
