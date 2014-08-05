//
//  FiguresHeaderView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "FiguresHeaderView.h"
#import "ColorsAndFonts.h"
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
        
        [self  initialization];
        [[Friend sharedInstance] addDelegateObject:self];

    }
    return self;
}

- (void)initialization
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 44)];
    [self addSubview:headerView];
    headerView.layer.masksToBounds = YES;
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 864, 124)];
    [contentView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:contentView];
    
    header_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 60)];
    [header_bg setBackgroundColor:PMColor6];
    [headerView addSubview:header_bg];
    header_bg.layer.cornerRadius = 16.0f;
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [nameTextField setBackgroundColor:[UIColor clearColor]];
    [nameTextField setTextColor:[UIColor whiteColor]];
    [nameTextField setFont:PMFont1];
    [nameTextField setTextAlignment:NSTextAlignmentCenter];
    [headerView addSubview:nameTextField];
    [nameTextField setDelegate:self];
    [nameTextField setEnabled:NO];
    
    manageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [manageBtn setFrame:CGRectMake(0, 0, 80, 44)];
    [manageBtn.titleLabel setFont:PMFont2];
    [manageBtn setBackgroundColor:[UIColor clearColor]];
    [manageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [manageBtn setTitle:@"管理" forState: UIControlStateNormal];
    [manageBtn addTarget:self action:@selector(managePartner) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:manageBtn];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 80, 44)];
    [backBtn.titleLabel setFont:PMFont2];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState: UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backBtn];

}

- (void)reloadGroupInfo
{
    myGroup = [[Friend sharedInstance] myGroup];
    managing = NO;
    [manageBtn setTitle:@"管理" forState:UIControlStateNormal];
    
    [nameTextField setEnabled:NO];
    [nameTextField resignFirstResponder];
    [nameTextField setBackgroundColor:[UIColor clearColor]];
    [nameTextField setText:myGroup.GName];
    oldName = myGroup.GName;
    [backBtn setAlpha:0];
    
    if (figuresColumnView) {
        [figuresColumnView removeFromSuperview];
        figuresColumnView = nil;
    }
   
    figuresColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 48, 576, 120)];
    [figuresColumnView setBackgroundColor:[UIColor clearColor]];
    [figuresColumnView setColumnViewDelegate:self];
    [figuresColumnView setViewDataSource:self];
    [figuresColumnView setPagingEnabled:NO];
    [figuresColumnView setScrollEnabled:YES];
    [self addSubview:figuresColumnView];
}


- (void)back
{
    changed = NO;
    [self managePartner];
}

- (void)managePartner
{
    managing= !managing;
    if (managing) {
        changed = NO;
        oldName = myGroup.GName;
        [manageBtn setTitle:@"保存" forState:UIControlStateNormal];
        PostNotification(Noti_manangingPartnerData, [NSNumber numberWithBool:YES]);
        [self showManagerMenu];
        [backBtn setAlpha:1];
    }else{
        
        [manageBtn setTitle:@"管理" forState:UIControlStateNormal];
        PostNotification(Noti_manangingPartnerData, [NSNumber numberWithBool:NO]);
        [self hiddenManagerMenu];
        [backBtn setAlpha:0];
    }
}

- (void)showManagerMenu
{
    [nameTextField setEnabled:YES];
    [nameTextField becomeFirstResponder];
    [nameTextField setBackgroundColor:PMColor3];
}

- (void)hiddenManagerMenu
{
    
    [nameTextField setEnabled:NO];
    [nameTextField resignFirstResponder];
    if (changed) {
        [[myGroup actionForRenameGroup:nameTextField.text] upload];
    }else{
        [nameTextField setText:oldName];
    }
    [nameTextField setBackgroundColor:[UIColor clearColor]];
}

- (void)quit
{
    [self hiddenManagerMenu];
    [[myGroup actionForQuit] upload];

}

- (void)showPartnerWithInfo:(Member *)member
{
    RecommendPartnerViewController  *recommend = [[RecommendPartnerViewController alloc] initWithNibName:nil bundle:nil];
    [recommend setControlBtnType:kOnlyCloseButton];
    [recommend setRecommend:NO];
    [recommend setMember:member];
//    if (cell.recommend) {
//        [recommend setTitle:@"推荐伙伴" withIcon:nil];
//    }else{
    [recommend setTitle:@"宝宝详情" withIcon:nil];
  //  }
    [[MainTabBarController sharedMainViewController].view addSubview:recommend.view];
    [recommend show];
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
 
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
    [cell setDelegate:self];
    [cell setMember:[myGroup.GMember objectAtIndex:index]];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)setVerticalFrame
{
    [headerView setFrame:CGRectMake(0, 0, 608, 44)];
    [header_bg setFrame:CGRectMake(0, 0, 608, 60)];
    SetViewLeftUp(nameTextField, 136, 0);
    SetViewLeftUp(figuresColumnView, 22, 48);
    SetViewLeftUp(manageBtn, 528, 0);

}

- (void)setHorizontalFrame
{
    [headerView setFrame:CGRectMake(0, 0, 864, 44)];
    [header_bg setFrame:CGRectMake(0, 0, 864, 60)];
    SetViewLeftUp(nameTextField, 272, 0);
    SetViewLeftUp(figuresColumnView, 152, 48);
    SetViewLeftUp(manageBtn, 784,0);
}

//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action
{
    if (managing) {
        PostNotification(Noti_RefreshInviteStatus, nil);
    }
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


- (void)removeFromSuperview
{
    [[Friend sharedInstance] removeDelegateObject:self];
    [super removeFromSuperview];
}
@end
