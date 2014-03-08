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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
//        case 1:
//            return [[DiaryModel sharedDiaryModel] diaryNumFiltered:DIARY_FILTER_ALL];
//        case 2:
//            return 1;
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
                [cell addSubview:imgView];
            }
            [cell setBackgroundColor:[UIColor clearColor]];
            return cell;
        }else{
            TaskCell *cell =[TaskCell sharedTaskCell];
            cell.delegate =self;
            [cell setBackgroundColor:[UIColor clearColor]];
            return cell;
        }
        
    }

    return nil;
    
    
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
        
    }
    return 0;
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
@end
