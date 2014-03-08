//
//  NewTextDiaryViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewTextDiaryViewController.h"
#import "ColorsAndFonts.h"
#import "UIImage+CroppedImage.h"
#import "DiaryFileManager.h"



@interface NewTextDiaryViewController ()

@end

@implementation NewTextDiaryViewController
@synthesize taskInfo = _taskInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [self initContent];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    
}

- (void)initContent
{
    titleTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 112, 640, 48)];
    titleTextField.placeholder = @"这些照片是……";
   // [titleTextField setDelegate:self];
    [_content addSubview:titleTextField];
    
    takePicBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [takePicBtn setImage:[UIImage imageNamed:@"btn_pic_diary.png"] forState:UIControlStateNormal];
    [takePicBtn addTarget:self action:@selector(selectedPhoto) forControlEvents:UIControlEventTouchUpInside];
    [titleTextField setRightViewMode:UITextFieldViewModeAlways];
    [titleTextField setRightView:takePicBtn];
    
    imgBox = [[UIView alloc] initWithFrame:CGRectMake(560, 160, 120, 128)];
    [imgBox setBackgroundColor:[UIColor clearColor]];
    [imgBox setAlpha:0];
    [_content addSubview:imgBox];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 112, 112)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imgBox addSubview:imageView];
    
    delBtn = [[UIButton alloc] initWithFrame:CGRectMake(88, 8, 32, 32)];
    [delBtn setImage:[UIImage imageNamed:@"btn_delete3_diary.png"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(deletePhoto) forControlEvents:UIControlEventTouchUpInside];
    [imgBox addSubview:delBtn];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(32, 176, 640, 360)]; //512
    [textView setFont:PMFont2];
    [textView setDelegate:self];
    [textView setTextColor:PMColor1];
    [textView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:textView];
    
}

- (void)selectedPhoto
{
    NewTextPhotoSelectedViewController *chooseView = [[NewTextPhotoSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:chooseView.view];
    [chooseView setDelegate:self];
    [chooseView setStyle:Question];
    [chooseView show];
    
}

- (void)selectedPhoto:(UIImage *)img
{
    photo = img;
    img = [UIImage croppedImage:img WithHeight:224 andWidth:224];
    [imageView setImage:img];
    [imgBox setAlpha:1];
    [textView setFrame:CGRectMake(32, 176, 512, 360)];
}

- (void)deletePhoto
{
    photo = nil;
    [imageView setImage:nil];
    [imgBox setAlpha:0];
    [textView setFrame:CGRectMake(32, 176, 640, 360)];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishBtnPressed
{
    if ([textView.text isEqualToString:@""]) {
        if (photo) {
            [DiaryFileManager savePhotos:[NSArray arrayWithObject:photo] withAudio:nil withTitle:titleTextField.text andTaskInfo:nil];
        }
    }else{
        [DiaryFileManager saveText:textView.text withPhoto:photo withTitle:titleTextField.text andTaskInfo:_taskInfo];
    }

    
    [super finishBtnPressed];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if (!img) {
//        
//        if (range.length == 1) {
//            if ([textView.text length]==1) {
//                if (!img) {
//                    [_finishBtn setAlpha:0.5];
//                    [_finishBtn setEnabled:NO];
//                }
//            }else
//            {
//                [_finishBtn setAlpha:1];
//                [_finishBtn setEnabled:YES];
//            }
//        }else{
//            if ([text isEqualToString:@""]) {
//                if (!img) {
//                    [_finishBtn setAlpha:0.5];
//                    [_finishBtn setEnabled:NO];
//                }
//            }else{
//                [_finishBtn setAlpha:1];
//                [_finishBtn setEnabled:YES];
//            }
//            
//        }
//    }
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
////    if (range.length == 0) {
////        if ([textField.text length] >=15) {
////            NSString *str = [textField.text substringToIndex:15];
////            textField.text =str;
////        }
////    }
//    return YES;
//}

@end
