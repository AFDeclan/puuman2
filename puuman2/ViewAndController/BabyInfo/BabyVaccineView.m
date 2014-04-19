//
//  BabyVaccineView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyVaccineView.h"
#import "ColorsAndFonts.h"
#import "BabyData.h"
#import "VaccineInfoTableViewCell.h"
#import "MainTabBarController.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"

@implementation BabyVaccineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [showAndHiddenBtn setAlpha:0];
        [self initWithLeftView];
        [self initWithRightView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)initWithLeftView
{
    
    dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 432, 0)];
    [dataTable setBackgroundColor:PMColor6];
    [dataTable setDataSource:self];
    [dataTable setDelegate:self];
    [leftView addSubview:dataTable];
    //[dataTable setBackgroundColor:[UIColor clearColor]];
    [dataTable setSeparatorColor:[UIColor clearColor]];
    [dataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [dataTable setShowsHorizontalScrollIndicator:NO];
    [dataTable setShowsVerticalScrollIndicator:NO];
}

- (void)initWithRightView
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
    [title setText:@"在左侧选择疫苗即可查看详情"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:[UIColor clearColor]];
    [emptyView addSubview:title];
    [emptyView setAlpha:0];
    selectVaccine = -1;
    right = NO;
    selectedDateBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 48, 336, 48)];
    [selectedDateBtn addTarget:self action:@selector(selectedDate)  forControlEvents:UIControlEventTouchUpInside];
    [selectedDateBtn setBackgroundColor:[UIColor clearColor]];
    [rightView addSubview:selectedDateBtn];
    statusText = [[CustomTextField alloc] initWithFrame:CGRectMake(0, 0, 336, 48)];
    [statusText setEnabled:NO];
    [selectedDateBtn addSubview:statusText];
    
   
    
    nameLabel = [[AnimateShowLabel alloc] initWithFrame:CGRectMake(0, 96, 336, 64)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [rightView addSubview:nameLabel];
    
    detail = [[UITextView alloc] initWithFrame:CGRectMake(0, 178, 336, 0)];
    [detail setBackgroundColor:[UIColor clearColor]];
    [detail setFont:PMFont2];
    [detail setEditable:NO];
    [detail setTextColor:PMColor2];
    [rightView addSubview:detail];
    
    alreadyBtn = [[ColorButton alloc] init];
    [alreadyBtn initWithTitle:@"已接种" andButtonType:kBlueLeftUp];
    [alreadyBtn addTarget:self action:@selector(alreadyBtnPressed)  forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:alreadyBtn];
    
    notBtn = [[ColorButton alloc] init];
    [notBtn initWithTitle:@"未接种" andButtonType:kBlueLeftDown];
    [notBtn addTarget:self action:@selector(noBtnPressed)  forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:notBtn];
    
    backBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 336, 48, 156)];
    [backBtn addTarget:self action:@selector(backToMainTable)  forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"" andImg:[UIImage imageNamed:@"tri_blue_right.png"] andButtonType:kButtonTypeSix];
    [rightView addSubview:backBtn];
    
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
    [rightView addSubview:_calendar];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        SetViewLeftUp(_calendar, 162, 96);
    }else{
        SetViewLeftUp(_calendar, 66, 96);
    }

}

- (void)backToMainTable
{
  
    [maskView setAlpha:1];
    [UIView animateWithDuration:0.5 animations:^{
        [self setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
        [maskView setAlpha:0];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        // Return the number of rows in the section.
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
    [super setVerticalFrame];
    [leftView setFrame:CGRectMake(0, 0, 608, 832)];
    [rightView setFrame:CGRectMake(608, 0, 608, 832)];
    [dataTable setFrame:CGRectMake(88, 0, 432, 832)];
    SetViewLeftUp(selectedDateBtn, 144, 48);
    SetViewLeftUp(nameLabel, 144, 96);
    SetViewLeftUp(alreadyBtn, 486, 736);
    SetViewLeftUp(notBtn, 486, 776);
    [detail setFrame:CGRectMake(144, 178, 336, 638)];
    [maskView setFrame:CGRectMake(0, 0, 608, 832)];
    if (selectVaccine != -1) {
        [self selectAtIndex:selectVaccine];
    }
    if (_calendar) {
        SetViewLeftUp(_calendar, 162, 96);;
    }
    [emptyView setAlpha:0];
}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [leftView setFrame:CGRectMake(0, 0, 432, 576)];
    [dataTable setFrame:CGRectMake(0, 0, 432, 576)];
    [rightView setFrame:CGRectMake(432, 0, 432, 576)];
    SetViewLeftUp(selectedDateBtn, 48, 48);
    SetViewLeftUp(nameLabel, 48, 96);
    SetViewLeftUp(alreadyBtn, 320, 480);
    SetViewLeftUp(notBtn, 320, 520);
    [detail setFrame:CGRectMake(48, 178, 336, 288)];
    //[backBtn setTitle:@"" andImg:[UIImage imageNamed:@"tri_blue_left.png"] andButtonType:kButtonTypeSix];
    [backBtn setEnabled:NO];
    SetViewLeftUp(backBtn, 0, 200);
    [self setContentOffset:CGPointMake(0, 0)];
    [maskView setFrame:CGRectMake(0, 0, 864, 576)];
    if (selectVaccine == -1) {
        [rightView setAlpha:0];
        [emptyView setAlpha:1];
        SetViewLeftUp(backBtn, 0, -156);
    }else{
        [emptyView setAlpha:0];
        [self selectAtIndex:selectVaccine];
    }
    if (_calendar) {
        SetViewLeftUp(_calendar, 66, 96);;
    }
     [emptyView setFrame:CGRectMake(592, 192, 136, 144)];

}

- (void)refresh
{
    [dataTable reloadData];
}

- (void)selectAtIndex:(NSInteger)index
{
    [rightView setAlpha:1];
     [emptyView setAlpha:0];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [maskView setAlpha:1];
        [UIView animateWithDuration:0.5 animations:^{
            [self setContentOffset:CGPointMake(608, 0)];
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
        NSArray *age = [[NSDate date] ageFromDate:[BabyData sharedBabyData].babyBirth];
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
        NSArray *age = [date ageFromDate:[BabyData sharedBabyData].babyBirth];
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
        [self performSelector:@selector(refresh) withObject:nil afterDelay:0];

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


@end
