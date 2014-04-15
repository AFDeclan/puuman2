//
//  importSelectedView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "importSelectedView.h"

#define subPhotoNumPerRow 4
#define perImgHeight 64
#define perImgWidth 64
@implementation importSelectedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initialization];
        [self preparePhotos];
    }
    return self;
}

- (void)initialization
{
    scrollView =[[UIScrollView  alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [scrollView setScrollEnabled:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake( self.frame.size.width*2,self.frame.size.height)];
    [scrollView setScrollEnabled:NO];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:scrollView];
    
    parentTable =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [parentTable setDelegate:self];
    [parentTable setDataSource:self];
    [scrollView addSubview:parentTable];
    [parentTable setBackgroundColor:[UIColor clearColor]];
    [parentTable setSeparatorColor:[UIColor clearColor]];
    [parentTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    childTable =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [childTable setDelegate:self];
    [childTable setDataSource:self];
    [scrollView addSubview:childTable];
    [childTable setBackgroundColor:[UIColor clearColor]];
    [childTable setSeparatorColor:[UIColor clearColor]];
    [childTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}




- (void)preparePhotos
{
    photosAsset = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	assetGroups = tempArray;
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    library = assetLibrary;
    NSMutableArray *elcArray = [[NSMutableArray alloc] init];
    elcAssets = elcArray;
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       @autoreleasepool {
                           
                           // Group enumerator Block
                           void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                           {
                               if (group == nil) {
                                   return;
                               }
                               
                               // added fix for camera albums order
                               NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                               NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                               
                               if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                   [assetGroups insertObject:group atIndex:0];
                               }
                               else {
                                   [assetGroups addObject:group];
                               }
                               // Reload albums
                               if (stop) {
                                   [parentTable reloadData];
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

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    int rowNum;
    if (tableView ==parentTable) {
        rowNum = (int)[assetGroups count];
        [tableView setContentSize:CGSizeMake(320, 72*rowNum)];
        return rowNum;
    }
    rowNum =(int)[elcAssets count]/subPhotoNumPerRow;
    if ([elcAssets count]%subPhotoNumPerRow != 0) {
        rowNum ++;
    }
    [tableView setContentSize:CGSizeMake(320, 72*rowNum)];
    return rowNum;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == parentTable) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        // Get count
        ALAssetsGroup *g = (ALAssetsGroup*)[assetGroups objectAtIndex:indexPath.row];
        [g setAssetsFilter:[ALAssetsFilter allPhotos]];
        NSInteger gCount = [g numberOfAssets];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];
        [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[assetGroups objectAtIndex:indexPath.row] posterImage]]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setBackgroundColor:[UIColor clearColor]];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spread:)];
        cell.tag = indexPath.row;
        [cell addGestureRecognizer:tap];
        
        return cell;
        
    }
    if (tableView == childTable) {
        static NSString *CellIdentifier = @"SubCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            for (int i = 0; i < subPhotoNumPerRow ; i ++) {
                
                ImportImgCell *imgView = [[ImportImgCell alloc] initWithFrame:CGRectMake((perImgWidth +8)*i+16, 4, perImgWidth, perImgHeight)];
                imgView.tag =2+i;
                [cell.contentView addSubview:imgView];
                [imgView setDelegate:self];
            }
        }
        for (int i = 0; i < subPhotoNumPerRow ; i ++)
        {
            
            ImportImgCell *imgView = (ImportImgCell *)[cell viewWithTag:2+i];
            imgView.flagNum = [indexPath row]*subPhotoNumPerRow +i;
            if ([indexPath row]*subPhotoNumPerRow +i < [elcAssets count]) {
                [imgView setImg:[elcAssets objectAtIndex:[indexPath row]*subPhotoNumPerRow +i]];
                imgView.asset = [photosAsset objectAtIndex:[indexPath row]*subPhotoNumPerRow +i];
                [imgView setAlpha:1];
                BOOL selected =[(NSNumber *)[photoStatus valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]*subPhotoNumPerRow +i]] boolValue];
                if (selected) {
                    imgView.selected = YES;
                    [photoStatus setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",[indexPath row]*subPhotoNumPerRow +i]];
                }else{
                    imgView.selected = NO;
                    [photoStatus setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",[indexPath row]*subPhotoNumPerRow +i]];
                }
            }else{
                [imgView setAlpha:0];
            }
        }
        [cell setBackgroundColor:[UIColor whiteColor]];
        // Get count
        return cell;
        
    }
    
    return nil;
}

- (void)spread:(UITapGestureRecognizer *)gestureReconizer
{
    [titleTextView resignFirstResponder];
    spread = YES;
    [title setTitleImg:@"title_input_diary.png" andLeftImg:@"nav_left.png" andRightImg:nil];
    ALAssetsGroup *subAssetGroup = [assetGroups objectAtIndex:gestureReconizer.view.tag];
    [self setSubAssetGroup:subAssetGroup];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)setSubAssetGroup:(ALAssetsGroup *)subAssetGroup
{
    @autoreleasepool {
        [subAssetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if (result == nil) {
                return;
            }
            // NSURL *url = [[result defaultRepresentation] url];
            [photosAsset addObject:result];
            UIImage *image =[UIImage imageWithCGImage:[result thumbnail]];
            [elcAssets addObject:image];
            [photoStatus setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",[photosAsset count]-1]];
            if (stop) {
                [subPickerTable setAlpha:1];
                [subPickerTable reloadData];
                //变换
                [scroll scrollRectToVisible:subPickerTable.frame animated:YES];
            }
        }];
    }
    
}

- (void)leftBtnPressed
{
    [title setTitleImg:@"title_input_diary.png" andLeftImg:nil andRightImg:nil];
    spread = NO;
    [elcAssets removeAllObjects];
    [photoStatus removeAllObjects];
    [photosAsset removeAllObjects];
    [subPickerTable removeFromSuperview];
    subPickerTable = nil;
    subPickerTable=[[UITableView alloc] initWithFrame:CGRectMake(320, 0, 320, kScreenHeight-136)];
    [subPickerTable setDelegate:self];
    [subPickerTable setDataSource:self];
    [scroll addSubview:subPickerTable];
    [subPickerTable setBackgroundColor:[UIColor clearColor]];
    [subPickerTable setSeparatorColor:[UIColor clearColor]];
    [subPickerTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [subPickerTable setAlpha:0];
    [scroll scrollRectToVisible:pickerTable.frame animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [titleTextView resignFirstResponder];
}

- (void)clickedWithAdd:(BOOL)add withCell:(ImportImgCell *)cell
{
    if (selectedNum <5) {
        if (add) {
            cell.selected =YES;
            [photoStatus setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",cell.flagNum]];
            selectedNum ++;
        }else{
            cell.selected =NO;
            [photoStatus setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",cell.flagNum]];
            selectedNum--;
        }
        [finish setEnabled:YES];
        [finish setAlpha:1];
        if (selectedNum == 0) {
            [finish setEnabled:NO];
            [finish setAlpha:0.5];
        }
    }else
    {
        if (add) {
            
            cell.selected = NO;
        }else{
            
            cell.selected = YES;
        }
        PostNotification(Noti_ShowAlert, @"可导入图片已到最大，无法再增加了");
    }
    [titleTextView resignFirstResponder];
    
}


@end
