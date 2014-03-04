//
//  NewTextPhotoSelectedViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewTextPhotoSelectedViewController.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"

@interface NewTextPhotoSelectedViewController ()

@end

@implementation NewTextPhotoSelectedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        SetViewLeftUp(_titleLabel, 0, 56);
        [_titleLabel setText:@"您想要？"];
        takePicLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 130, 48, 20)];
        [takePicLabel setText:@"拍照"];
        [takePicLabel setTextColor:PMColor8];
        [takePicLabel setFont:PMFont2];
        [_content addSubview:takePicLabel];
        importPicLabel = [[UILabel alloc] initWithFrame:CGRectMake(334, 130, 48, 20)];
        [importPicLabel setText:@"拍照"];
        [importPicLabel setTextColor:PMColor8];
        [takePicLabel setFont:PMFont2];
        [_content addSubview:importPicLabel];
        [importPicLabel setText:@"导入"];
        takePicBtn = [[UIButton alloc] initWithFrame:CGRectMake(78, 112, 56, 56)];
        [takePicBtn setImage:[UIImage imageNamed:@"btn_photo3_diary.png"] forState:UIControlStateNormal];
        [takePicBtn addTarget:self action:@selector(takePicBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:takePicBtn];
        importPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(270, 112, 56, 56)];
        [importPicBtn setImage:[UIImage imageNamed:@"btn_input_diary.png"] forState:UIControlStateNormal];
        [takePicBtn addTarget:self action:@selector(importBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:importPicBtn];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)importBtnPressed
{

}

- (void)takePicBtnPressed
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show
{
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.7 delegate:self startSelector:nil stopSelector:nil];
}

- (void)hidden
{
   
    [_content hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.2 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super finishOut];
}
@end
