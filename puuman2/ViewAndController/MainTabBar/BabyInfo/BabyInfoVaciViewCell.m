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
#import "VaccineInfoTableViewCell.h"
#import "MainTabBarController.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"

@implementation BabyInfoVaciViewCell
@synthesize delegate = _delegate;

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
    right = NO;
    selectedDateBtn  = [[UIButton alloc] init];
    [selectedDateBtn addTarget:self action:@selector(selectedDate)  forControlEvents:UIControlEventTouchUpInside];
    [selectedDateBtn setBackgroundColor:[UIColor clearColor]];
    [leftView addSubview:selectedDateBtn];
    
    statusText = [[CustomTextField alloc] init];
    [statusText setEnabled:NO];
    [statusText setPlaceholder:@"建议在6月龄接种"];
    [selectedDateBtn addSubview:statusText];
    
   
    
    
    nameLabel = [[AnimateShowLabel alloc] init];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [leftView addSubview:nameLabel];
    
    detail = [[UITextView alloc] init];

    [detail setBackgroundColor:[UIColor clearColor]];
    [detail setFont:PMFont2];
    [detail setEditable:NO];
    [detail setTextColor:PMColor2];
    [leftView addSubview:detail];
    
    
    notBtn = [[AFColorButton alloc] init];
    [notBtn.title setText:@"未接种"];
    [notBtn setColorType:kColorButtonBlueColor];
    [notBtn setDirectionType:kColorButtonLeftUp];
    [notBtn resetColorButton];
    [notBtn addTarget:self action:@selector(noBtnPressed)  forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:notBtn];
    
    alreadyBtn = [[AFColorButton alloc] init];
    [alreadyBtn.title setText:@"已接种"];
    [alreadyBtn setColorType:kColorButtonBlueColor];
    [alreadyBtn setDirectionType:kColorButtonLeftDown];
    [alreadyBtn resetColorButton];
    [alreadyBtn addTarget:self action:@selector(alreadyBtnPressed)  forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:alreadyBtn];

    
    
//    backBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 48, 672)];
//    [backBtn addTarget:self action:@selector(backBtnClick)  forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundColor:PMColor6];
//    //[backBtn setTitle:@"" andImg:[UIImage imageNamed:@"tri_blue_right.png"] andButtonType:kButtonTypeSix];
//    [backBtn setImage:[UIImage imageNamed:@"back_left_babyInfo.png"] forState:UIControlStateNormal];
//    //[backBtn setTransform:CGAffineTransformMakeRotation(M_PI)];
   
    
    maskView = [[UIView alloc] init];
    [maskView setBackgroundColor:[UIColor clearColor]];
    [maskView setAlpha:0];
    [self addSubview:maskView];
}

- (void)selectedDate
{
    if (_calendar) {
        [_calendar removeFromSuperview];
    }
    _calendar = [[AddInfoCalendar alloc] initWithFrame:CGRectMake(0, 0, 300, 325)];
    [_calendar setAlpha:1];
    _calendar.delegate = self;
    [leftView addSubview:_calendar];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        SetViewLeftUp(_calendar, 16, 116);
    }else{
        SetViewLeftUp(_calendar, 150, 96);
    }
    
}

- (void)backUpBtnClick
{
  [[MainTabBarController sharedMainViewController] hiddenBabyView];

}

- (void)leftBtnClick
{
    [_delegate backToMianCell];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[BabyData sharedBabyData] vaccineCount];
    
    
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
    [cell setVaccineIndex:indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectVaccine = [indexPath row];
    [self selectAtIndex:[indexPath row]];
    
}

-(void)setVerticalFrame
{
    SetViewLeftUp(backUpBtn, 318, 992);
    [lineView setFrame:CGRectMake(0, 96, 768, 2)];
    [leftView setFrame:CGRectMake(48, 98, 335, 926)];
    [rightView setFrame:CGRectMake(383, 96, 385, 928)];
    [dataTable setFrame:CGRectMake(0, 0, 385, 928)];
    [leftBtn setFrame:CGRectMake(0, 96, 48, 928)];
    [selectedDateBtn setFrame:CGRectMake(40, 82, 255, 48)];
    [nameLabel setFrame:CGRectMake(40, 146, 255, 64)];
    [detail setFrame:CGRectMake(40, 190, 255, 400)];
    [statusText setFrame:CGRectMake(0, 0, 255, 48)];
    SetViewLeftUp(notBtn, 224, 814);
    SetViewLeftUp(alreadyBtn, 223, 854);
  
    
}

-(void)setHorizontalFrame
{
    [lineView setFrame:CGRectMake(0, 96, 1024, 2)];
    [leftView setFrame:CGRectMake(48, 98, 542, 670)];
     [rightView setFrame:CGRectMake(590,96,434, 672)];
    [dataTable setFrame: CGRectMake(0, 0, 434, 672)];
   
    [emptyView setFrame:CGRectMake(192, 292, 136, 144)];
    [leftBtn setFrame:CGRectMake(0, 96, 48, 672)];
    [notBtn setFrame:CGRectMake(432, 550,112, 40)];
    [alreadyBtn setFrame:CGRectMake(432, 590, 112, 40)];
    [selectedDateBtn setFrame:CGRectMake(72, 126, 336, 48)];
    [nameLabel setFrame:CGRectMake(72, 190, 336, 64)];
    [detail setFrame:CGRectMake(72, 236, 336, 288)];
    [statusText setFrame:CGRectMake(0, 0, 336, 48)];
    SetViewLeftUp(backUpBtn, 448, 736);
}

////-(void)setVerticalFrame
////{
////    //[super setVerticalFrame];
//////    [leftView setFrame:CGRectMake(0, 0, 608, 832)];
//////    [rightView setFrame:CGRectMake(608, 0, 608, 832)];
////    [dataTable setFrame:CGRectMake(88, 0, 432, 832)];
////    SetViewLeftUp(selectedDateBtn, 144, 48);
////    SetViewLeftUp(nameLabel, 144, 96);
////    SetViewLeftUp(alreadyBtn, 486, 736);
////    SetViewLeftUp(notBtn, 486, 776);
////    [detail setFrame:CGRectMake(144, 178, 336, 638)];
////    [maskView setFrame:CGRectMake(0, 0, 608, 832)];
////    if (selectVaccine != -1) {
////        [self selectAtIndex:selectVaccine];
////    }
////    if (_calendar) {
////        SetViewLeftUp(_calendar, 162, 96);;
////    }
////    [emptyView setAlpha:0];
////}
//
////-(void)setHorizontalFrame
////{
//////    [super setHorizontalFrame];
//////    [leftView setFrame:CGRectMake(0, 0, 432, 576)];
////    [dataTable setFrame:CGRectMake(0, 0, 432, 576)];
////   // [rightView setFrame:CGRectMake(432, 0, 432, 576)];
////    SetViewLeftUp(selectedDateBtn, 48, 48);
////    SetViewLeftUp(nameLabel, 48, 96);
////    SetViewLeftUp(alreadyBtn, 320, 480);
////    SetViewLeftUp(notBtn, 320, 520);
////    [detail setFrame:CGRectMake(48, 178, 336, 288)];
////    //[backBtn setTitle:@"" andImg:[UIImage imageNamed:@"tri_blue_left.png"] andButtonType:kButtonTypeSix];
////    [backBtn setEnabled:NO];
////    SetViewLeftUp(backBtn, 0, 200);
////    //    SetViewLeftUp(leftView, 0, -60);
////    //    [self performSelectorOnMainThread:@selector(animateWithVaccineView) withObject:nil waitUntilDone:0];
////    //[self setContentOffset:CGPointMake(0, 0)];
////    [maskView setFrame:CGRectMake(0, 0, 864, 576)];
////    if (selectVaccine == -1) {
////        //[rightView setAlpha:0];
////        [emptyView setAlpha:1];
////        SetViewLeftUp(backBtn, 0, -156);
////    }else{
////        [emptyView setAlpha:0];
////        [self selectAtIndex:selectVaccine];
////    }
////    if (_calendar) {
////        SetViewLeftUp(_calendar, 66, 96);;
////    }
////    [emptyView setFrame:CGRectMake(592, 192, 136, 144)];
////    
////}
////

- (void)refresh
{
    [dataTable reloadData];
    
    [self performSelectorOnMainThread:@selector(animateWithVaccineView) withObject:nil waitUntilDone:0];
    
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
    [leftView setAlpha:1];
    [emptyView setAlpha:0];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [maskView setAlpha:1];
        [UIView animateWithDuration:0.5 animations:^{
           //  [self setContentOffset:CGPointMake(608, 0)];
        } completion:^(BOOL finished) {
            [maskView setAlpha:0];
        }];
        SetViewLeftUp(backBtn, 0, 336);
        
        [backBtn setEnabled:YES];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(backBtn, 0, -dataTable.contentOffset.y-30 +index *96);
        }];
        
    }
    date = nil;
    NSDictionary *vacInfo = [[BabyData sharedBabyData] vaccineAtIndex:index];
    NSDate *doneDate = [vacInfo valueForKey:kVaccine_DoneTime];
    NSString *title = [vacInfo valueForKey:kVaccine_Name];
    
    [nameLabel animateStop];
    [nameLabel setTitleWithTitleText:title andTitleColor:PMColor1 andTitleFont:PMFont1 andMoveSpeed:1 andIsAutomatic:YES];
    [nameLabel animateStart];
    [detail setText:[vacInfo valueForKey:KVaccine_Info]];
    
    if (doneDate) {
        
        [self already];
        right = YES;
        date = doneDate;
    }
    else {
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
            [self noVaccine];
            [statusText setText:[NSString stringWithFormat:@"建议在%d月龄接种",suitMonth]];
            right  = NO;
            
        }
        else if(month<startMonth)
        {
            [self noVaccine];
            [statusText setText:[NSString stringWithFormat:@"已经在%d月龄接种",suitMonth]];
            right = YES;
            
            
        }else{
            [self noVaccine];
            [statusText setText:[NSString stringWithFormat:@"建议在%d月龄接种",suitMonth]];
            right  = NO;
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

- (void)already
{
    [notBtn setEnabled:YES];
    [alreadyBtn setEnabled:NO];
    [alreadyBtn selected];
    [notBtn unSelected];
    
}

- (void)noVaccine
{
    [notBtn setEnabled:NO];
    [alreadyBtn setEnabled:YES];
    [alreadyBtn unSelected];
    [notBtn selected];
    
}

- (void)refreshStatus
{
    
    NSInteger month = 0;
    if (date) {
        NSArray *age = [date ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
        if ([age count] == 3)
        {
            month = [[age objectAtIndex:0] integerValue] * 12 + [[age objectAtIndex:1] integerValue];
        }
        if (right) {
            [statusText setText:[NSString stringWithFormat:@"已经在%d月龄接种",month]];
        }else{
            [statusText setText:[NSString stringWithFormat:@"建议在%d月龄接种",month]];
        }
    }else{
        month  = suitMonth;
        if (right) {
            [statusText setText:[NSString stringWithFormat:@"已经在%d月龄接种",month]];
        }else{
            [statusText setText:[NSString stringWithFormat:@"已经在%d月龄接种",month]];
        }
    }
    
    
}

- (void)calendar:(AddInfoCalendar *)calendar selectedButton:(DateButton *)dateBtn
{
    if ([calendar dateIsAvailable:dateBtn.date])
    {
        dateBtn.backgroundColor = calendar.selectedDateBackgroundColor;
        date = dateBtn.date;
        [self refreshStatus];
        [_calendar removeFromSuperview];
        [[BabyData sharedBabyData] updateVaccineAtIndex:selectVaccine withDoneTime:date];
    
        
    }
    
}

- (void)alreadyBtnPressed
{
    right  = YES;
    [self already];
    [self refreshStatus];
    [self selectedDate];
    
}

- (void)noBtnPressed
{
    date = nil;
    right  = NO;
    [self noVaccine];
    [self refreshStatus];
    if (_calendar) {
        [_calendar removeFromSuperview];
    }
    [[BabyData sharedBabyData] updateVaccineAtIndex:selectVaccine withDoneTime:date];
    [self performSelector:@selector(refresh) withObject:nil afterDelay:0];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
