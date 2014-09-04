//
//  RecommendPartnerViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RecommendPartnerViewController.h"
#import "RecommentPartnerTableViewCell.h"
#import "MemberCache.h"
#import "BabyData.h"
#import "Group.h"
#import "ActionForUpload.h"
#import "UserInfo.h"

@interface RecommendPartnerViewController ()

@end

@implementation RecommendPartnerViewController
@synthesize recommend =_recommend;
@synthesize member = _member;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        [self initWithContent];
        [self initInfoView];
         [[Friend sharedInstance] addDelegateObject:self];
    }
    return self;
}

- (void)initWithContent
{

    recommentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 272, 576, 254)];
    [recommentTable setBackgroundColor:PMColor5];
    [recommentTable setDelegate:self];
    [recommentTable setDataSource:self];
    [recommentTable setSeparatorColor:[UIColor clearColor]];
    [recommentTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [recommentTable setShowsHorizontalScrollIndicator:NO];
    [recommentTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:recommentTable];
    
    changeBtn = [[AFColorButton alloc] init];
    [changeBtn.title setText:@"换一个"];
    //[changeBtn adjustLayout];
    [changeBtn setColorType:kColorButtonGrayColor];
    [changeBtn setDirectionType:kColorButtonLeftUp];
    [changeBtn resetColorButton];
    [changeBtn addTarget:self action:@selector(changed) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:changeBtn];
    
    inviteBtn = [[AFColorButton alloc] init];
    [inviteBtn.title setText:@"邀请"];
    //[inviteBtn adjustLayout];
    [inviteBtn setColorType:kColorButtonBlueColor];
    [inviteBtn addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:inviteBtn];
    [inviteBtn setAlpha:0];
    SetViewLeftUp(changeBtn, 592, 112);
    SetViewLeftUp(inviteBtn, 592, 152);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(432, 112, 2, 492)];
    [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_timeline_diary.png"]]];
    [_content addSubview:line];
    
   
    
}

- (void)initInfoView;
{
    portrait =[[AFImageView alloc] initWithFrame:CGRectMake(192, 112, 112, 112)];
    [portrait setBackgroundColor:[UIColor blackColor]];
    portrait.layer.cornerRadius = 56;
    portrait.layer.masksToBounds = YES;
    portrait.layer.shadowRadius =0.1;
    [_content addSubview:portrait];

    sex_name = [[AFTextImgButton alloc] initWithFrame:CGRectMake(192, 224, 112, 40)];
    [_content addSubview:sex_name];
    [sex_name.title setTextColor:PMColor6];
    [sex_name setIconSize:CGSizeMake(24, 24)];

    info_my = [[UILabel alloc] initWithFrame:CGRectMake(432, 240, 144, 32)];
    [info_my setTextColor:PMColor3];
    [info_my setFont:PMFont2];
    [info_my setTextAlignment:NSTextAlignmentCenter];
    [info_my setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:info_my];
    [info_my setText:[NSString stringWithFormat:@"比%@:",[[[UserInfo sharedUserInfo] babyInfo] Nickname]]];
    
    UIView *partLine = [[UIView alloc] initWithFrame:CGRectMake(432, 110, 2, 160)];
    [partLine setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
    [_content addSubview:partLine];
    
}

- (void)setMember:(Member *)member
{
    _userInfo = [[[Friend sharedInstance] myGroup] MyMember];
    _member = member;
    if (member.GID == 0 ) {
        [inviteBtn setAlpha:1];
        [inviteBtn setEnabled:YES];

    }else{
        [inviteBtn setAlpha:0];
    }
    [recommentTable reloadData];
    [sex_name.title setText:[member babyInfo].Nickname];
    
    if ([[member babyInfo] Gender]) {
        [sex_name setIconImg:[UIImage imageNamed:@"icon_male_baby.png"]];
    }else{
        [sex_name setIconImg:[UIImage imageNamed:@"icon_female_baby.png"]];
    }
    [sex_name adjustLayout];
    [portrait getImage:[[member babyInfo] PortraitUrl] defaultImage:@"pic_default_topic.png"];
    [recommentTable reloadData];
}


- (void)buildWithTheUid:(NSInteger)uid andUserInfo:(Member *)userInfo
{
    _userInfo = userInfo;
    
    Member *member = [[MemberCache sharedInstance] getMemberWithUID:uid];
    if (member) {
        [self memberDownloaded:member];
    }
   
}


//Member数据下载成功
- (void)memberDownloaded:(Member *)member
{
    
    _member = member;
    if (member.GID == 0 ) {
        [inviteBtn setAlpha:1];
    }else{
        [inviteBtn setAlpha:0];
    }
    [recommentTable reloadData];
    [sex_name.title setText:[member babyInfo].Nickname];

    if ([[member babyInfo] Gender]) {
        [sex_name setIconImg:[UIImage imageNamed:@"icon_male_baby.png"]];
    }else{
        [sex_name setIconImg:[UIImage imageNamed:@"icon_female_baby.png"]];
    }
    [sex_name adjustLayout];
    [portrait getImage:[[member babyInfo] PortraitUrl] defaultImage:@"pic_default_topic.png"];
     [recommentTable reloadData];
}

//Member数据下载失败
- (void)memberDownloadFailed
{
    
}


- (void)changed
{

}

- (void)invite
{
    [inviteBtn setEnabled:NO];
   // [[Friend sharedInstance] addDelegateObject:self];
    [[Friend sharedInstance]  getGroupData];
    Group *myGroup = [[Friend sharedInstance] myGroup];
    [[myGroup actionForInvite:_member.BID] upload];
    
}

//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action
{
    [inviteBtn setAlpha:0];
     //[[Friend sharedInstance] removeDelegateObject:self];
}
//Group Action 上传失败
- (void)actionUploadFailed:(ActionForUpload *)action
{
    [inviteBtn setEnabled:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString  *identity = @"recommentCell";
    RecommentPartnerTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell){
        cell = [[RecommentPartnerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        
    }
    if ([indexPath row]%2 == 1) {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else{
        [cell setBackgroundColor:PMColor5];
    }
    
    if ([indexPath row] == 0) {
        [cell buildWithData:_member andUserData:_userInfo andDataType:kPartnerBirthday];
        [cell setBackgroundColor:PMColor5];
    }else if([indexPath row] == 1) {
        [cell buildWithData:_member  andUserData:_userInfo  andDataType:kPartnerHeight];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else if([indexPath row]== 2){
        [cell buildWithData:_member andUserData:_userInfo  andDataType:kPartnerWeight];
        [cell setBackgroundColor:PMColor5];
    }
    
       
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
         return 96;
    }else{
        return 80;
    }
   
}



-(void)setRecommend:(BOOL)recommend
{
    _recommend = recommend;
    if (recommend) {
        [changeBtn setAlpha:1];
        [inviteBtn setDirectionType:kColorButtonLeftDown];
        [inviteBtn resetColorButton];
        [inviteBtn setAlpha:1];
         SetViewLeftUp(inviteBtn, 592, 152);
    }else{
        [changeBtn setAlpha:0];
        [inviteBtn setIconImg:[UIImage imageNamed:@"icon_invite_topic.png"]];
        [inviteBtn setIconSize:CGSizeMake(16, 16)];
        [inviteBtn adjustLayout];
        [inviteBtn setDirectionType:kColorButtonLeft];
        [inviteBtn resetColorButton];

        [inviteBtn setAlpha:1];
         SetViewLeftUp(inviteBtn, 592, 112);
    }
}


- (void)closeBtnPressed
{
    [[Friend sharedInstance] removeDelegateObject:self];
    [super closeBtnPressed];
    
}
@end
