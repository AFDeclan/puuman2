//
//  RankView.m
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "RankView.h"
#import "ShopViewController.h"
#import "ShopModel.h"
#import "AFButton.h"
#import "ExpandableButton.h"

const CGFloat rowHeight = 32;

static NSString *sortTableCellIdentify = @"SortTableCell";
static NSString *specialSortTableCellIdentify = @"SpecialSortTableCell";    //显示...的cell

@implementation RankView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [MyNotiCenter addObserver:self selector:@selector(sortTableReload) name:Noti_ReloadRankView object:nil];
    }
    return self;
}
- (void)initialization
{
    sortTable = [[UITableView alloc] initWithFrame:CGRectMake(0,48,self.frame.size.width,self.frame.size.height-48)];
    [sortTable setBackgroundColor:PMColor5];
    [self addSubview:sortTable];
    [self setBackgroundColor:PMColor4];
    sortTable.dataSource = self;
    sortTable.delegate = self;
    [sortTable setBackgroundColor:[UIColor clearColor]];
    [sortTable setSeparatorColor:[UIColor clearColor]];
    [sortTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}


- (void)sortTableReload
{
    _sectionState = [[NSMutableDictionary alloc] init];
    [sortTable reloadData];
}
- (void)sortTableUpdate
{
    [sortTable reloadData];
}
-(void)setVerticalFrame
{
    
    [sortTable setFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
}
-(void)setHorizontalFrame
{
    [sortTable setFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
}

#pragma mark - sort table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[ShopModel sharedInstance] filterKeys] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *keys = [[ShopModel sharedInstance] filterKeys];
    if (keys == nil || section >= [keys count]) return nil;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, rowHeight)];
    ExpandableButton *btn = [[ExpandableButton alloc] init];
    [btn setIsExpand:[self sectionUnfolded:section]];
    btn.tag = section;
    btn.frame = headerView.frame;
    [btn setTitle:[keys objectAtIndex:section]];
    [btn addTarget:self action:@selector(sectionHeaderTapped:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *values = [[ShopModel sharedInstance] filterValuesForKeyAtIndex:section];
    if (![self sectionUnfolded:section])
    {
        return MIN([values count]+1, 5);
    }
    return [values count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *values = [[ShopModel sharedInstance] filterValuesForKeyAtIndex:indexPath.section];
    if (indexPath.row > [values count]) return nil;
    BOOL special = [self cellIsSpecial:indexPath];
    NSString *identify = special ? specialSortTableCellIdentify : sortTableCellIdentify;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.contentView.frame = CGRectMake(0, 0, self.frame.size.width, rowHeight);
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sortTable.frame.size.width, 1)];
        [line setBackgroundColor:PMColor3];
        [line setAlpha:0.5];
        [cell addSubview:line];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, self.frame.size.width-64, rowHeight)];
        label.font = PMFont2;
        label.textColor = PMColor2;
        [label setBackgroundColor:[UIColor clearColor]];
        label.textAlignment = UITextAlignmentLeft;
        label.tag = 10;
        [cell.contentView addSubview:label];
        cell.userInteractionEnabled = YES;
        AFButton *btn = [AFButton buttonWithType:UIButtonTypeCustom];
        btn.frame = cell.contentView.frame;
        btn.tag = 11;
        [btn addTarget:self action:@selector(cellTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
        UIImageView *selectFlag =[[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 8, 8)];
        [selectFlag setImage:[UIImage imageNamed:@"icon_check_shop.png"]];
        selectFlag.tag = 12;
        [cell.contentView addSubview:selectFlag];
    }
     UIView *view = [cell viewWithTag:12];
    if ([[ShopModel sharedInstance] selectedValueAtIndex:indexPath.row ForKeyAtIndex:indexPath.section])
    {
        [view setAlpha:1];
    }
    else
    {
        [view setAlpha:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    NSInteger index = indexPath.row;
    if (index == 0) label.text = @"全部";
    else if (special) label.text = @"...";
    else label.text = [values objectAtIndex:index-1];
    AFButton *btn = (AFButton *)[cell viewWithTag:11];
    btn.indexPath = indexPath;
    [cell setBackgroundColor:PMColor5];
    return cell;
}

- (void)cellTapped:(AFButton *)sender
{
    NSIndexPath *indexPath = sender.indexPath;
    if ([self cellIsSpecial:indexPath])
    {
        [self setSection:indexPath.section unfolded:YES];
        [sortTable reloadData];
        return;
    }
    ShopModel *model = [ShopModel sharedInstance];
    NSArray *oldKeys = [model filterKeys];
    
    [model setFilterValueIndex:indexPath.row forKeyIndex:indexPath.section];
    NSArray *newKeys = [model filterKeys];
    
    if ([oldKeys count] == 0) oldKeys = nil;
    if ([newKeys count] == 0) newKeys = nil;
       if (oldKeys.count == newKeys.count)
    {
        NSIndexSet *allSectionSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [[[ShopModel sharedInstance] filterKeys] count])];
        [sortTable reloadSections:allSectionSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else [sortTable reloadData];
    PostNotification(Noti_ReloadShopMall, nil);
}

- (void)sectionHeaderTapped:(ExpandableButton *)sender
{
    [self setSection:sender.tag unfolded:![self sectionUnfolded:sender.tag]];
    [sortTable reloadData];
}

- (BOOL)cellIsSpecial:(NSIndexPath *)indexPath
{
    //是否是"..."Cell
    if ([self sectionUnfolded:indexPath.section]) return NO;
    NSArray *values = [[ShopModel sharedInstance] filterValuesForKeyAtIndex:indexPath.section];
    if (values.count <= 4) return NO;
    return indexPath.row == 4;
}

- (BOOL)sectionUnfolded:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%@", [[ShopModel sharedInstance].filterKeys objectAtIndex:section]];
    return [_sectionState valueForKey:key] != nil;
}

- (void)setSection:(NSInteger)section unfolded:(BOOL)unfolded
{
    if (!_sectionState) _sectionState = [[NSMutableDictionary alloc] init];
    NSString *key = [NSString stringWithFormat:@"%@", [[ShopModel sharedInstance].filterKeys objectAtIndex:section]];
    if (unfolded) {
        [_sectionState setValue:@"Unfolded" forKey:key];
    }
    else {
        [_sectionState setValue:nil forKey:key];
    }
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
