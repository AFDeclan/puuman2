//
//  NewTextViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewTextViewController.h"
#import "ColorsAndFonts.h"
#import "NewTextPhotoSelectedViewController.h"


@interface NewTextViewController ()

@end

@implementation NewTextViewController

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
    [_content addSubview:titleTextField];
    
    takePicBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
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
    [delBtn addTarget:self action:@selector(delegate) forControlEvents:UIControlEventTouchUpInside];
    [imgBox addSubview:delBtn];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(32, 176, 640, 360)]; //512
    [textView setFont:PMFont2];
    [textView setTextColor:PMColor1];
    [textView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:textView];
    
}

- (void)selectedPhoto
{
    NewTextPhotoSelectedViewController *chooseView = [[NewTextPhotoSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:chooseView.view];
    [chooseView setControlBtnType:kOnlyCloseButton];
    [chooseView show];
    
}

- (void)deletaPhoto
{
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
