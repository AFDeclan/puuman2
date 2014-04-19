//
//  NewTextPhotoSelectedViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SelectPhotoImportTypeViewController.h"
@protocol NewTextSelectPhotoDelegate;

@interface NewTextPhotoSelectedViewController : SelectPhotoImportTypeViewController<UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    UIImagePickerController *imagePickerController;
    UIPopoverController *popover;
    BOOL imagePickerShowed;
 
}
@property(nonatomic,assign)id<NewTextSelectPhotoDelegate>delegate;
@property(nonatomic,assign)BOOL isMiddle;
@end

@protocol NewTextSelectPhotoDelegate <NSObject>
@optional
- (void)selectedPhoto:(UIImage *)img;
- (void)selectedhidden;
@end