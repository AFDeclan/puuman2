//
//  NewCameraViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewCameraViewController.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "DiaryFileManager.h"
#import "DiaryViewController.h"


@interface NewCameraViewController ()

@end

@implementation NewCameraViewController
@synthesize taskInfo = _taskInfo;
@synthesize isTopic = _isTopic;
@synthesize cameraModel = _cameraModel;
@synthesize delegate = _delegate;
@synthesize titleStr = _titleStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _cameraModel = YES;
        isVertical = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    movieUrl = nil;
  //  titleStr= @"";
    photos = [[NSMutableArray alloc] init];
    photoPath = [[NSMutableArray alloc] init];
    photosStatus = [[NSMutableDictionary alloc] init];
    [self.view setBackgroundColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
    titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(96, 20, 580, 80)];
    [titleTextField setReturnKeyType:UIReturnKeyDone];
    [titleTextField setFont:PMFont(28)];
    [titleTextField setPlaceholder:@"点击这里写点什么......"];
    [titleTextField setKeyboardType:UIKeyboardTypeDefault];
    [titleTextField setDelegate:self];
    [titleTextField setTextColor:[UIColor whiteColor]];
    [titleTextField setClipsToBounds:YES];
    [titleTextField setBorderStyle:UITextBorderStyleNone];
    [titleTextField setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:titleTextField];
    lineView = [[UIView alloc]initWithFrame:CGRectMake(96,81, 580, 1)];
    [lineView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineView];
    [self initialization];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    
    titleTextField.layer.shadowRadius = 2.0f;
    titleTextField.layer.shadowColor=[[UIColor blackColor]CGColor];
    titleTextField.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    titleTextField.layer.shadowOpacity=0.5f;

    return YES;
}
- (void)drawPlaceholderInRect:(CGRect)rect{

    [[UIColor greenColor] setFill];
}

- (void)viewDidAppear:(BOOL)animated
{
    BOOL videoOnly = NO;
    //判断是否是拍照
    
    if (!_cameraModel) {
        [controlView setVideoMode:YES];
        videoOnly = YES;
    }else{
        [controlView setVideoMode:NO];
        
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera] == NO)
        return;
    if (self.taskInfo)
    {
        NSInteger type = [[self.taskInfo valueForKey:_task_TaskType] integerValue];
        if (type == 1 || type == 6 || [[self.taskInfo valueForKey:_task_ID] integerValue] == 2)
        {
            if (controlView.videoMode) {
                [controlView setVideoMode:NO];
            }
        }
        else
        {
            if (controlView.videoMode == NO) {
                [controlView setVideoMode:YES];
            }
        }
        titleTextField.text = [self.taskInfo valueForKey:_task_Name];
        [titleTextField setEnabled:NO];
    }

    cameraUI = [self camera:videoOnly];
    [self.view insertSubview:cameraUI.view atIndex:0];
    [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:0];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(enableControl) userInfo:nil repeats:NO];
}

- (void)setCameraModel:(BOOL)cameraModel
{
    _cameraModel = cameraModel;
   
}


- (void)enableControl
{
    [controlView enableControl];
}

- (void)initialization
{
    controlView = [[NewCameraControlView alloc] initWithFrame:CGRectMake(0, 0, 128, 0)];
    [controlView setDelegate:self];
    [controlView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:controlView];
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
}

- (UIImagePickerController *)camera:(BOOL)video
{
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
    camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if (video)
        [camera setCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
    camera.allowsEditing = NO;
    camera.delegate = self;
    [camera setShowsCameraControls:NO];
    return camera;
}

-(void)setVerticalFrame
{
    [controlView setFrame:CGRectMake(640, 0, 128, 1024)];
    [controlView setVerticalFrame];
}

-(void)setHorizontalFrame
{
    [controlView setFrame:CGRectMake(896, 0, 128, 768)];
    [controlView setHorizontalFrame];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [UIApplication sharedApplication].statusBarHidden = YES;
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        isVertical = NO;
        [self setHorizontalFrame];
        PostNotification(NOTIFICATION_Horizontal, nil);
    }
    else
    {
        isVertical = YES;
        [self setVerticalFrame];
        PostNotification(NOTIFICATION_Vertical, nil);
    }
}

- (void)closeBtnPressed
{
    if (controlView.videoMode) {
        if (movieUrl != nil) {
            [CustomAlertViewController showAlertWithTitle:@"”确定要放弃本条记录？" confirmHandler:^{
                 [self cancel];
            } cancelHandler:^{
                
            } fromViewController:self];
        }else{
            [self cancel];
        }
      
    }else{
        if ([photoPath count] >0) {
            [CustomAlertViewController showAlertWithTitle:@"”确定要放弃本条记录？" confirmHandler:^{
                [self cancel];
            } cancelHandler:^{
                
            } fromViewController:self];
        }else{
            [self cancel];
        }
    }
   
}

- (void)finishBtnPressed
{
    if (controlView.videoMode) {
        if (movieUrl != nil) {
            [DiaryFileManager saveVideo:movieUrl withTitle:titleTextField.text andTaskInfo:_taskInfo];
        }
    }else{
        [DiaryFileManager savePhotoWithPaths:photoPath withAudio:audioFileUrl withTitle:titleTextField.text andTaskInfo:_taskInfo andIsTopic:_isTopic];
    }
  //  if (!_isTopic) {
       //  [_delegate cameraViewHidden];
  // }
    [self cancel];
}

- (void)cancel
{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else [self dismissModalViewControllerAnimated:YES];
}

- (void)frontRareChangeBtnPressed
{
    if (cameraUI.cameraDevice == UIImagePickerControllerCameraDeviceFront)
        [cameraUI setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    else [cameraUI setCameraDevice:UIImagePickerControllerCameraDeviceFront];
}

- (void)takeVideo
{
    if (timeView) {
          [timeView startRecord];
    }else{
        timeView = [[TimeView alloc] initWithFrame:CGRectMake(16, 16, 80, 80)];
        timeView.layer.cornerRadius = 40;
        timeView.layer.masksToBounds = YES;
        [self.view addSubview:timeView];
        [timeView setBackgroundColor:[UIColor whiteColor]];
        [timeView setAlpha:1];
        [timeView showTimeWithSecond:0];
        [timeView startRecord];
    }
    [controlView setFinishBtnEnabled:NO];
    [cameraUI startVideoCapture];
}

- (void)stopVideo
{
    if (timeView) {
        [timeView stopRecord];
    }else{
        timeView = [[TimeView alloc] initWithFrame:CGRectMake(16, 16, 80, 80)];
        timeView.layer.cornerRadius = 40;
        timeView.layer.masksToBounds = YES;
        [self.view addSubview:timeView];
        [timeView setBackgroundColor:[UIColor whiteColor]];
        [timeView setAlpha:1];
        [timeView showTimeWithSecond:0];
        [timeView stopRecord];
    }
    [cameraUI stopVideoCapture];
}

- (void)takePhoto
{
    [cameraUI takePicture];
}

- (void)toVideoModel
{
    if (!timeView) {
        timeView = [[TimeView alloc] initWithFrame:CGRectMake(16, 16, 80, 80)];
        timeView.layer.cornerRadius = 40;
        timeView.layer.masksToBounds = YES;
       
    }
    [self.view addSubview:timeView];
    [timeView setBackgroundColor:[UIColor whiteColor]];
    [timeView setAlpha:1];
    [cameraUI setCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
}

- (void)toPhotoModel
{
    if (timeView) {
        [timeView setAlpha:0];
    }
    [cameraUI setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
}

- (void)showSampleView
{
    NewCameraShowPhotosViewController *showView =[[NewCameraShowPhotosViewController alloc] initWithNibName:nil bundle:nil];
   [self.view addSubview:showView.view];
    [showView setDelegate:self];
   // [showView setTitleStr:titleStr];
    [showView setTitle:@"选择照片" withIcon:nil];
    [showView setControlBtnType:kOnlyFinishButton];
    [showView initWithPhotos:photos andphotoPaths:photoPath];
    [showView show];
}

- (void)showAudioView
{
    
    CameraAudioViewController * audioView = [[CameraAudioViewController alloc] initWithNibName:nil bundle:nil];
    [audioView setControlBtnType:kCloseAndFinishButton];
    [audioView setTitle:@"录声音" withIcon:[UIImage imageNamed:@"icon_audio2_diary.png"]];
    [audioView setDelegate:self];
    [audioView setRecordUrl:audioFileUrl];
    if (isVertical) {
        [audioView setVerticalFrame];
    }else{
        [audioView setHorizontalFrame];
    }
    [self.view addSubview:audioView.view];
  
    [audioView show];
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        UIImage *img = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        UIImageView *imgViewL = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
        [imgViewL setContentMode:UIViewContentModeScaleAspectFill];
        [imgViewL setImage:img];
        if(UIGraphicsBeginImageContextWithOptions != NULL)
        {
            UIGraphicsBeginImageContextWithOptions(imgViewL.frame.size, NO, 0.0);
        } else {
            UIGraphicsBeginImageContext(imgViewL.frame.size);
        }
        //获取图像
        [imgViewL.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [photos addObject:image];
        imgViewL = nil;
     
    
        [controlView addPhoto:image andNum:[photos count]];
        [controlView useCameraBtnWithAble:NO];
        [self performSelector:@selector(saveWithImg:) withObject:img afterDelay:0];
        
    }else if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
              == kCFCompareEqualTo) {
        movieUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        moviePlayer = [[VideoPlayerController alloc] initWithContentURL:movieUrl];
        [moviePlayer prepareToPlay];
        [moviePlayer setDelegate:self];
        [moviePlayer setShouldAutoplay:NO];
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIDeviceOrientationIsPortrait(interfaceOrientation)) {
            [moviePlayer setVerticalFrame];
        }else{
            [moviePlayer setHorizontalFrame];
        }
        
        [moviePlayer setFullscreen:NO];
        [moviePlayer setControlStyle:MPMovieControlStyleNone];
        [self.view addSubview:moviePlayer.view ];
    }
}

- (void)setIsTopic:(BOOL)isTopic
{
    _isTopic = isTopic;

    [controlView setIsTopic:isTopic];
}


- (void)videoFinishedWithTitle:(NSString *)title
{
    //titleStr = title;
    titleTextField.text=title;
    [self finishBtnPressed];
}

- (void)videoClosed{
    
    [moviePlayer.view removeFromSuperview];
    [controlView setVideoBackControl];
    [timeView showTimeWithSecond:0];
    [cameraUI.view removeFromSuperview];
    cameraUI = [self camera:YES];
    [self.view insertSubview:cameraUI.view atIndex:0];
}

- (void)saveWithImg:(UIImage *)img
{
    NSString *path = [DiaryFileManager saveTmpPhoto:img];
    [photoPath addObject:path];
    if (!audioFileUrl || [photoPath count] < 1) {
        [controlView useCameraBtnWithAble:YES];
    }
}



- (void)setTaskInfo:(NSDictionary *)taskInfo
{
    _taskInfo = taskInfo;
    [controlView setTaskInfo:taskInfo];
}

- (void)resetSampleImgWithPhotos:(NSMutableArray *)photosArr  andphotoPaths:(NSMutableArray *)pathsArr
{
   
    int num = [photosArr count];
 
    photos = photosArr;
    photoPath = pathsArr;
    if ([photosArr count]>0) {
        [controlView addPhoto:[photosArr objectAtIndex:num-1] andNum:num];
    }else{
        [controlView addPhoto:nil andNum:0];
        
    }
    
    if (audioFileUrl) {
        [controlView audioWithShow:YES];
    }
    
    if (audioFileUrl && num == 1) {
        [controlView useCameraBtnWithAble:NO];
    }else{
        [controlView useCameraBtnWithAble:YES];
    }
}

//- (void)setTitleStr:(NSString *)title
//{
//    _titleStr = title;
//   
//    [titleTextField setText:_titleStr];
//}

- (void)getAudioWithUrl:(NSURL *)audioUrl
{
    if (audioUrl) {
        audioFileUrl = audioUrl;
    }
    
    if (audioFileUrl&&[photos count] == 1) {
        [controlView useCameraBtnWithAble:NO];
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [titleTextField resignFirstResponder];
    return  YES;
    
}






@end
