//
//  NewImportDiaryViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewImportDiaryViewController.h"
#import "MainTabBarController.h"
#import "ColorsAndFonts.h"
#import "DiaryFileManager.h"

@interface NewImportDiaryViewController ()

@end

@implementation NewImportDiaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    photosArr = [[NSMutableArray alloc] init];
    titleTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 112, 640, 48)];
    titleTextField.placeholder = @"这些照片是……";
    [_content addSubview:titleTextField];
    
    UILabel *notiTitle = [[UILabel alloc] initWithFrame:CGRectMake(32, 160, 640, 128)];
    [notiTitle setBackgroundColor:[UIColor clearColor]];
    [notiTitle setText:@"请在下方选择要导入的照片"];
    [notiTitle setTextAlignment:NSTextAlignmentCenter];
    [notiTitle setTextColor:PMColor2];
    [notiTitle setFont:PMFont1];
    [_content addSubview:notiTitle];
    
    photosTable = [[UIColumnView alloc] initWithFrame:CGRectMake(32, 160, 640, 128)];
    [photosTable setBackgroundColor:[UIColor whiteColor]];
    [photosTable setViewDelegate:self];
    
    [photosTable setViewDataSource:self];
    [_content addSubview:photosTable];
   
    UILabel *noti = [[UILabel alloc] initWithFrame:CGRectMake(32, 288, 320, 24)];
    [noti setBackgroundColor:[UIColor clearColor]];
    [noti setText:@"本地相册："];
    [noti setTextColor:PMColor2];
    [noti setFont:PMFont2];
    [_content addSubview:noti];
   
}

- (void)setControlBtnType:(ControlBtnType)controlBtnType
{
    [super setControlBtnType:controlBtnType];
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view.
}


- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(importViewAppear)];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)importViewAppear
{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    if (!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
    }
    imagePickerController.delegate = self;
	imagePickerController.allowsEditing = NO;
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController.view setFrame:CGRectMake(0, 0, 648, 256)];
    [imagePickerController.view setBackgroundColor:[UIColor clearColor]];
    
    UIScrollView *frameView = [[UIScrollView alloc] initWithFrame:CGRectMake(28, 312, 648, 256)];
    [frameView setScrollEnabled:NO];
    [frameView addSubview:imagePickerController.view];
    frameView.layer.cornerRadius = 8.0f;
    [frameView setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:frameView];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
    
	UIImage *photo = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    [photosArr addObject:photo];
    CGPoint pos =photosTable.contentOffset;
    [photosTable reloadData];
    photosTable.contentOffset =pos;
    float posX  = 128*[photosArr count]>640?128*([photosArr count] -5):pos.x;
    [photosTable setContentOffset:CGPointMake(posX, 0) animated:YES];
    [_finishBtn setAlpha:1];
    [_finishBtn setEnabled:YES];
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    return 128;
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    int count = [photosArr count];
    if (count == 0) {
        [photosTable setAlpha: 0];
    }else{
        [photosTable setAlpha: 1];
    }
    return [photosArr count];
}


- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"importColumnCell";
    NewDiaryDeleteTableViewCell *cell = (NewDiaryDeleteTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[NewDiaryDeleteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        
    }
    
    cell.img = (UIImage *)[photosArr objectAtIndex:index];
    cell.index =index;
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

- (void)deleteWithIndex:(NSInteger)index
{
    CGPoint pos =photosTable.contentOffset;
  
    [photosArr removeObjectAtIndex:index];
    [photosTable removeFromSuperview];
    photosTable = [[UIColumnView alloc] initWithFrame:CGRectMake(32, 160, 640, 128)];
    [photosTable setBackgroundColor:[UIColor whiteColor]];
    [photosTable setViewDelegate:self];
    [photosTable setViewDataSource:self];
    [_content addSubview:photosTable];
    [photosTable reloadData];
    
    
    float posX = 0;
    
    if (128*[photosArr count]>640) {
        posX  = 128*[photosArr count]-pos.x == 640?pos.x-128:pos.x;
    }else{
        posX = 0;
    }
    
    
    [photosTable setContentOffset:CGPointMake(posX, 0) animated:NO];
    if ([photosArr count] >0) {
        [_finishBtn setAlpha:1];
        [_finishBtn setEnabled:YES];
    }else{
        [_finishBtn setAlpha:0.5];
        [_finishBtn setEnabled:NO];
    }
    
}

- (void)finishBtnPressed
{
    [DiaryFileManager savePhotos:photosArr withAudio:nil withTitle:titleTextField.text andTaskInfo:nil];
    [super finishBtnPressed];
}
@end