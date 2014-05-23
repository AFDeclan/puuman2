//
//  BabyPhotoSelectedViewController.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-5-23.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SelectPhotoImportTypeViewController.h"
@protocol BabyPhotoSelectPhotoDelegate;

@interface BabyPhotoSelectedViewController : SelectPhotoImportTypeViewController<UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    UIImagePickerController *imagePickerController;
    UIPopoverController *popover;
    BOOL imagePickerShowed;
    
}
@property(nonatomic,assign)id<BabyPhotoSelectPhotoDelegate>delegate;
@property(nonatomic,assign)BOOL isMiddle;
@end

@protocol BabyPhotoSelectPhotoDelegate <NSObject>
@optional
- (void)selectedPhoto:(UIImage *)img;
@optional
- (void)selectedhidden;
@end