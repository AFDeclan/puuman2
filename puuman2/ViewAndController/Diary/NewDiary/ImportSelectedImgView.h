//
//  ImportSelectedView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImportImgView.h"
#import "AFTextImgButton.h"
@protocol SelectedImportImgDelegate;
@interface ImportSelectedImgView : UIView<UITableViewDataSource,UITableViewDelegate,ImportImgDelegate>
{
    UIScrollView *scrollView;
    UITableView *parentTable;
    UITableView *childTable;
    NSMutableArray *assetGroups;
    ALAssetsLibrary *library;
    NSMutableArray *photosAsset;
    NSMutableArray *elcAssets;
    BOOL spread;
    AFTextImgButton *backBtn;
}
@property(assign,nonatomic) id<SelectedImportImgDelegate> delegate;
@end
@protocol SelectedImportImgDelegate <NSObject>

- (void)addImg:(UIImage *)img;

@end
