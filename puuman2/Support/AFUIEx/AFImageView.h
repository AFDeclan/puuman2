//
//  AFImageView.h
//  AFNetwork
//
//  Created by Declan on 13-12-21.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFDataStore.h"


@class AFImageView;
@protocol AFImageViewDelegate <NSObject>
- (void)imageView:(AFImageView *)afImageView imageDownloaded:(UIImage *)image;
@end

@interface AFImageView : UIImageView <AFDataStoreDelegate>

@property (nonatomic, retain, readonly) NSString *imgUrl;
@property (nonatomic, assign) id<AFImageViewDelegate> delegate;

//get image by url, if image not downloaded then return no and display default image
- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName;
- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName animated:(BOOL)animated;
//remove delegate (use when added on tableview cell)
- (void)prepareForReuse;

@end
