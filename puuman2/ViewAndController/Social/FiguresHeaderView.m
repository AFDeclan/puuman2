//
//  FiguresHeaderView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "FiguresHeaderView.h"
#import "ColorsAndFonts.h"
#import "FigureHeaderCell.h"
#import "RecommendPartnerViewController.h"
#import "MainTabBarController.h"
#import "ActionForUpload.h"
#import "UserInfo.h"



@implementation FiguresHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [MyNotiCenter addObserver:self selector:@selector(showManagerMenu) name:Noti_manangePartnerData object:nil];
        [MyNotiCenter addObserver:self selector:@selector(hiddenManagerMenu) name:Noti_manangedPartnerData object:nil];
        
        icon_head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        [icon_head setImage:[UIImage imageNamed:@"block_name_fri.png"]];
        [self addSubview:icon_head];
        [[Friend sharedInstance] addDelegateObject:self];
        
        info_title = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        [info_title setBackgroundColor:[UIColor clearColor]];
        [info_title setTextColor:[UIColor whiteColor]];
        [info_title setFont:PMFont2];
        [info_title setTextAlignment:NSTextAlignmentCenter];
        [info_title setText:@"三月宝宝妈妈团"];
        [icon_head addSubview:info_title];
      
        
        modifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 96, 112)];
        [modifyBtn addSubview:bgView];
        [bgView setBackgroundColor:[UIColor blackColor]];
        [bgView setAlpha:0.5];
        
        UIImageView *icon_img = [[ UIImageView alloc] initWithFrame:CGRectMake(24, 36, 48, 48)];
        [icon_img setImage:[UIImage imageNamed:@"circle_fri.png"]];
        [bgView addSubview:icon_img];
        
       UILabel *label_manageStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        [label_manageStatus setTextAlignment:NSTextAlignmentCenter];
        [label_manageStatus setTextColor:[UIColor whiteColor]];
        [label_manageStatus setFont:PMFont2];
        [label_manageStatus setBackgroundColor:[UIColor clearColor]];
        [label_manageStatus setText:@"修改"];
        [icon_img  addSubview:label_manageStatus];
        
        [modifyBtn setAlpha:0];

        noti_label = [[AnimateShowLabel alloc] initWithFrame:CGRectMake(320, 0, 276, 48)];
        [noti_label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:noti_label];
        
        

        figuresColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 48, 576, 120)];
        [figuresColumnView setBackgroundColor:[UIColor clearColor]];
        [figuresColumnView setViewDelegate:self];
        [figuresColumnView setViewDataSource:self];
        [figuresColumnView setPagingEnabled:NO];
        [figuresColumnView setScrollEnabled:YES];
        [self addSubview:figuresColumnView];
  

    }
    return self;
}

- (void)reloadWithGroupInfo:(Group *)group
{
    myGroup = group;
    [figuresColumnView reloadData];
    
}

- (void)showManagerMenu
{
    canDeleteMember = YES;
}

- (void)hiddenManagerMenu
{
    canDeleteMember = NO;
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
 
    if (canDeleteMember) {
        
         if (((Member *)[myGroup.GMember objectAtIndex:index]).BID != [UserInfo sharedUserInfo].BID) {
             [[myGroup actionForRemove:index] upload];
         }else{
             [[myGroup actionForQuit] upload];
         }
    
    }else{
        if (((Member *)[myGroup.GMember objectAtIndex:index]).BID != [UserInfo sharedUserInfo].BID) {
            FigureHeaderCell *cell = (FigureHeaderCell *)[columnView cellForIndex:index];
            RecommendPartnerViewController  *recommend = [[RecommendPartnerViewController alloc] initWithNibName:nil bundle:nil];
            [recommend setControlBtnType:kOnlyCloseButton];
            [recommend setRecommend:cell.recommend];
            if (cell.recommend) {
                [recommend setTitle:@"推荐伙伴" withIcon:nil];
            }else{
                [recommend setTitle:@"宝宝详情" withIcon:nil];
            }
            [[MainTabBarController sharedMainViewController].view addSubview:recommend.view];
            [recommend show];

        }
    }
 
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 96;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [myGroup.GMember count]>6?6 : [myGroup.GMember count];
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"FigursHeader";
    FigureHeaderCell *cell = (FigureHeaderCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[FigureHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
       
    }
    [cell setRecommend:NO];
    [cell buildWithMemberInfo:[myGroup.GMember objectAtIndex:index]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (void)setVerticalFrame
{
    [noti_label setFrame:CGRectMake(320, 0, 164, 48)];
    [noti_label animateStop];
    [noti_label setTitleWithTitleText:@"三天前，天天邀请了w 入团" andTitleColor:PMColor3 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [noti_label animateStart];
}

- (void)setHorizontalFrame
{
    [noti_label setFrame:CGRectMake(320, 0, 276, 48)];
    [noti_label animateStop];
    [noti_label setTitleWithTitleText:@"三天前，天天邀请了w 入团" andTitleColor:PMColor3 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [noti_label animateStart];
}

//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action
{
    PostNotification(Noti_UpdateDiaryStateRefreshed, nil);
}
//Group Action 上传失败
- (void)actionUploadFailed:(ActionForUpload *)action
{

}


@end
