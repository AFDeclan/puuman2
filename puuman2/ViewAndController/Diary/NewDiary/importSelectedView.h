//
//  importSelectedView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface importSelectedView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *scrollView;
    UITableView *parentTable;
    UITableView *childTable;
    NSMutableArray *assetGroups;
    ALAssetsLibrary *library;
    NSMutableArray *photosAsset;
    NSMutableArray *elcAssets;
}
@end
