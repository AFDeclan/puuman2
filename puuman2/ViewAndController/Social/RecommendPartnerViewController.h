//
//  RecommendPartnerViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"
#import "Member.h"
#import "Friend.h"
#import "AFImageView.h"
#import "AFTextImgButton.h"


@interface RecommendPartnerViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate,FriendDelegate>
{
    UITableView *recommentTable;
    ColorButton *changeBtn;
    ColorButton *inviteBtn;
    Member *_memberInfo;
    Member *_userInfo;
    AFImageView *portrait;
    AFTextImgButton *sex_name;
    UILabel *info_my;
}

@property(nonatomic,assign)BOOL recommend;
- (void)buildWithTheUid:(NSInteger)uid andUserInfo:(Member *)userInfo;
@end

