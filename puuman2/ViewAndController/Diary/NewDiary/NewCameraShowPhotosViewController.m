//
//  NewCameraShowPhotosViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-6.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewCameraShowPhotosViewController.h"
#define numOfPhotosPerRow 5
@interface NewCameraShowPhotosViewController ()

@end

@implementation NewCameraShowPhotosViewController
@synthesize delegate = _delegate;
@synthesize titleStr = _titleStr;
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
    titleTextField.keyboardType = UIKeyboardTypeDefault;
    titleTextField.returnKeyType = UIReturnKeyDone;
    [titleTextField setDelegate:self];
    [_content addSubview:titleTextField];
    photosTable = [[UITableView alloc] initWithFrame:CGRectMake(32, 160, 640, 384)];
    [photosTable setDataSource:self];
    [photosTable setDelegate:self];
    [photosTable setBackgroundColor:[UIColor whiteColor]];
    [photosTable setSeparatorColor:[UIColor clearColor]];
    [photosTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_content addSubview:photosTable];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithPhotos:(NSMutableArray *)photos  andphotoPaths:(NSMutableArray *)paths
{
    photosArr = photos;
    pathArr = paths;
    [photosTable reloadData];
    
}

- (NSMutableArray *)getPaths
{
    return pathArr;
}

- (NSMutableArray *)getPhotos
{
    return photosArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    int rowNum = [photosArr count]/numOfPhotosPerRow ;
    if ([photosArr count]%numOfPhotosPerRow != 0) {
        rowNum ++;
    }
    return rowNum;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"showPhotoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        for (int i = 0; i < numOfPhotosPerRow ; i ++) {
            NewDiaryDeleteCell *imgCell = [[NewDiaryDeleteCell alloc] initWithFrame:CGRectMake(i*128, 0, 128, 128)];
            [imgCell setDelegate:self];
            [imgCell setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:imgCell];
            imgCell.tag = i + 2;
        }
        
    }
    for (int i = 0; i < numOfPhotosPerRow ; i ++)
    {
        NewDiaryDeleteCell *imgCell = (NewDiaryDeleteCell *)[cell viewWithTag:i+2];
        if ([indexPath row]*numOfPhotosPerRow +i < [photosArr count]) {
            [imgCell setImg:[photosArr objectAtIndex:[indexPath row]*numOfPhotosPerRow +i]];
            [imgCell setAlpha:1];
            imgCell.index =[indexPath row]*numOfPhotosPerRow +i;
            }else{
                [imgCell setAlpha:0];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)deleteWithIndex:(NSInteger)index
{
    [photosArr removeObjectAtIndex:index];
    [[NSFileManager defaultManager] removeItemAtPath:[pathArr objectAtIndex:index] error:nil];
    [pathArr removeObjectAtIndex:index];
    [photosTable reloadData];
    [_delegate resetSampleImgWithPhotos:photosArr andphotoPaths:pathArr];

}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    [titleTextField setText:titleStr];
}

- (void)closeBtnPressed
{
    [_delegate setTitleStr:titleTextField.text];
    [super closeBtnPressed];
    
}

- (void)finishBtnPressed
{
    [_delegate setTitleStr:titleTextField.text];
    [super finishBtnPressed];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

@end
