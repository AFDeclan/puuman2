//
//  DiaryTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryTableViewController.h"
#import "DiaryModel.h"
#import "CustomNotiViewController.h"
#import "Diary.h"
#import "MainTabBarController.h"
#import "DiaryViewController.h"
#import "ImportStore.h"
#import "DiaryProgressHeaderView.h"
#import "ImportRefreshCell.h"
#import "ImportStore.h"

@interface DiaryTableViewController ()

@end

static BOOL needLoadInfo = YES;

@implementation DiaryTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // Custom initialization
        [MyNotiCenter addObserver:self selector:@selector(imported:) name:Noti_Imported object:nil];
        [MyNotiCenter addObserver:self selector:@selector(addDiary) name:Noti_AddDiaryTable object:nil];
        [MyNotiCenter addObserver:self selector:@selector(reloadDiaryTable) name:Noti_ReloadDiaryTable object:nil];
        [MyNotiCenter addObserver:self selector:@selector(deleteDiary:) name:Noti_DeleteDiary object:nil];
        [MyNotiCenter addObserver:self selector:@selector(deletBtnShowed:) name:Noti_DelBtnShowed object:nil];
 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];

}

- (void)viewWillAppear:(BOOL)animated
{

}

+ (BOOL)needLoadInfo
{
    return needLoadInfo;
}

- (void)startGif
{
    PostNotification(Noti_StartGif, nil);
}

- (void)imported:(NSNotification *)notification
{
    show = [[notification object] boolValue];

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 0)] withRowAnimation:UITableViewRowAnimationAutomatic];
    PostNotification(Noti_ImportRefresh, [NSNumber numberWithBool:show]);
    if (!show) {
        [[ImportStore shareImportStore] addNewDiary];
        [self addDiary];
        [[ImportStore shareImportStore] reset];
        
    }
}

- (void)diaryLoading;
{
    [self reloadDiaryTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
        case 1:
            return  [[[DiaryModel sharedDiaryModel]diaries]count];
        case 2:
            return 1;
        default:
            return 1;
            break;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    PostNotification(Noti_LoadDiaryCellInfo, nil);
    needLoadInfo = YES;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    needLoadInfo = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    needLoadInfo = !decelerate;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (ABS(velocity.y) > 20) {
        needLoadInfo = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [MyNotiCenter postNotificationName:Noti_DiaryCellVisible object:[NSNumber numberWithFloat:self.tableView.contentOffset.y]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) // 任务
    {
        if (indexPath.row == 0) {
            static NSString *identify = @"HeadCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 672, 48)];
                [imgView setImage:[UIImage imageNamed:@"paper_top_diary.png"]];
                [cell.contentView addSubview:imgView];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setBackgroundColor:[UIColor clearColor]];
            return cell;
        }else{
            static NSString *identify = @"ImportRefrsh";
            ImportRefreshCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil)
            {
                cell = [[ImportRefreshCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
              
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setBackgroundColor:[UIColor clearColor]];
            return cell;
        }
        
    }else if(indexPath.section == 2)
    {
        static NSString *identify = @"FootCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            UIImageView *footImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 672, 48)];
            [footImgView setImage:[UIImage imageNamed:@"paper_bottom_diary.png"]];
            [cell.contentView addSubview:footImgView];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
         [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }
    Diary *diary =[[[DiaryModel sharedDiaryModel] diaries]objectAtIndex:indexPath.row];
    DiaryCell *cell;;
    NSString *type = diary.type1Str;
    NSString *type2 =diary.type2Str;
    NSString *identity;
    
                      
    if ([type isEqualToString:DiaryTypeStrAudio])
    {
        identity = DiaryTypeStrAudio;
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[AudioDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [cell setDiaryType:kDiaryAudioType];
        }
        
        
        
    }else if ([type isEqualToString:DiaryTypeStrVideo])
    {
        identity = DiaryTypeStrVideo;
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
          cell = [[VideoDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [cell setDiaryType:kDiaryVideoType];
        }
        
    }else if ([type isEqualToString:DiaryTypeStrPhoto])
    {
        if ([type2 isEqualToString:DiaryTypeStrAudio])
        {
            identity = [NSString stringWithFormat:@"%@%@", DiaryTypeStrPhoto, DiaryTypeStrAudio];
            cell = [tableView dequeueReusableCellWithIdentifier:identity];
            if (!cell){
             cell = [[AuPhotoDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
                [cell setDiaryType:kDiaryPhotoAudioType];
            }
            
        }
        else
        {
    
            NSArray *photoPaths = diary.filePaths1;
            if ([photoPaths count] > 1) {
                identity = DiaryTypeStrPhoto_More;
                cell = [tableView dequeueReusableCellWithIdentifier:identity];
                if (!cell)
                    cell = [[PhotoMoreDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
                  [cell setDiaryType:kdiaryPhotoMoreType];
            }else{
                identity = DiaryTypeStrPhoto_Single;
                cell = [tableView dequeueReusableCellWithIdentifier:identity];
                if (!cell)
                    cell = [[PhotoSingleDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
                  [cell setDiaryType:kDiaryPhotoType];
            }
          
            
        }
    }else if ([type isEqualToString:DiaryTypeStrText]){
        identity = DiaryTypeStrText;
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell)
        {
            cell = [[TextDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [(TextDiaryCell *)cell setDelegate:self];
            [cell setDiaryType:kDiaryTextType];
        }
    
    } else {
        identity = @"DiaryCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[DiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [cell setDiaryType:kDiaryType];
        }

    };
    [cell setIndexPath:indexPath];
    [cell setDiary:diary];
    [cell buildCellViewWithIndexRow:indexPath.row abbreviated:(selectedPath == nil || [indexPath compare:selectedPath] != NSOrderedSame)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor: [UIColor clearColor]];
    if ( [indexPath row] == [[[DiaryModel sharedDiaryModel] diaries] count]-1 || [indexPath row] == [[[DiaryModel sharedDiaryModel] diaries] count]-2 ) {
        [cell setControlCanHidden:NO];
    }else{
        [cell setControlCanHidden:YES];
    }
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            return 64;
        }else{
            if (show) {
                return 32;
 
            }else{
                return 0;

            }
        }
        
    }else if (indexPath.section == 2)
    {
        return 64;
    }
    
   // DiaryModel *diaryModel = [DiaryModel sharedDiaryModel];
    if (selectedPath != nil && [selectedPath compare:indexPath] == NSOrderedSame)
        return [DiaryCell heightForDiary:[[[DiaryModel sharedDiaryModel] diaries ]objectAtIndex:indexPath.row] abbreviated:NO];
    else return [DiaryCell heightForDiary:[[[DiaryModel sharedDiaryModel] diaries] objectAtIndex:indexPath.row] abbreviated:YES];
}


- (void)foldOrUnfold
{
    
    [self reloadDiaryTable];
}

- (void)reloadDiaryTable
{
    [[DiaryModel sharedDiaryModel] reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 1)] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)tableView:(UITableView *)parent didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NSArray *reloadArray;
    BOOL expand = NO;
    
    //if (indexPath.row > [[DiaryModel sharedDiaryModel] diaryNumFiltered:DIARY_FILTER_ALL]+1) return;
    if(indexPath.row > [[[DiaryModel sharedDiaryModel] diaries] count]+1)
    if ((selectedPath == nil || ![[[[[DiaryModel sharedDiaryModel] diaries] objectAtIndex:indexPath.row] type1Str] isEqualToString:DiaryTypeStrText]) && ![[[[[DiaryModel sharedDiaryModel] diaries] objectAtIndex:indexPath.row] type1Str] isEqualToString:DiaryTypeStrText]) return;
    if (selectedPath != nil && [selectedPath compare:indexPath] == NSOrderedSame)
    {
        reloadArray = [NSArray arrayWithObject:indexPath];
        selectedPath = nil;
    }
    else
    {
        reloadArray = [NSArray arrayWithObjects:indexPath, selectedPath, nil];
        selectedPath = indexPath;
        expand = [[[[[DiaryModel sharedDiaryModel] diaries
                    ]objectAtIndex:indexPath.row] type1Str] isEqualToString:DiaryTypeStrText];
    }
    
    [self.tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    if (expand) [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}

- (void)deleteDiary:(NSNotification *)notification
{
     Diary *diary = [notification object];
    if (![[DiaryModel sharedDiaryModel] deleteDiary:diary])
    {
        
        [ErrorLog errorLog:@"Delete diary failed!" fromFile:@"DiaryViewController.m" error:nil];
        NSLog(@"Delete diary failed!");
    }else{
        [CustomNotiViewController showNotiWithTitle:@"删除成功" withTypeStyle:kNotiTypeStyleRight];
        [self reloadDiaries];
    }
    
}

- (void)deletBtnShowed:(NSNotification *)notification
{
    _activeCell  = [notification object];
}

- (void)reloadDiaries
{
    [self performSelectorOnMainThread:@selector(reloadDiaries_) withObject:nil waitUntilDone:YES];
}

- (void)reloadDiaries_
{
    //    [diaryTable reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)] withRowAnimation:UITableViewRowAnimationAutomatic];

}

- (void)tapWithPoint:(CGPoint)pos
{
    if (_activeCell) {
        CGRect frame1 = ((DiaryCell *)_activeCell).delScrollView.frame;
        CGRect frame2 = ((DiaryCell *)_activeCell).delBtn.frame;
        frame1.origin.x  += 80;
        frame2.origin.x  += 80;
        frame1.origin.y  += _activeCell.frame.origin.y-self.tableView.contentOffset.y ;
        frame2.origin.y  += _activeCell.frame.origin.y-self.tableView.contentOffset.y;
        if ((!CGRectContainsPoint(frame1, pos))&&(!CGRectContainsPoint(frame2, pos))) {
            [((DiaryCell *)_activeCell) delBtnReset];
            _activeCell = nil;
        }
    }

}



- (void)addDiary
{
    [[DiaryModel sharedDiaryModel] reloadData];
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSArray *insertIndexPath = [NSArray arrayWithObjects:indexPath, nil];
    [self.tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
}



@end
