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
        
        bgHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 44)];
        [bgHeadView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_talk_fri.png"]]];
        [self addSubview:bgHeadView];
        
        icon_headDown = [[UIView alloc]initWithFrame:CGRectMake(0, 14, 864, 30)];
        [icon_headDown setBackgroundColor:PMColor6];
        [self addSubview:icon_headDown];
        
        icon_headUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 44)];
        [icon_headUp setBackgroundColor:PMColor6];
        [icon_headUp.layer setMasksToBounds:YES];
        [icon_headUp.layer setCornerRadius:16.0f];
        [self addSubview:icon_headUp];
      
        notiStr = @"";
        info_title = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [info_title setBackgroundColor:[UIColor clearColor]];
        [info_title setTextColor:[UIColor whiteColor]];
        [info_title setText:@"三月宝宝妈妈团"];
        [info_title setFont:PMFont1];
        [info_title setTextAlignment:NSTextAlignmentCenter];
        [icon_headUp addSubview:info_title];
        [info_title setDelegate:self];
        [info_title setEnabled:NO];

        changed = NO;
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
       
    }
    return self;
}



- (void)removeAllDelegate
{
    [[Friend sharedInstance] removeDelegateObject:self];
}

- (void)reloadWithGroupInfo:(Group *)group
{
     [[Friend sharedInstance] addDelegateObject:self];
    [info_title setEnabled:NO];
    canDeleteMember = NO;
    [info_title setEnabled:NO];
   
    [info_title resignFirstResponder];
     [info_title setBackgroundColor:[UIColor clearColor]];
    myGroup = group;
    if (figuresColumnView) {
        [figuresColumnView removeFromSuperview];
        figuresColumnView = nil;
    }
    [info_title setText:group.GName];
    oldName = group.GName;
    figuresColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 44, 576, 124)];
    [figuresColumnView setBackgroundColor:[UIColor greenColor]];
    [figuresColumnView setColumnViewDelegate:self];
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
    [info_title becomeFirstResponder];
    [info_title setBackgroundColor:PMColor3];
}

- (void)hiddenManagerMenu
{
    
    [info_title setEnabled:NO];
    canDeleteMember = NO;
    [info_title setEnabled:NO];
   
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
    [bgHeadView setFrame:CGRectMake(0, 0, 608, 44)];
    [icon_headDown setFrame:CGRectMake(0, 14, 608, 30)];
    [icon_headUp setFrame:CGRectMake(0, 0, 608, 44)];
    SetViewLeftUp(info_title, 136, 0);
  
   
}

- (void)setHorizontalFrame
{
   
    [bgHeadView setFrame:CGRectMake(0, 0, 864, 44)];
    [icon_headDown setFrame:CGRectMake(0, 14, 864, 30)];
    [icon_headUp setFrame:CGRectMake(0, 0, 864, 44)];
    SetViewLeftUp(info_title, 272, 0);
  
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


- (void)dealloc
{
    [MyNotiCenter removeObserver:self name:Noti_manangePartnerData object:nil];
    [MyNotiCenter removeObserver:self name:Noti_manangedPartnerData object:nil];
}
@end
