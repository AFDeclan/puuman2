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
#import "Action.h"



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
      
        notiStr = @"";
        info_title = [[UITextField alloc] initWithFrame:CGRectMake(80, 16, 160, 16)];
        [info_title setBackgroundColor:[UIColor clearColor]];
        [info_title setTextColor:[UIColor whiteColor]];
        [info_title setFont:PMFont2];
        [info_title setTextAlignment:NSTextAlignmentCenter];
        [icon_head addSubview:info_title];
        [info_title setDelegate:self];
        [info_title setEnabled:NO];
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
        [MyNotiCenter addObserver:self selector:@selector(removeAllDelegate) name:Noti_RemoveFriendDelegate object:nil];
        
        modifyNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 160, 48)];
        [modifyNameBtn setBackgroundColor:[UIColor clearColor]];
        [modifyNameBtn addTarget:self action:@selector(showKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:modifyNameBtn];
        changed = NO;
       
    }
    return self;
}

- (void)showKeyBoard
{
    [info_title becomeFirstResponder];
}

- (void)removeAllDelegate
{
    
    [[Friend sharedInstance] removeDelegateObject:self];
}

- (void)reloadWithGroupInfo:(Group *)group
{
    PostNotification(Noti_RemoveFriendDelegate, nil);
     [[Friend sharedInstance] addDelegateObject:self];
    [info_title setEnabled:NO];
    canDeleteMember = NO;
    [info_title setEnabled:NO];
    [modifyNameBtn setEnabled:NO];
    [info_title resignFirstResponder];
     [info_title setBackgroundColor:[UIColor clearColor]];
    myGroup = group;
    if (figuresColumnView) {
        [figuresColumnView removeFromSuperview];
        figuresColumnView = nil;
    }
    [info_title setText:group.GName];
    oldName = group.GName;
    figuresColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 48, 576, 120)];
    [figuresColumnView setBackgroundColor:[UIColor clearColor]];
    [figuresColumnView setViewDelegate:self];
    [figuresColumnView setViewDataSource:self];
    [figuresColumnView setPagingEnabled:NO];
    [figuresColumnView setScrollEnabled:YES];
    [self addSubview:figuresColumnView];
    [figuresColumnView reloadData];
    if ([group GLatestAction]) {
        notiStr = [[group GLatestAction] AMeta];
    }
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
}

- (void)showManagerMenu
{
    [info_title setEnabled:YES];
    canDeleteMember = YES;
    [info_title setEnabled:YES];
    [modifyNameBtn setEnabled:YES];
    [info_title becomeFirstResponder];
    [info_title setBackgroundColor:PMColor3];
}

- (void)hiddenManagerMenu
{
    [info_title setEnabled:NO];
    canDeleteMember = NO;
    [info_title setEnabled:NO];
    [modifyNameBtn setEnabled:NO];
    [info_title resignFirstResponder];
    if (changed) {
        [[myGroup actionForRenameGroup:info_title.text] upload];
    }else{
        [info_title setText:oldName];
    }
    [info_title setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
 
    if (canDeleteMember) {
        
         if (((Member *)[myGroup.GMember objectAtIndex:index]).BID != [UserInfo sharedUserInfo].BID) {
             [[myGroup actionForRemove:((Member *)[myGroup.GMember objectAtIndex:index]).BID ] upload];
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
    [noti_label setTitleWithTitleText:notiStr andTitleColor:PMColor3 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [noti_label animateStart];
}

- (void)setHorizontalFrame
{
    [noti_label setFrame:CGRectMake(320, 0, 276, 48)];
    [noti_label animateStop];
    [noti_label setTitleWithTitleText:notiStr andTitleColor:PMColor3 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [noti_label animateStart];
}

//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action
{
    [noti_label animateStop];
    [noti_label setTitleWithTitleText:info_title.text andTitleColor:PMColor3 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [noti_label animateStart];
    PostNotification(Noti_RefreshInviteStatus, nil);
}
//Group Action 上传失败
- (void)actionUploadFailed:(ActionForUpload *)action
{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{


    
    if (range.length == 1)
    {
        if ([textField.text length]==1) {
            changed = NO;
        }else{
            NSString *name = [textField.text substringToIndex:[textField.text length]-1];
            if ([name isEqualToString:oldName]) {
               changed = NO;
            }else{
               changed = YES;
            }
            
        }
    }else{
        NSString *name = [textField.text stringByAppendingString:string];
        if ([name isEqualToString:oldName]) {
            changed = NO;
        }else{
           changed = YES;
        }
    }
    
    if (range.length == 0) {
        if ([textField.text length] >=10) {
            NSString *str = [textField.text substringToIndex:10];
            textField.text =str;
        }
    }
    return YES;
    
    
}
@end
