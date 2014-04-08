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
@synthesize  isTopic =_isTopic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isTopic = NO;
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
    [takePicBtn addTarget:self action:@selector(selectedPhotoBtnPressed) forControlEvents:UIControlEventTouchUpInside];
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
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(32, 176, 640, 360)]; //512
    [_textView setFont:PMFont2];
    [_textView setDelegate:self];
    [_textView setTextColor:PMColor1];
    [_textView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:_textView];
    
    
}

- (void)selectedPhotoBtnPressed
{
    [_textView resignFirstResponder];
    NewTextPhotoSelectedViewController *chooseView = [[NewTextPhotoSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:chooseView.view];
    [chooseView setDelegate:self];
    [chooseView setStyle:Question];
    [chooseView show];
    
}

- (void)selectedPhoto:(UIImage *)img
{
    photo = img;
    [_finishBtn setAlpha:1];
    [_finishBtn setEnabled:YES];
    img = [UIImage croppedImage:img WithHeight:224 andWidth:224];
    [imageView setImage:img];
    [imgBox setAlpha:1];
    [_textView setFrame:CGRectMake(32, 176, 512, 360)];
}

- (void)deletePhoto
{
    photo = nil;
    [imageView setImage:nil];
    [imgBox setAlpha:0];
    [_textView setFrame:CGRectMake(32, 176, 640, 360)];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishBtnPressed
{
    if ([_textView.text isEqualToString:@""]) {
        if (photo) {
            [DiaryFileManager savePhotos:[NSArray arrayWithObject:photo] withAudio:nil withTitle:titleTextField.text andTaskInfo:nil andIsTopic:NO];
        }
    }else{
        [DiaryFileManager saveText:_textView.text withPhoto:photo withTitle:titleTextField.text andTaskInfo:_taskInfo andIsTopic:_isTopic];
    }

    if (!_isTopic) {
         [super finishBtnPressed];
    }
   
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (!photo) {
        
        if (range.length == 1) {
            if ([textView.text length]==1) {
                _finishBtn.enabled = NO;
                _finishBtn.alpha = 0.5;
            }else
            {
                _finishBtn.enabled = YES;
                _finishBtn.alpha = 1;
            }
        }else{
            
            _finishBtn.enabled = YES;
            _finishBtn.alpha = 1;
        }
        return YES;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 0) {
        if ([textField.text length] >=15) {
            NSString *str = [textField.text substringToIndex:15];
            textField.text =str;
        }
    }
    return YES;
}

- (void)show{
    
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:@selector(showStart) stopSelector:nil];
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
}

- (void)setIsTopic:(BOOL)isTopic
{
    _isTopic = isTopic;
    if (isTopic) {
        [[Forum sharedInstance] removeDelegateObject:self];
        [[Forum sharedInstance] addDelegateObject:self];
        [takePicBtn setAlpha:0];
    }else{
        [takePicBtn setAlpha:1];
    }
}

 -(void)showStart
{
    [_textView becomeFirstResponder];
}

//回复上传成功
- (void)topicReplyUploaded:(ReplyForUpload *)reply
{
    PostNotification(Noti_RefreshTopicTable, nil);
    [[Forum sharedInstance] removeDelegateObject:self];
    [super finishBtnPressed];
}

//回复上传失败
- (void)topicReplyUploadFailed:(ReplyForUpload *)reply
{
    
}

@end
