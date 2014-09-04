//
//  BasicInfoView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BasicInfoView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "MemberCache.h"
#import "UserInfo.h"
#import "BabyData.h"
#import "NSDate+Compute.h"
#import "MainTabBarController.h"

@implementation BasicInfoView

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 304, 56)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        hasInfoView = NO;
        tapped = NO;
        _isTopic = NO;
        _uid = 0;
        [[Friend sharedInstance] removeDelegateObject:self];
        [[Friend sharedInstance] addDelegateObject:self];

        portrait =[[AFImageView alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
        [portrait setBackgroundColor:[UIColor blackColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        [self addSubview:portrait];
        info_name = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 0)];
        [info_name setTextAlignment:NSTextAlignmentCenter];
        [info_name setTextColor:PMColor2];
        [info_name setFont:PMFont2];
        [info_name setBackgroundColor:[UIColor clearColor]];
        [self addSubview:info_name];
        
        info_relate = [[UILabel alloc] initWithFrame:CGRectMake(56, 36, 96, 12)];
        [info_relate setTextColor:PMColor3];
        [info_relate setFont:PMFont3];
        [info_relate setBackgroundColor:[UIColor clearColor]];
        [self addSubview:info_relate];

        icon_sex = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        [self addSubview:icon_sex];
        
        info_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [info_btn setBackgroundColor:[UIColor clearColor]];
        [info_btn addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:info_btn];
        

    }
    return self;
}
- (void)setInfoWithName:(NSString *)name andPortrailPath:(NSString*)path andRelate:(NSString *)relate andIsBoy:(BOOL)isBoy
{
    [portrait getImage:path defaultImage:@"pic_default_topic.png"];
    [info_relate setText:relate];
    [info_name setText:name];
    [info_name adjustSize];
    if (isBoy) {
        [icon_sex setImage:[UIImage imageNamed:@"icon_male_topic.png"]];
    }else{
        [icon_sex setImage:[UIImage imageNamed:@"icon_female_topic.png"]];
    }
    
    SetViewLeftUp(icon_sex, ViewX(info_name)+ViewWidth(info_name)+4, ViewY(info_name));
    
}

- (void)setInfoWithUid:(NSInteger)uid andIsTopic:(BOOL)isTopic
{
    _isTopic = isTopic;
    _uid = uid;
    Member  *_member = [[MemberCache sharedInstance] getMemberWithUID:uid];
    if (_member) {
        if (![_member belongsTo:[UserInfo sharedUserInfo].UID]&&[[[UserInfo sharedUserInfo] babyInfo] WhetherBirth] &&[[_member babyInfo] WhetherBirth]) {
            [self setInfoWithName:[_member babyInfo].Nickname andPortrailPath:[_member babyInfo].PortraitUrl andRelate:[[[[UserInfo sharedUserInfo] babyInfo] Birthday] relateFromDate:[_member babyInfo].Birthday andSex:[_member babyInfo].Gender] andIsBoy:[_member babyInfo].Gender];
            
        }else{
            [self setInfoWithName:[_member babyInfo].Nickname andPortrailPath:[_member babyInfo].PortraitUrl andRelate:@"" andIsBoy:[_member babyInfo].Gender];
            
        }
    }

}

//Member数据下载成功
- (void)memberDownloaded:(Member *)member
{
    
    if (![member belongsTo:_uid]) {
        
        if (!hasInfoView && _isTopic) {
            [self showRecommendViewWithMember:member];
        }else{
            tapped = NO;
        }
        
    }else{
        
        tapped = NO;
        if (![member belongsTo:[UserInfo sharedUserInfo].UID]&&[[[UserInfo sharedUserInfo] babyInfo] WhetherBirth] && [[member babyInfo] WhetherBirth]) {
            [self setInfoWithName:[member babyInfo].Nickname andPortrailPath:[member babyInfo].PortraitUrl andRelate:[[[[UserInfo sharedUserInfo] babyInfo] Birthday] relateFromDate:[member babyInfo].Birthday andSex:[member babyInfo].Gender] andIsBoy:[member babyInfo].Gender];
            
        }else{
            [self setInfoWithName:[member babyInfo].Nickname andPortrailPath:[member babyInfo].PortraitUrl andRelate:@"" andIsBoy:[member babyInfo].Gender];
            
        }
    }
}


- (void)tapped
{
    tapped = YES;
    Member *member = [[MemberCache sharedInstance] getMemberWithUID:[UserInfo sharedUserInfo].UID];
    if (member) {
        [self memberDownloaded:member];
    }

}


//Member数据下载失败
- (void)memberDownloadFailed
{
    
}


- (void)showRecommendViewWithMember:(Member *)member
{
    if (tapped == YES) {
        PostNotification(Noti_HiddenCommentKeyBoard, nil);

        RecommendPartnerViewController  *recommend = [[RecommendPartnerViewController alloc] initWithNibName:nil bundle:nil];
        [recommend setDelegate:self];
        [recommend setControlBtnType:kOnlyCloseButton];
        [recommend setRecommend:NO];
        [recommend setTitle:@"宝宝详情" withIcon:nil];
        [recommend buildWithTheUid:_uid andUserInfo:member];
        [[MainTabBarController sharedMainViewController].view addSubview:recommend.view];
        [recommend show];
        hasInfoView = YES;
        tapped = NO;
    }
}

- (void)popViewfinished
{
    hasInfoView = NO;
    //PostNotification(Noti_RefreshTopicTable, nil);
    //[[Forum sharedInstance] addDelegateObject:self];
}

@end
