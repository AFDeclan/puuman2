//
//  PartnerOutGroupDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerOutGroupDataView.h"
#import "ColorsAndFonts.h"
#import "Friend.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "ActionForUpload.h"

@implementation PartnerOutGroupDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[Friend sharedInstance] addDelegateObject:self];
        dataArr = [[NSArray alloc] init];
        [self  loadViewInfo];

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
    inviteGroupsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 608, 944)];
    [inviteGroupsTable setDelegate:self];
    [inviteGroupsTable setDataSource:self];
    [inviteGroupsTable setSeparatorColor:[UIColor clearColor]];
    [inviteGroupsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [inviteGroupsTable setShowsHorizontalScrollIndicator:NO];
    [inviteGroupsTable setShowsVerticalScrollIndicator:NO];
    [self addSubview:inviteGroupsTable];
    [inviteGroupsTable reloadData];
    emptyNotiView = [[UIView alloc] initWithFrame:CGRectMake(192, 304, 224, 80)];
    [self addSubview:emptyNotiView];
    UIImageView  *icon_empty = [[UIImageView alloc] initWithFrame:CGRectMake(36, 0, 152, 40)];
    [icon_empty setImage:[UIImage imageNamed:@"pic_diary_blank.png"]];
    [emptyNotiView addSubview:icon_empty];
    UILabel *noti_empty = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 224, 40)];
    [noti_empty setFont:PMFont2];
    [noti_empty setTextColor:PMColor2];
    [noti_empty setTextAlignment:NSTextAlignmentCenter];
    [noti_empty setBackgroundColor:[UIColor clearColor]];
    [emptyNotiView addSubview:noti_empty];
    [noti_empty setText:@"您暂时还没有收到邀请哦~"];
    if ([dataArr count] == 0) {
        [emptyNotiView setAlpha:1];
    }else{
        [emptyNotiView setAlpha:0];
    }
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else {
        [self setHorizontalFrame];
    }
}

- (void)setVerticalFrame
{
    [inviteGroupsTable setFrame:CGRectMake(0, 0, 608, 944)];
    SetViewLeftUp(emptyNotiView, 192, 432);
}

- (void)setHorizontalFrame
{
    [inviteGroupsTable setFrame:CGRectMake(0, 0, 864, 688)];
    SetViewLeftUp(emptyNotiView, 320, 304);
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
        [cell setDelegate:self];
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

- (void)acceptInviteWithGroup:(Group *)group
{
    [[group actionForJoin] upload];

}

//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action
{
    PostNotification(Noti_RefreshInviteStatus, nil);
}

//Group Action 上传失败
- (void)actionUploadFailed:(ActionForUpload *)action
{
    
}


- (void)dealloc
{
    [[Friend sharedInstance] removeDelegateObject:self];
}
@end
