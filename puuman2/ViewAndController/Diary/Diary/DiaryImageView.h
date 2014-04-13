//
//  DiaryImageView.h
//  puuman2
//
//  Created by Declan on 14-4-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryImageView : UIImageView
{
    UIImage *_img;
    NSString *_path;
}

@property (nonatomic, assign) CGSize cropSize;

- (void)loadThumbImgWithPath:(NSString *)imgPath;

- (void)loadImgWithPath:(NSString *)imgPath;

- (void)loadVideoImgWithPath:(NSString *)imgPath;

@end
