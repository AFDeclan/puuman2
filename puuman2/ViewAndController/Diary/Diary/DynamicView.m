//
//  DynamicView.m
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DynamicView.h"
#import "ColorsAndFonts.h"
//#import "CustomAlertView.h"
#import "UserInfo.h"
#import "DiaryShowCell.h"
#import "DiaryModel.h"

@implementation DynamicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    diaryArray = [[DiaryModel sharedDiaryModel] diaryInfoRelateArraywithFilter:DIARY_FILTER_ALL];
  
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 208, 16)];
    [titleLabel setFont:PMFont2];
    [titleLabel setTextColor:PMColor6];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    NSString *nickName =  [[UserInfo sharedUserInfo].meta  valueForKey:@"uMeta_nickName"];
    NSString *nameStr;
    if (nickName) {
        if ([[UserInfo sharedUserInfo] identity] == Mother) {
            nameStr = [NSString stringWithFormat:@"%@爸",nickName];
            
        }else
        {
        
            nameStr = [NSString stringWithFormat:@"%@妈",nickName];
            
        }
        
    }else{
        if ([[UserInfo sharedUserInfo] identity] == Mother) {
             nameStr = @"爸爸";
        }else
        {
           
            nameStr = @"妈妈";
        }
        
    }
    [titleLabel setText:[NSString stringWithFormat:@"%@的最新动态",nameStr]];
    [self addSubview:titleLabel];
    
    

   
        diaryTable = [[UITableView alloc] initWithFrame:CGRectMake(16, 16, 208, 194)];
        [diaryTable setShowsHorizontalScrollIndicator:NO];
        [diaryTable setShowsVerticalScrollIndicator:NO];
        [diaryTable setBackgroundColor:[UIColor clearColor]];
        [diaryTable setDelegate:self];
        [diaryTable setDataSource:self];
        [diaryTable setScrollEnabled:NO];
        [diaryTable setExclusiveTouch:NO];
        [diaryTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self addSubview:diaryTable];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [diaryArray count]>0?[diaryArray count]:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([diaryArray count]>0) {
        static  NSString *diaryCellIdentifier = @"DiaryShowCell";
        DiaryShowCell *cell = [tableView dequeueReusableCellWithIdentifier:diaryCellIdentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:diaryCellIdentifier owner:self options:nil] lastObject];
        }
        
        [cell setDiaryInfo:[diaryArray objectAtIndex:[indexPath row]]];
        [cell buildCellViewWithIndexRow:indexPath.row];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 208, 180)];
        [cell addSubview:label];
        [label setTextColor:PMColor2];
        [label setFont:PMFont2];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:@"暂无记录"];
        [label setBackgroundColor:[UIColor clearColor]];
        [cell  setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([diaryArray count] >0) {
         return 64;
    }else{
         return 183;
    }
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
