//
//  SelectPhotoImportTypeViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomAlertViewController.h"
@protocol SelectPhotoDelegate;
@interface SelectPhotoImportTypeViewController : CustomAlertViewController
{
    UILabel *takePicLabel;
    UILabel *importPicLabel;
    UIButton *takePicBtn;
    UIButton *importPicBtn;

}
@property(nonatomic,assign)id<SelectPhotoDelegate>selecedDelegate;
- (void)hidden;
@end
@protocol SelectPhotoDelegate <NSObject>
@optional
- (void)selectedImport;
- (void)selectedTakePhotos;
- (void)selectedViewhidden;
@end