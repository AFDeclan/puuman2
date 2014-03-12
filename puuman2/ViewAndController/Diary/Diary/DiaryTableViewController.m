//
//  DiaryTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryTableViewController.h"
#import "DiaryModel.h"


@interface DiaryTableViewController ()

@end

@implementation DiaryTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [MyNotiCenter addObserver:self selector:@selector(reloadTable) name:Noti_ReloadDiaryTable object:nil];
        [MyNotiCenter addObserver:self selector:@selector(deleteDiary:) name:Noti_DeleteDiary object:nil];
        [MyNotiCenter addObserver:self selector:@selector(deletBtnShowed:) name:Noti_DelBtnShowed object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];

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
            return [[DiaryModel sharedDiaryModel] diaryNumFiltered:DIARY_FILTER_ALL];
        case 2:
            return 1;
        default:
            return 1;
            break;
    }
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
            TaskCell *cell =[TaskCell sharedTaskCell];
            cell.delegate =self;
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
    DiaryModel *diaryModel = [DiaryModel sharedDiaryModel];
    NSDictionary *diaryInfo = [diaryModel diaryInfoAtIndex:indexPath.row filtered:DIARY_FILTER_ALL];
    DiaryCell *cell;
    NSString *type = [diaryInfo valueForKey:kTypeName];
    NSString *type2 = [diaryInfo valueForKey:kType2Name];
    NSString *identity;
    if ([type isEqualToString:vType_Audio])
    {
        identity = vType_Audio;
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[AudioDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [cell setDiaryType:kDiaryAudioType];
        }
        
        
        
    }else if ([type isEqualToString:vType_Video])
    {
        identity = vType_Video;
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
          cell = [[VideoDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [cell setDiaryType:kDiaryVideoType];
        }
        
    }else if ([type isEqualToString:vType_Photo])
    {
        if ([type2 isEqualToString:vType_Audio])
        {
            identity = [NSString stringWithFormat:@"%@%@", vType_Photo, vType_Audio];
            cell = [tableView dequeueReusableCellWithIdentifier:identity];
            if (!cell){
             cell = [[AuPhotoDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
                [cell setDiaryType:kDiaryPhotoAudioType];
            }
            
        }
        else
        {
            NSString *photoPathsString = [diaryInfo objectForKey:kFilePathName];
            NSArray *photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
            if ([photoPaths count] > 1) {
                identity = vType_Photo_More;
                cell = [tableView dequeueReusableCellWithIdentifier:identity];
                if (!cell)
                    cell = [[PhotoMoreDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            }else{
                identity = vType_Photo_Single;
                cell = [tableView dequeueReusableCellWithIdentifier:identity];
                if (!cell)
                    cell = [[PhotoSingleDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            }
            [cell setDiaryType:kDiaryPhotoType];
            
        }
    }else if ([type isEqualToString:vType_Text]){
        identity = vType_Text;
        cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell)
        {
            cell = [[TextDiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            [(TextDiaryCell *)cell setDelegate:self];
            [cell setDiaryType:kDiaryTextType];
        }
    
    } else return nil;
    [cell setIndexPath:indexPath];
    [cell setDiaryInfo:diaryInfo];
    [cell buildCellViewWithIndexRow:indexPath.row abbreviated:(selectedPath == nil || [indexPath compare:selectedPath] != NSOrderedSame)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor: [UIColor clearColor]];
    
//    int rowMax = 0;
//    int rowMin = 0;
//    DiaryCell *rowMaxCell;
//    DiaryCell *rowMinCell;
//    NSArray *ce =  [self.tableView visibleCells];
//    for (UITableViewCell *ca in ce) {
//        if ([ca isKindOfClass:[DiaryCell class]]) {
//            DiaryCell  *c = (DiaryCell *)ca;
//            if (rowMin == 0) {
//                rowMin = c.indexPath.row;
//                rowMinCell = c;
//            }
//            if (rowMax == 0) {
//                rowMax = c.indexPath.row;
//                rowMaxCell = c;
//            }
//            if (c.indexPath.row >rowMax) {
//                rowMax = c.indexPath.row;
//                rowMaxCell = c;
//            }
//            
//            if (c.indexPath.row < rowMin) {
//                rowMin = c.indexPath.row;
//                rowMinCell = c;
//            }
//        }
//    }
//    if (indexPath.row >rowMax) {
//        if (rowMaxCell.frame.origin.y+rowMaxCell.frame.size.height< self.view.frame.size.height/2 ||rowMaxCell.frame.origin.y+rowMaxCell.frame.size.height>self.tableView.contentSize.height- self.tableView.frame.size.height/2 -64 )
//        {
//            [cell setDelBtnCanHidden:NO];
//        }else{
//            [cell setDelBtnCanHidden:YES];
//        }
//    }
//    if (indexPath.row <rowMin) {
//        
//        if (rowMinCell.frame.origin.y-cell.frame.size.height< self.view.frame.size.height/2 ||rowMinCell.frame.origin.y-cell.frame.size.height>self.tableView.contentSize.height- self.tableView.frame.size.height/2- 64)
//        {
//            [cell setDelBtnCanHidden:NO];
//        }else{
//            [cell setDelBtnCanHidden:YES];
//        }
//    }
//    if (indexPath.row == rowMin) {
//        
//        
//        if (rowMin == 0) {
//            UITableViewCell *preCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//            if (preCell.frame.origin.y+preCell.frame.size.height< self.tableView.frame.size.height/2 ||preCell.frame.origin.y+preCell.frame.size.height>self.tableView.contentSize.height- self.tableView.frame.size.height/2 -64)
//            {
//                [cell setDelBtnCanHidden:NO];
//            }else{
//                [cell setDelBtnCanHidden:YES];
//            }
//            
//            
//        }
//    }

        return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            return 64;
        }else{
            if ([TaskCell sharedTaskCell].taskFolded)
                return kTaskCellHeight_Folded;
            else return kTaskCellHeight_Unfolded;
            return 0;
        }
        
    }else if (indexPath.section == 2)
    {
        return 64;
    }
    
    DiaryModel *diaryModel = [DiaryModel sharedDiaryModel];
    if (selectedPath != nil && [selectedPath compare:indexPath] == NSOrderedSame)
        return [DiaryCell heightForDiary:[diaryModel diaryInfoAtIndex:indexPath.row filtered:DIARY_FILTER_ALL] abbreviated:NO];
    else return [DiaryCell heightForDiary:[diaryModel diaryInfoAtIndex:indexPath.row filtered:DIARY_FILTER_ALL] abbreviated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)foldOrUnfold
{
    [self reloadTable];
}

- (void)reloadTable
{
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)parent didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *reloadArray;
    BOOL expand = NO;
    
    if (indexPath.row > [[DiaryModel sharedDiaryModel] diaryNumFiltered:DIARY_FILTER_ALL]+1) return;
    
    if ((selectedPath == nil || ![[[[DiaryModel sharedDiaryModel] diaryInfoAtIndex:selectedPath.row filtered:DIARY_FILTER_ALL] valueForKey:kTypeName] isEqualToString:vType_Text]) && ![[[[DiaryModel sharedDiaryModel] diaryInfoAtIndex:indexPath.row filtered:DIARY_FILTER_ALL] valueForKey:kTypeName] isEqualToString:vType_Text]) return;
    if (selectedPath != nil && [selectedPath compare:indexPath] == NSOrderedSame)
    {
        reloadArray = [NSArray arrayWithObject:indexPath];
        selectedPath = nil;
    }
    else
    {
        reloadArray = [NSArray arrayWithObjects:indexPath, selectedPath, nil];
        selectedPath = indexPath;
        expand = [[[[DiaryModel sharedDiaryModel] diaryInfoAtIndex:indexPath.row filtered:DIARY_FILTER_ALL] valueForKey:kTypeName] isEqualToString:vType_Text];
    }
    
    [self.tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
    if (expand) [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}

- (void)deleteDiary:(NSNotification *)notification
{
    NSDictionary *diaryInfo = [notification object];
    if (![[DiaryModel sharedDiaryModel] deleteDiary:diaryInfo])
    {
        
        [ErrorLog errorLog:@"Delete diary failed!" fromFile:@"DiaryViewController.m" error:nil];
        NSLog(@"Delete diary failed!");
    }else [self reloadDiaries];
    
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
        frame1.origin.x += 80;
        frame2.origin.x += 80;
        frame1.origin.y  += _activeCell.frame.origin.y-self.tableView.contentOffset.y ;
        frame2.origin.y  += _activeCell.frame.origin.y-self.tableView.contentOffset.y;
        if ((!CGRectContainsPoint(frame1, pos))&&(!CGRectContainsPoint(frame2, pos))) {
            [((DiaryCell *)_activeCell) delBtnReset];
            _activeCell = nil;
        }
        
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [MyNotiCenter postNotificationName:Noti_DiaryCellVisible object:[NSNumber numberWithFloat:self.tableView.contentOffset.y]];
}

@end
