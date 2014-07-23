//
//  AutoImportViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "UserInfo.h"
#import "AuToImportImgCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define IMPORT_IMAGE_MAX_NUM    50
@interface AutoImportViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate,AuToImporImgDelegate,UITextFieldDelegate>
{
    CustomTextField *titleTield;
    UILabel *notiLabel;
    UIButton *autoBtn;
    UILabel *autoLabel;
    UITableView *pickerTable;
    ALAssetsLibrary *library;
    
    NSMutableArray *assetsArr;;
    NSMutableArray *dateArr;
    NSMutableArray *photoArr;
    NSMutableDictionary *photoStatus;
    NSDate *time;
    int selectedNum;
    NSThread *thread;
}

@property(nonatomic,assign)BOOL autodDetection;

- (void)preparePhotos;
- (BOOL)hasNewPic;

@end
