//
//  NewImportDiaryViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewImportDiaryViewController.h"

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
    
    photosTable = [[UIColumnView alloc] initWithFrame:CGRectMake(16, 64, 288, 64)];
    [photosTable setBackgroundColor:[UIColor clearColor]];
    [photosTable setViewDelegate:self];
    [photosTable setViewDataSource:self];
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

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    return 80;
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    return [photosArr count];
}


- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"photoColumnCell";
    UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        ImportImgCell *imgView = [[ImportImgCell alloc] initWithFrame:CGRectMake(8, 0, 64, 64)];
//        [imgView setDelegate:self];
//        [imgView setTag:2];
//        [imgView setDelegate:self];
//        [cell.contentView addSubview:imgView];
        
    }
//    ImportImgCell *imgView = (ImportImgCell *)[cell viewWithTag:2];
//    UIImage *img = [UIImage croppedImage:[photoArr objectAtIndex:index] WithHeight:128 andWidth:128 ];
//    [imgView setImg:img];
//    imgView.asset = [assetsArr objectAtIndex:index];
//    imgView.flagNum = index;
//    BOOL selected =[(NSNumber *)[photoStatus valueForKey:[NSString stringWithFormat:@"%d",index]] boolValue];
//    if (selected) {
//        [photoStatus setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",index]];
//        imgView.selected = YES;
//    }else{
//        [photoStatus setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",index]];
//        imgView.selected = NO;
//    }
//    
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

@end
