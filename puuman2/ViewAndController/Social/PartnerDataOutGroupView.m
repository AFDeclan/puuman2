//
//  PartnerDataOutGroupView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataOutGroupView.h"
#import "InviteGroupCell.h"
#import "ColorsAndFonts.h"
#import "Friend.h"

@implementation PartnerDataOutGroupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dataArr = [[NSArray alloc] init];
        
    }
    return self;
}

- (void)loadViewInfo
{
    dataArr = [[Friend sharedInstance] invitedGroup];
    if (inviteGroupsTable) {
        [inviteGroupsTable removeFromSuperview];
        inviteGroupsTable = nil;
    }
    inviteGroupsTable = [[UITableView alloc] initWithFrame:CGRectMake(128, 0, 608, 688)];
    [inviteGroupsTable setDelegate:self];
    [inviteGroupsTable setDataSource:self];
    [inviteGroupsTable setSeparatorColor:[UIColor clearColor]];
    [inviteGroupsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [inviteGroupsTable setShowsHorizontalScrollIndicator:NO];
    [inviteGroupsTable setShowsVerticalScrollIndicator:NO];
    [self addSubview:inviteGroupsTable];
    [inviteGroupsTable reloadData];
   
}

- (void)setVerticalFrame
{
    [inviteGroupsTable setFrame:CGRectMake(0, 0, 608, 944)];
}

- (void)setHorizontalFrame
{
    [inviteGroupsTable setFrame:CGRectMake(128, 0, 608, 688)];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count]+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
       static NSString  *identity = @"HeadInviteCell";
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        static NSString  *identity = @"inviteCell";
        InviteGroupCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[InviteGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        [cell buildCellWithGroup:[dataArr objectAtIndex:[indexPath row]-1]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:PMColor5];
        return cell;
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 64;
    }else{
        return 200;
    }
}






@end
