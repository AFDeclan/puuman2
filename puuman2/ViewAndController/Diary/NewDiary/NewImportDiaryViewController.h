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
#import "NewDiaryDeleteTableViewCell.h"

#import "ImportSelectedImgView.h"

@interface NewImportDiaryViewController : CustomPopViewController<UIColumnViewDataSource,UIColumnViewDelegate,NewDiaryDeleteTableViewCellDelegate,UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,SelectedImportImgDelegate>
{
    CustomTextField *titleTextField;
    UIColumnView *photosTable;
    NSMutableArray *photosArr;
    UIImagePickerController *imagePickerController;
  
    
}
@property (assign, nonatomic) BOOL isTopic;
@end
