//
//  NewImportDiaryViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "UIColumnView.h"
#import "NewImportDiaryTableViewCell.h"
@interface NewImportDiaryViewController : CustomPopViewController<UIColumnViewDataSource,UIColumnViewDelegate,NewImportCellDelegate,UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CustomTextField *titleTextField;
    UIColumnView *photosTable;
    NSMutableArray *photosArr;
    UIImagePickerController *imagePickerController;
}
@end
