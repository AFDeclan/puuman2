//
//  AutoImportViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AutoImportViewController.h"
#import "ColorsAndFonts.h"
#import "ImportImgCell.h"
#import "NSDate+Compute.h"
#import "MainTabBarController.h"
#import "DateFormatter.h"
#import "TaskUploader.h"

#define PhotoNumPerRow 5
#define PerImgHeight 128
#define PerImgWidth 96

@interface AutoImportViewController ()

@end

@implementation AutoImportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectedNum = 0;
        bgImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 704, 608)];
        [bgImgView setImage:[UIImage imageNamed:@"paper_autoinput.png"]];
        [self.view addSubview:bgImgView];
        
        titleTield = [[ImportTitle alloc] initWithFrame:CGRectMake(32, 112, 480, 48)];
        [titleTield setPlaceholder:@"这些照片是......"];
        [self.view addSubview:titleTield];
        
        
        time = [NSDate date];
        closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(632, 24, 48, 48)];
        [closeBtn setImage:[UIImage imageNamed:@"btn_close_diary.png"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closeBtn];
        
        finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(632, 532, 48, 48)];
        [finishBtn setImage:[UIImage imageNamed:@"btn_finish_diary.png"] forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:finishBtn];
        
        UIImageView *bgAuto = [[UIImageView alloc] initWithFrame:CGRectMake(32, 540, 32, 32)];
        [bgAuto setImage:[UIImage imageNamed:@"circle_autoinput.png"]];
        [self.view addSubview:bgAuto];
        autoBtn = [[UIButton alloc] initWithFrame:CGRectMake(32, 540, 32, 32)];
        [autoBtn setImage:[UIImage imageNamed:@"icon_check_autoinput.png"] forState:UIControlStateNormal];
        [autoBtn addTarget:self action:@selector(autoBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:autoBtn];
        autoLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 545, 208, 24)];
        [autoLabel setText:@"下次不需要自动检测"];
        [autoLabel setTextColor:PMColor3];
        [autoLabel setFont:PMFont3];
        [self.view addSubview:autoLabel];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        if (![userDefaults valueForKey:@"autoImport"]) {
            self.autodDetection = YES;
        }else
        {
            if ([[userDefaults valueForKey:@"autoImport"] boolValue]) {
                self.autodDetection = YES;
            }else{
                self.autodDetection = NO;
            }
        }
        
        pickerTable = [[UITableView alloc] initWithFrame:CGRectMake(32, 160, 544, 368)];
        [self.view addSubview:pickerTable];
        [pickerTable setDataSource:self];
        [pickerTable setDelegate:self];
        [pickerTable setBackgroundColor:[UIColor clearColor]];
        [pickerTable setSeparatorColor:[UIColor clearColor]];
        [pickerTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
        [self.view addGestureRecognizer:tap];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)hiddenKeyBoard
{
    [titleTield resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAutodDetection:(BOOL)autodDetection
{
    _autodDetection = autodDetection;
    if (_autodDetection) {
        [autoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [autoBtn setImage:[UIImage imageNamed:@"icon_check_autoinput.png"] forState:UIControlStateNormal];
    }
}

- (void)autoBtnPressed
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _autodDetection = !_autodDetection;
    if (_autodDetection) {
        
        [userDefaults setObject:@"YES" forKey:@"autoImport"];
        
        [autoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [userDefaults setObject:@"NO" forKey:@"autoImport"];
        [autoBtn setImage:[UIImage imageNamed:@"icon_check_autoinput.png"] forState:UIControlStateNormal];
    }
}

- (void)closeBtnPressed
{
    [self cancel];
}

- (void)finishBtnPressed
{
    [self cancel];
    //save the file
    NSString *fileDir = [FileManager fileDirForDiaryType:vType_Photo];
    if (!fileDir) return;
    NSDate *curDate = [NSDate date];
    NSString *fileName = [DateFormatter stringFromDatetime:curDate];
    NSString *filePathAll = nil;
    NSError *error;
    for (int i = 0; i < [photoStatus count]; i++) {
        
        if ([[photoStatus valueForKey:[NSString stringWithFormat:@"%d",i]] boolValue]) {
            
            NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
            filePath = [filePath stringByAppendingFormat:@"_%d.jpg", i];
            UIImage  *img =[UIImage imageWithCGImage:[[(ALAsset *)[assetsArr objectAtIndex:i] defaultRepresentation] fullScreenImage]];
            NSData *imageData = UIImageJPEGRepresentation(img, 0);
            if (![imageData writeToFile:filePath atomically:YES])
            {
                
                [ErrorLog errorLog:@"Write to file failed!" fromFile:@"ImportViewController.m" error:error];
                NSLog(@"Write to file failed!");
                NSLog(@"%@", error.debugDescription);
            }
            if (i == 0) filePathAll = filePath;
            else filePathAll = [filePathAll stringByAppendingFormat:@"#@#%@", filePath];
            
            
        }
    }
    
    NSString *title = titleTield.text;
    if (!title) title = @"";
    NSDictionary *diaryInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                               title, kTitleName,
                               vType_Photo, kTypeName,
                               filePathAll, kFilePathName,
                               curDate, kDateName,
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewDiaryMessage object:diaryInfo];
    [MobClick endEvent:umeng_event_newdiary label:@"ImportDiary"];
    
    TaskUploader *uploader = [TaskUploader uploader];
    [uploader addNewTaskWithDiaryInfo:diaryInfo taskInfo:nil];
    
    [self.parentBlurView dismissSubview];
}

- (void)cancel
{
    self.parentBlurView.viewFrame = self.view.frame;
    [self.parentBlurView dismissSubview];
}

- (void)preparePhotos
{
    assetsArr = [[NSMutableArray alloc] init];
    dateArr  = [[NSMutableArray alloc] init];
    photoArr = [[NSMutableArray alloc] init];
    photoStatus = [[NSMutableDictionary alloc] init];
    NSDate *lastDate;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    lastDate = (NSDate *)[userDefaults valueForKey:@"closeDate"];
    if (lastDate) {
        NSInteger hour = [[NSDate date] hoursFromDate:lastDate];
        //        if (hour < 2) {
        //             [[MainViewController sharedMainViewController ] removeAutoImportView];
        //           return;
        //        }
        hour =20;
        __block BOOL foundThePhoto = NO;
        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
        library = assetLibrary;
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           @autoreleasepool {
                               
                               // Group enumerator Block
                               void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                               {
                                   if (foundThePhoto)
                                   {
                                       *stop = YES;
                                   }
                                   
                                   if (*stop) {
                                       if ([self hasNewPic]) {
                                           [pickerTable reloadData];
                                           
                                           [[MainViewController sharedMainViewController ] showAutoImportView];
                                           selectedNum = [dateArr count];
                                           for (int i = 0 ; i < [dateArr count]; i ++) {
                                               [photoStatus setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",i]];
                                           }
                                       }else{
                                           [[MainViewController sharedMainViewController ] removeAutoImportView];
                                       }
                                       
                                       return ;
                                   }
                                   if (group == nil) {
                                       [[MainViewController sharedMainViewController ] removeAutoImportView];
                                       return;
                                   }
                                   // added fix for camera albums order
                                   NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                                   NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                                   
                                   if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                       @autoreleasepool {
                                           [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                               if (result == nil) {
                                                   return;
                                               }
                                               foundThePhoto = YES;
                                               NSDictionary *dic = [[result defaultRepresentation]metadata];
                                               NSString *dateTime = [[dic objectForKey:@"{TIFF}"]objectForKey:@"DateTime"];
                                               if (dateTime!=nil) {
                                                   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                                   dateFormatter.dateFormat = @"yyyy:MM:dd HH:mm:ss";
                                                   NSDate *date = [dateFormatter dateFromString:dateTime];
                                                   
                                                   NSInteger hour_pic = [[NSDate date] hoursFromDate:date];
                                                   if (hour > hour_pic &[dateArr count]< 30) {
                                                       
                                                       [dateArr addObject:dateTime];
                                                       [assetsArr addObject:result];
                                                       [photoArr addObject: [UIImage imageWithCGImage:[result thumbnail]]];
                                                   }
                                                   
                                               }
                                               if (stop) {
                                                   
                                               }
                                               
                                           }];
                                       }
                                       
                                   }
                                   
                                   
                                   
                                   
                               };
                               
                               // Group Enumerator Failure Block
                               void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                                   
                                   UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                   [alert show];
                                   
                                   NSLog(@"A problem occured %@", [error description]);
                               };
                               
                               // Enumerate Albums
                               [library enumerateGroupsWithTypes:ALAssetsGroupAll
                                                      usingBlock:assetGroupEnumerator
                                                    failureBlock:assetGroupEnumberatorFailure];
                               
                           }
                       });
        
        
    }else {
        [[MainViewController sharedMainViewController ] removeAutoImportView];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    int  rowNum =[assetsArr count]/PhotoNumPerRow;
    if ([assetsArr count]%PhotoNumPerRow != 0) {
        rowNum ++;
    }
    [tableView setContentSize:CGSizeMake(320, 72*rowNum)];
    return rowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 156;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        for (int i = 0; i < PhotoNumPerRow ; i ++) {
            
            ImportImgCell *imgView = [[ImportImgCell alloc] initWithFrame:CGRectMake((PerImgWidth +8)*i+16, 28, PerImgWidth, PerImgHeight)];
            [cell.contentView addSubview:imgView];
            [imgView setTag:2+i];
            [imgView setDelegate:self];
        }
    }
    for (int i = 0; i < PhotoNumPerRow ; i ++) {
        
        ImportImgCell *imgView = (ImportImgCell *)[cell viewWithTag:2+i];
        [imgView setFlagNum:[indexPath row]*PhotoNumPerRow +i];
        if ([indexPath row]*PhotoNumPerRow +i < [assetsArr count]) {
            [imgView setAlpha:1];
            [imgView setImg:[photoArr objectAtIndex:[indexPath row]*PhotoNumPerRow +i]];
            imgView.asset = [assetsArr objectAtIndex:[indexPath row]*PhotoNumPerRow +i];
            
            BOOL selected =[[photoStatus valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]*PhotoNumPerRow +i]] boolValue];
            
            if (selected) {
                imgView.selected = YES;
                [photoStatus setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",[indexPath row]*PhotoNumPerRow +i]];
            }else{
                imgView.selected = NO;
                [photoStatus setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",[indexPath row]*PhotoNumPerRow +i]];
            }
            
        }else{
            [imgView setAlpha:0];
        }
        
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    // Get count
    return cell;
    
}
- (BOOL)hasNewPic
{
    if ([dateArr count] >0) {
        return YES;
    }else{
        return NO;
    }
}
-(void)clickedWithAdd:(BOOL)add andFlag:(NSInteger)num
{
    
    if (add) {
        [photoStatus setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",num]];
        selectedNum ++;
    }else{
        [photoStatus setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",num]];
        selectedNum--;
    }
    [finishBtn setEnabled:YES];
    [finishBtn setAlpha:1];
    if (selectedNum == 0) {
        [finishBtn setEnabled:NO];
        [finishBtn setAlpha:0.5];
    }
    [titleTield resignFirstResponder];
}

@end
