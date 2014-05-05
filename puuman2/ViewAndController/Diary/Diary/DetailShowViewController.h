//
//  DetailShowViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import <MediaPlayer/MediaPlayer.h>
typedef enum {
    kModelOfPicSingle,
    kModelOfPicMore,
    kModelOfVideo,
    kModelOfNone
}DetailModel;

@interface DetailShowViewController : PopViewController<MPMediaPickerControllerDelegate>
{
    
    MPMoviePlayerController *moviePlayer;
    NSArray *photoPaths;
    UIScrollView *photoScroll;
    UIButton *hiddenBtn;
    UILabel *titleLabel;
}
@property (assign, nonatomic)NSInteger index;
@property (assign, nonatomic) DetailModel model;
+(void)showPhotosPath:(NSArray *)imgPaths atIndex:(NSInteger)index andTitle:(NSString *)title;
+(void)showVideo:(NSString *)path andTitle:(NSString *)title;
+(void)showPhotoPath:(NSString *)imgPath andTitle:(NSString *)title;
@end
