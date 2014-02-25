//
//  AFImageButton.h
//  AFNetwork AFUIEx
//
//  Created by Declan on 13-12-21.
//  Copyright (c) 2013年 Declan. All rights reserved.
//

#import "AFButton.h"
#import "AFDataStore.h"

@interface AFImageButton : AFButton <AFDataStoreDelegate>

@property (nonatomic, retain, readonly) NSString *imgUrl;

//get image by url, if image not downloaded then return no and display default image
- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName;
- (BOOL)getImage:(NSString*)url defaultImage:(NSString *)defaultImgName animated:(BOOL)animated;
//remove delegate (use when added on tableview cell)
- (void)prepareForReuse;

@end
