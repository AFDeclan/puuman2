//
//  FigureHeaderCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "FigureHeaderCell.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"
#import "NSDate+Compute.h"
#import "BabyData.h"


@implementation FigureHeaderCell
@synthesize recommend = _recommend;
@synthesize member = _member;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [MyNotiCenter addObserver:self selector:@selector(showManagerMenu:) name:Noti_manangingPartnerData object:nil];
        portrait  =[[AFImageView alloc] initWithFrame:CGRectMake(28, 16, 40, 40)];
        [portrait setBackgroundColor:[UIColor clearColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        
        [self.contentView addSubview:portrait];
        info_compare = [[UILabel alloc] initWithFrame:CGRectMake(0, 88, 96, 16)];
        [info_compare setTextAlignment:NSTextAlignmentCenter];
        [info_compare setTextColor:PMColor2];
        [info_compare setFont:PMFont3];
        [info_compare setBackgroundColor:[UIColor clearColor]];
        [self.contentView  addSubview:info_compare];
        name_sex = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 60, 96, 16)];
        [name_sex setEnabled:NO];
        [self.contentView  addSubview:name_sex];
       
        recommendView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [recommendView setBackgroundColor:[UIColor clearColor]];
        [portrait addSubview:recommendView];
        
        UIImageView *bg_recommend = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [bg_recommend setBackgroundColor:[UIColor blackColor]];
        bg_recommend.layer.cornerRadius = 20;
        bg_recommend.layer.masksToBounds = YES;
        bg_recommend.layer.shadowRadius =0.1;
        [bg_recommend setAlpha:0.3];
        [recommendView addSubview:bg_recommend];
        
//        UILabel *label_recommend= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        [label_recommend setTextAlignment:NSTextAlignmentCenter];
//        [label_recommend setTextColor:[UIColor whiteColor]];
//        [label_recommend setFont:PMFont3];
//        [label_recommend setBackgroundColor:[UIColor clearColor]];
//        [label_recommend setText:@"推荐"];
//        [recommendView  addSubview:label_recommend];

        manageView = [[UIView alloc] initWithFrame:CGRectMake(28, 16, 40, 40)];
        [self.contentView addSubview:manageView];
        
        UIImageView *quitImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [quitImgView setBackgroundColor:[UIColor blackColor]];
        [quitImgView setAlpha:0.3];
        quitImgView.layer.cornerRadius = 20;
        [manageView addSubview:quitImgView];
        
        UILabel *label_manageStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [label_manageStatus setTextAlignment:NSTextAlignmentCenter];
        [label_manageStatus setTextColor:[UIColor whiteColor]];
        [label_manageStatus setFont:PMFont2];
        [label_manageStatus setBackgroundColor:[UIColor clearColor]];
        [label_manageStatus setText:@"退出"];
        [manageView  addSubview:label_manageStatus];
        
        manageBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, 6, 60, 60)];
        [manageBtn setBackgroundColor:[UIColor clearColor]];
        [manageBtn addTarget:self action:@selector(managed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:manageBtn];
        [manageBtn setAdjustsImageWhenDisabled:NO];
    }
    return self;
}

- (void)managed
{
    if (_member.BID == [UserInfo sharedUserInfo].BID) {
        [_delegate quit];
        [manageBtn setEnabled:NO];

    }else{
        [_delegate showPartnerWithInfo:_member];
        [manageBtn setEnabled:YES];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommend:(BOOL)recommend
{
//    _recommend = recommend;
//    if (recommend) {
//        [recommendView setAlpha:1];
//    }else{
//        [recommendView setAlpha:0];
//    }
}

- (void)setMember:(Member *)member
{
    [manageView setAlpha:0];
    _member = member;
    [portrait getImage:[member babyInfo].PortraitUrl defaultImage:@""];
    if (_member.BID != [UserInfo sharedUserInfo].BID&&[[member babyInfo] WhetherBirth]&&[[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        info_compare.text =[[[[UserInfo sharedUserInfo] babyInfo] Birthday] compareFromDate:[[member babyInfo] Birthday]];
    }
    [name_sex.title  setText:[member babyInfo].Nickname];

    if ([[member babyInfo] WhetherBirth]) {
        if ([[member babyInfo] Gender]) {
            [name_sex setIconImg:[UIImage imageNamed:@"icon_male_topic.png"]];
        }else{
            [name_sex setIconImg:[UIImage imageNamed:@"icon_female_topic.png"]];
        }
    }else{
        [name_sex setIconImg:nil];

    }
    if (_member.BID == [UserInfo sharedUserInfo].BID) {
        [manageBtn setAlpha:0];
    }else{
        [manageBtn setAlpha:1];

    }
   
    [name_sex adjustLayout];

}


- (void)showManagerMenu:(NSNotification *)notification
{
    
    [manageBtn setEnabled:YES];
    if (_member.BID == [UserInfo sharedUserInfo].BID) {
        [UIView animateWithDuration:0.3 animations:^{
            if ([[notification object] boolValue]) {
                [manageView setAlpha:1];
                [manageBtn setAlpha:1];
            }else{
                [manageView setAlpha:0];
                [manageBtn setAlpha:0];

            }
        }];
    }else{
        if ([[notification object] boolValue]) {
            [manageView setAlpha:0];
            [manageBtn setAlpha:0];
        }else{
            [manageView setAlpha:0];
            [manageBtn setAlpha:1];
            
        }
    }
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
