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
#import "MainTabBarController.h"

@interface NewTextPhotoSelectedViewController ()

@end

@implementation NewTextPhotoSelectedViewController
@synthesize delegate = _delegate;
@synthesize isMiddle = _isMiddle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            _isMiddle = NO;
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    imagePickerShowed = NO;
   
}


//竖屏
-(void)setVerticalFrame
{
    [super setVerticalFrame];
    if (imagePickerShowed) {
        
        [popover dismissPopoverAnimated:NO];
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        if (!imagePickerController) {
            imagePickerController = [[UIImagePickerController alloc] init];
        }
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        [popover setDelegate:self];
        //  [popover setPopoverContentSize:CGSizeMake(10, 10)];
        
        //[self presentModalViewController:imagePickerController animated:YES];
        if (_isMiddle) {
            [popover presentPopoverFromRect:CGRectMake(344, 100, 66, 96) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
        }else{
           [popover presentPopoverFromRect:CGRectMake(654, 100, 66, 96) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
        }
        
    }

}

//横屏
-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    if (imagePickerShowed) {
        [popover dismissPopoverAnimated:NO];
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        if (!imagePickerController) {
            imagePickerController = [[UIImagePickerController alloc] init];
        }
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        [popover setDelegate:self];
        //  [popover setPopoverContentSize:CGSizeMake(10, 10)];
        
        //[self presentModalViewController:imagePickerController animated:YES];
        if (_isMiddle){
            [popover presentPopoverFromRect:CGRectMake(472, 100, 66, 96) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
        }else{
            [popover presentPopoverFromRect:CGRectMake(782, 100, 66, 96) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
        }
        
        
        
    }
}
- (void)importBtnPressed
{
    [popover dismissPopoverAnimated:NO];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    if (!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
    }
    imagePickerController.delegate = self;
	imagePickerController.allowsEditing = NO;
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
    [popover setDelegate:self];

    if ([MainTabBarController sharedMainViewController].isVertical) {
        [popover presentPopoverFromRect:CGRectMake(654, 100, 66, 96) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }else
    {
        [popover presentPopoverFromRect:CGRectMake(782, 100, 66, 96) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }
    [_content setAlpha:0];
    [bgView setAlpha:0];
  
    imagePickerShowed = YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    imagePickerShowed = NO;
    [self hidden];
}

- (void)takePicBtnPressed
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    if (!imagePickerController) {
         imagePickerController = [[UIImagePickerController alloc] init];
    }
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
	[self presentModalViewController:imagePickerController animated:YES];
  
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
    
	UIImage *photo = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    [_delegate selectedPhoto:photo];
    if (imagePickerShowed) {
        [popover dismissPopoverAnimated:NO];
    }else{
        [picker dismissModalViewControllerAnimated:YES];
    }
    [self hidden];
}

- (void)hidden
{
    if ([_delegate respondsToSelector:@selector(selectedhidden)]) {
        [_delegate selectedhidden];
    }
    [super hidden];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
