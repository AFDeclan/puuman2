//
//  NewCameraShowPhotosViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-6.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "NewDiaryDeleteCell.h"

@protocol NewCameraShowPhotosDelegate;
@interface NewCameraShowPhotosViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate,NewDiaryDeleteCellDelegate>
{
    CustomTextField *titleTextField;
    UITableView *photosTable;
    NSMutableArray *photosArr;
    NSMutableArray *pathArr;
}

@property (assign,nonatomic)id<NewCameraShowPhotosDelegate>delegate;
@property (retain,nonatomic)NSString *titleStr;
- (void)initWithPhotos:(NSMutableArray *)photos  andphotoPaths:(NSMutableArray *)paths;
- (NSMutableArray *)getPaths;
- (NSMutableArray *)getPhotos;


@end
@protocol NewCameraShowPhotosDelegate <NSObject>
- (void)resetSampleImgWithPhotos:(NSMutableArray *)photosArr  andphotoPaths:(NSMutableArray *)pathsArr;
- (void)setTitleStr:(NSString *)title;
@end