//
//  BabyInfoVaciViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoVaciViewCell.h"
#import "ColorsAndFonts.h"
#import "BabyData.h"
#import "MainTabBarController.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"

static BabyInfoVaciViewCell *instance;

@implementation BabyInfoVaciViewCell
@synthesize delegate = _delegate;
+(BabyInfoVaciViewCell *)shareVaccineCell
{
    if (!instance)
    {
        instance = [[BabyInfoVaciViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VaccineCell"];
    }
    return instance;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // [showAndHiddenBtn setAlpha:0];
        [self initialization];
        [self initWithLeftView];
        [self initWithRightView];
        if ([[MainTabBarController sharedMainViewController] isVertical]) {
            [self setVerticalFrame];
        }else {
            [self setHorizontalFrame];
        }
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
    }
    return self;
}

- (void)initialization
{
    lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:PMColor6];
    [self.contentView addSubview:lineView];
    leftView = [[UIView alloc] init];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:leftView];
    rightView = [[UIView alloc] init];
    [rightView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:rightView];

    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundColor:PMColor6];
    [leftBtn setImage:[UIImage imageNamed:@"back_left_babyInfo.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftBtn];
    
     backUpBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [backUpBtn setFrame:CGRectMake(0, 0, 128, 32)];
    [backUpBtn setBackgroundColor:[UIColor clearColor]];
    [backUpBtn setImage:[UIImage imageNamed:@"btn_back_babyInfo.png"] forState:UIControlStateNormal];
    [backUpBtn addTarget:self action:@selector(backUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:backUpBtn];

    
}

- (void)initWithRightView
{
    
    dataTable = [[UITableView alloc] init];
    [dataTable setBackgroundColor:PMColor6];
    [dataTable setDataSource:self];
    [dataTable setDelegate:self];
    [rightView addSubview:dataTable];
    [dataTable setSeparatorColor:[UIColor clearColor]];
    [dataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [dataTable setShowsHorizontalScrollIndicator:NO];
    [dataTable setShowsVerticalScrollIndicator:NO];
}

- (void)initWithLeftView
{
    emptyView = [[UIView alloc] init];
    [emptyView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:emptyView];
    
    UIImageView *iconBg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 112, 112)];
    [iconBg setImage:[UIImage imageNamed:@"pic_vac_blank.png"]];
    [emptyView addSubview:iconBg];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 136, 24)];
    [title setFont:PMFont4];
    [title setTextColor:PMColor3];
    [title setText:@"在右侧选择疫苗即可查看详情"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:[UIColor clearColor]];
    [emptyView addSubview:title];
    [emptyView setAlpha:0];
    selectVaccine = -1;
    chooseVaccine = 0;
    
    statusText = [[CustomTextField alloc] init];
    [statusText setEnabled:NO];
    [statusText setPlaceholder:@"建议在6月龄接种"];
    [leftView addSubview:statusText];
    
    nameLabel = [[AnimateShowLabel alloc] init];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [leftView addSubview:nameLabel];
    
    detail = [[UITextView alloc] init];

    [detail setBackgroundColor:[UIColor clearColor]];
    [detail setFont:PMFont2];
    [detail setEditable:NO];
    [detail setTextColor:PMColor2];
    [leftView addSubview:detail];
    
    modifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 48)];
    [modifyBtn setBackgroundColor:[UIColor clearColor]];
    [modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
    [modifyBtn setTitleColor:PMColor6 forState:UIControlStateNormal];
    [modifyBtn.titleLabel setFont:PMFont2];
    [modifyBtn addTarget:self action:@selector(modify) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:modifyBtn];
    
    animateFlag = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 84, 84)];
    [animateFlag setImage:[UIImage imageNamed:@"vaccine_icon.png"]];
    [leftView addSubview:animateFlag];
    [animateFlag setAlpha:0];
}

- (void)selectedDate
{
//    if (_calendar) {
//        [_calendar removeFromSuperview];
//    }
//    _calendar = [[AddInfoCalendar alloc] initWithFrame:CGRectMake(0, 0, 300, 325)];
//    [_calendar setAlpha:1];
//    _calendar.delegate = self;
//    [leftView addSubview:_calendar];
//    if ([MainTabBarController sharedMainViewController].isVertical) {
//        
//        SetViewLeftUp(_calendar, 16, 116);
//    }else{
//        SetViewLeftUp(_calendar, 150, 96);
//    }
    }

- (void)backUpBtnClick
{
    PostNotification(Noti_HiddenBabyView, nil);

}

- (void)leftBtnClick
{
    [_delegate backToMianCell];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[BabyData sharedBabyData] vaccineCount];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity = @"bodyInfoCell";
    VaccineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell)
    {
        cell = [[VaccineInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setVacIndex:indexPath.section];
    [cell setDelegate:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] != selectVaccine) {
        return 96;
 
    }else{
        return 192+96;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)saveBtnClick:(NSInteger)index
{
    selectVaccine = -1;
    [self showVaccineAnimate];
    [dataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)cancelBtnClick:(NSInteger)index
{
    selectVaccine = -1;
    [dataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)selectedBtnClick:(NSInteger)index withCanUnFold:(BOOL)unFold
{
    if (unFold) {
        if (selectVaccine ==  index) {
            selectVaccine = - 1;

        }else{
            selectVaccine =  index;
        }
        [dataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
            
    }else{
        if (selectVaccine != -1) {
            NSInteger num = selectVaccine;
            selectVaccine = -1;

        [dataTable reloadSections:[NSIndexSet indexSetWithIndex:num] withRowAnimation:UITableViewRowAnimationFade];
        }

    }
    [self selectAtIndex:index];
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        if (96*index < dataTable.frame.size.height/2) {
            [dataTable setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (96*index >dataTable.contentSize.height - dataTable.frame.size.height/2 - 96){
            [dataTable setContentOffset:CGPointMake(0, dataTable.contentSize.height - dataTable.frame.size.height) animated:YES];
        }else{
            [dataTable setContentOffset:CGPointMake(0, 96*index - dataTable.frame.size.height/2 + 96) animated:YES];
            
        }
    }else{
    
        if (96*index < dataTable.frame.size.height/2) {
            [dataTable setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (96*index >dataTable.contentSize.height - dataTable.frame.size.height/2 - 96){
            [dataTable setContentOffset:CGPointMake(0, dataTable.contentSize.height - dataTable.frame.size.height) animated:YES];
        }else{
            [dataTable setContentOffset:CGPointMake(0, 96*index - dataTable.frame.size.height/2 + 96) animated:YES];
            
        }
        
    }
    
}

-(void)setVerticalFrame
{
    SetViewLeftUp(backUpBtn, 318, 992);
    [lineView setFrame:CGRectMake(0, 96, 768, 2)];
    [leftView setFrame:CGRectMake(48, 98, 335, 926)];
    [rightView setFrame:CGRectMake(383, 96, 385, 928)];
    [dataTable setFrame:CGRectMake(0, 0, 385, 928)];
    [leftBtn setFrame:CGRectMake(0, 96, 48, 928)];
    [nameLabel setFrame:CGRectMake(40, 194, 255, 64)];
    [detail setFrame:CGRectMake(40, 238, 255, 500)];
    [statusText setFrame:CGRectMake(40, 130, 255, 48)];
    SetViewLeftUp(modifyBtn, 40+255-64, 130);

    [self selectAtIndex:chooseVaccine];

    [self performSelector:@selector(scrollDataTable) withObject:nil afterDelay:0];
    if (dateViewShowed) {
        [self.popoverController presentPopoverFromRect:modifyBtn.frame inView:leftView permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }
    
}

-(void)setHorizontalFrame
{
    [lineView setFrame:CGRectMake(0, 96, 1024, 2)];
    [leftView setFrame:CGRectMake(48, 98, 542, 670)];
     [rightView setFrame:CGRectMake(590,96,434, 672)];
    [dataTable setFrame: CGRectMake(0, 0, 434, 672)];
   
    [emptyView setFrame:CGRectMake(192, 292, 136, 144)];
    [leftBtn setFrame:CGRectMake(0, 96, 48, 672)];
    [nameLabel setFrame:CGRectMake(72, 190, 336, 64)];
    [detail setFrame:CGRectMake(72, 236, 336, 288)];
    [statusText setFrame:CGRectMake(72, 126, 336, 48)];
    SetViewLeftUp(backUpBtn, 448, 736);
    SetViewLeftUp(modifyBtn, 72+336-64, 126);

    [self selectAtIndex:chooseVaccine];
    [self performSelector:@selector(scrollDataTable) withObject:nil afterDelay:0];
    if (dateViewShowed) {
        [self.popoverController presentPopoverFromRect:modifyBtn.frame inView:leftView permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    }
    
    
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    dateViewShowed = NO;

}

- (void)scrollDataTable
{
    if (96*chooseVaccine < dataTable.frame.size.height/2) {
        [dataTable setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (96*chooseVaccine >dataTable.contentSize.height - dataTable.frame.size.height/2 - 96){
        [dataTable setContentOffset:CGPointMake(0, dataTable.contentSize.height - dataTable.frame.size.height) animated:YES];
    }else{
        [dataTable setContentOffset:CGPointMake(0, 96*chooseVaccine - dataTable.frame.size.height/2 + 96) animated:YES];
        
    }
}

- (void)refresh
{
    dateViewShowed = NO;
    chooseVaccine = 0;
    selectVaccine = -1;
    [dataTable reloadData];
    [self performSelectorOnMainThread:@selector(animateWithVaccineView) withObject:nil waitUntilDone:0];
    
}

- (void)showVaccineAnimate
{
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.2] forKey:kCATransactionAnimationDuration];
    // scale it down
    CABasicAnimation *shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrinkAnimation.delegate = self;
    shrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    shrinkAnimation.fromValue = [NSNumber numberWithFloat:5.0];
    // fade it out
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animateFlag setAlpha:1];
    [[animateFlag layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
    [[animateFlag layer] addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    
    [CATransaction commit];
    
}

-(void)animateWithVaccineView{
    
    NSInteger startIndex = [[BabyData sharedBabyData] startAtIndex];
    [self selectAtIndex:startIndex];

    NSLog(@"%d",[[BabyData sharedBabyData] vaccineCount]);
    startIndex =  (startIndex*96 - ViewHeight(dataTable)/2)/96;
    startIndex = startIndex < 0 ? 0:startIndex;
    NSInteger max =  ([[BabyData sharedBabyData] vaccineCount]*96 - ViewHeight(dataTable))/96;
    startIndex = startIndex > max ? max:startIndex;
    
    [UIView animateWithDuration:0.5 animations:^{
        [dataTable setContentOffset:CGPointMake(0, startIndex*96)];
    }];
}

- (void)selectAtIndex:(NSInteger)index
{
    
    chooseVaccine = index;
    [leftView setAlpha:1];
    [emptyView setAlpha:0];
    if ([MainTabBarController sharedMainViewController].isVertical) {
     
        SetViewLeftUp(backBtn, 0, 336);
        [backBtn setEnabled:YES];
       
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(backBtn, 0, -dataTable.contentOffset.y-30 +index *96);
        }];
    

    }
    NSDictionary *vacInfo = [[BabyData sharedBabyData] vaccineAtIndex:index];
    NSDate *doneDate = [vacInfo valueForKey:kVaccine_DoneTime];
    NSString *title = [vacInfo valueForKey:kVaccine_Name];
    
    [nameLabel animateStop];
    [nameLabel setTitleWithTitleText:title andTitleColor:PMColor1 andTitleFont:PMFont1 andMoveSpeed:1 andIsAutomatic:YES];
    [nameLabel animateStart];
    [detail setText:[vacInfo valueForKey:KVaccine_Info]];
    
    if (doneDate) {
        [modifyBtn setAlpha:1];
        NSInteger month = 0;
        NSArray *age = [doneDate ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        if ([age count] == 3)
        {
            month = [[age objectAtIndex:0] integerValue] * 12 + [[age objectAtIndex:1] integerValue];
        }
        [statusText setText:[NSString stringWithFormat:@"已经在%d月龄接种",month]];
        [animateFlag setAlpha:1];
    }
    else {
        [animateFlag setAlpha:0];

        NSArray *age = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        NSInteger month = 0;
        if ([age count] == 3)
        {
            month = [[age objectAtIndex:0] integerValue] * 12 + [[age objectAtIndex:1] integerValue];
        }
        NSArray *suitMonths = [[vacInfo valueForKey:kVaccine_SuitMonth] componentsSeparatedByString:@"~"];
        NSInteger startMonth = 0, endMonth = 0;
        if ([suitMonths count] == 2)
        {
            startMonth = [[suitMonths objectAtIndex:0] integerValue];
            endMonth = [[suitMonths objectAtIndex:1] integerValue];
        }
        suitMonth = [[vacInfo valueForKey:kVaccine_SuitMonth] integerValue];
        if (month >= startMonth && month < endMonth)
        {
            [modifyBtn setAlpha:0];
            [statusText setText:[NSString stringWithFormat:@"建议在%d月龄接种",suitMonth]];
            
        }
        else if(month<startMonth)
        {
            [modifyBtn setAlpha:0];
            [statusText setText:[NSString stringWithFormat:@"建议在%d月龄接种",suitMonth]];
            
        }else{
            [modifyBtn setAlpha:0];

            [statusText setText:[NSString stringWithFormat:@"已经在%d月龄接种",suitMonth]];
        }
        
    }
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:detail.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:16];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [detail.text length])];
    [detail setAttributedText:attributedString1];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (selectVaccine == -1) {
        SetViewLeftUp(backBtn, 0, -156);
    }else{
        SetViewLeftUp(backBtn, 0, -dataTable.contentOffset.y-30 +selectVaccine *96);
        
    }
}

- (void)modify
{
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
    self.contentViewContorller = [[VaciPopoverContentViewController alloc] init];
    [self.contentViewContorller setVacIndex:chooseVaccine];
    [self.contentViewContorller setVaccineDelegate:self];
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.contentViewContorller];
    [self.popoverController setDelegate:self];
    [self.popoverController presentPopoverFromRect:modifyBtn.frame inView:leftView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    dateViewShowed = YES;

}

- (void)saveVacBtnClick:(NSInteger)index
{
    selectVaccine = -1;
    [dataTable reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    [self selectAtIndex:chooseVaccine];
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
    
}

- (void)cancelVacBtnClick
{
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
