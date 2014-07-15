//
//  ImportSelectedView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ImportSelectedImgView.h"


#define subPhotoNumPerRow 6
#define perImgHeight 92
#define perImgWidth 92
@implementation ImportSelectedImgView
@synthesize delegate =_delegate;
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
    scrollView =[[UIScrollView  alloc] initWithFrame:CGRectMake(32, 0, self.frame.size.width-32, self.frame.size.height)];
    [scrollView setScrollEnabled:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake( self.frame.size.width*2,self.frame.size.height)];
    [scrollView setScrollEnabled:NO];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:scrollView];
    
    parentTable =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-32, self.frame.size.height)];
    [parentTable setDelegate:self];
    [parentTable setDataSource:self];
    [scrollView addSubview:parentTable];
    [parentTable setBackgroundColor:[UIColor clearColor]];
    [parentTable setSeparatorColor:[UIColor clearColor]];
    [parentTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    childTable =[[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width-32, 0, self.frame.size.width-32, self.frame.size.height)];
    [childTable setDelegate:self];
    [childTable setDataSource:self];
    [scrollView addSubview:childTable];
    [childTable setBackgroundColor:[UIColor clearColor]];
    [childTable setSeparatorColor:[UIColor clearColor]];
    [childTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    backBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 96, 32, 64)];
    [backBtn setIconImg:[UIImage imageNamed:@"tri_blue_left.png"]];
    [backBtn setIconSize:CGSizeMake(16, 28)];
    [backBtn adjustLayout];
    [backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn setAlpha:0];
}

- (void)backBtnPressed
{
    [backBtn setAlpha:0];
    spread = NO;
    [elcAssets removeAllObjects];
    [photosAsset removeAllObjects];
    [childTable removeFromSuperview];
    childTable = nil;
    childTable=[[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width-32, 0, self.frame.size.width-32, self.frame.size.height)];
    [childTable setDelegate:self];
    [childTable setDataSource:self];
    [scrollView addSubview:childTable];
    [childTable setBackgroundColor:[UIColor clearColor]];
    [childTable setSeparatorColor:[UIColor clearColor]];
    [childTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [childTable setAlpha:0];
    [scrollView scrollRectToVisible:parentTable.frame animated:YES];
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
    return 100;
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
                
                ImportImgView *imgView = [[ImportImgView alloc] initWithFrame:CGRectMake((perImgWidth +8)*i+16, 4, perImgWidth, perImgHeight)];
                imgView.tag =2+i;
                [cell.contentView addSubview:imgView];
                [imgView setDelegate:self];
            }
        }
        for (int i = 0; i < subPhotoNumPerRow ; i ++)
        {
            
            ImportImgView *imgView = (ImportImgView *)[cell viewWithTag:2+i];
            imgView.flagNum = [indexPath row]*subPhotoNumPerRow +i;
            if ([indexPath row]*subPhotoNumPerRow +i < [elcAssets count]) {
                [imgView setImg:[elcAssets objectAtIndex:[indexPath row]*subPhotoNumPerRow +i]];
                imgView.asset = [photosAsset objectAtIndex:[indexPath row]*subPhotoNumPerRow +i];
                [imgView setAlpha:1];
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
    spread = YES;
    [backBtn setAlpha:1];
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
            if (stop) {
                [childTable setAlpha:1];
                [childTable reloadData];
                //变换
                [scrollView scrollRectToVisible:childTable.frame animated:YES];
            }
        }];
    }
    
}



- (void)clickedWithAsset:(ALAsset *)asset
{
    [_delegate addImg:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
}




@end
