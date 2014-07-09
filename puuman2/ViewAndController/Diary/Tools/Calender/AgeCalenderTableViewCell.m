//
//  AgeCalenderTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AgeCalenderTableViewCell.h"
#import "UniverseConstant.h"
#import "DiaryModel.h"
#import "DiaryViewController.h"


static const float dayCellWidth = 28;
static const float dayCellHeight = 32;
static const float startDayCellOfX = 18;
static const float startDayCellOfY = 0;
static const float subDistanceOfX = 2;
static const float subDistanceOfY = 4;
@implementation AgeCalenderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initialization
{
    CGFloat x = startDayCellOfX;
    CGFloat y = startDayCellOfY;
    for (int i=0; i<6; i++)
    {
        for (int j=0; j<7; j++) {
            labels[i][j] = [[UILabel alloc] initWithFrame:CGRectMake(x+2, y-1, dayCellWidth, dayCellHeight)];
            [labels[i][j] setAlpha:0];
            x += dayCellWidth + subDistanceOfX;
            [labels[i][j] setFont:PMFont3 ];
            [labels[i][j] setTextAlignment:NSTextAlignmentCenter];
            [labels[i][j] setBackgroundColor:[UIColor clearColor]];
            [labels[i][j] setTextColor:PMColor6];
            [self addSubview:labels[i][j]];
            gestureRecognizer[i][j] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayClicked:)];
            [labels[i][j] setUserInteractionEnabled:YES];
            [labels[i][j] addGestureRecognizer:gestureRecognizer[i][j]];
        }
        x = startDayCellOfX;
        y += dayCellHeight + subDistanceOfY;
    }

}


- (void)dayClicked:(UIGestureRecognizer *)sender
{
    
    for (int i=0; i<6; i++)
        for (int j=0; j<7; j++)
        {
            if (gestureRecognizer[i][j] == sender)
            {
                NSDateComponents *comp_day = [[NSDateComponents alloc] init];
                [comp_day setDay:i*7+j];
                NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:date_firstDay options:0];
                NSInteger index = [[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day];
                if (index >= 0) {
                    [[DiaryViewController sharedDiaryViewController] showDiaryAtIndex:index];
                }
            }
        }
}



- (void)buildMonthWithCurrentIndex:(NSInteger)index
{
    [self nowMonth];
    if (index != 0) {
        for (int i = 0; i > index; i--) {
           [self preMonth];
        }
    }
    [self refresh];
}

- (void)preMonth
{
    date_nextFirstDay = date_firstDay;
    NSDateComponents *comp_lastDay = [[NSDateComponents alloc] init];
    [comp_lastDay setDay:-1];
    NSDate *date_lastDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_lastDay toDate:date_firstDay options:0];
    NSDateComponents* compPreMonth = [[NSDateComponents alloc]init];
    [compPreMonth setMonth:-1];
    date_firstDay = [[NSCalendar currentCalendar] dateByAddingComponents:compPreMonth toDate:date_firstDay options:0];
    days = [[[date_lastDay ageFromDate:date_firstDay] objectAtIndex:2] intValue] ;

    month --;
}



- (void)nowMonth
{
    
    NSArray *ages = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
    NSDateComponents *comp_nowMonth = [[NSDateComponents alloc] init];
    [comp_nowMonth setDay:[[ages objectAtIndex:2] intValue]*(-1)+1];
    date_firstDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_nowMonth toDate:[NSDate date] options:0];
    NSDateComponents* compNextMonth = [[NSDateComponents alloc]init];
    [compNextMonth setMonth:1];
    date_nextFirstDay = [[NSCalendar currentCalendar] dateByAddingComponents:compNextMonth toDate:date_firstDay options:0];
    NSDateComponents *comp_lastDay = [[NSDateComponents alloc] init];
    [comp_lastDay setDay:-1];
    NSDate *date_lastDay = [[NSCalendar currentCalendar] dateByAddingComponents:comp_lastDay toDate:date_nextFirstDay options:0];
    days = [[[date_lastDay ageFromDate:date_firstDay] objectAtIndex:2] intValue];
    now_day = [[[[NSDate date] ageFromDate:date_firstDay] objectAtIndex:2] intValue];
    now_month = [[ages objectAtIndex:0] integerValue]*12 +[[ages objectAtIndex:1] integerValue];
    month = now_month;

}

-(void)refresh
{
    
    for (int i=0; i<6; i++) {
        for (int j=0; j<7; j++) {
            
            if (i*7+j+1 <= days) {
                [labels[i][j] setAlpha:1];
                [labels[i][j] setText:[NSString stringWithFormat:@"%d",i*7+j+1 ]];
            }else{
                [labels[i][j] setAlpha:0];
            }
            
            if (month < now_month) {
                [labels[i][j] setTextColor: PMColor2];
                [labels[i][j] setBackgroundColor:[UIColor clearColor]];
            }else if(month == now_month){
                if (i*7+j+1 < now_day) {
                    [labels[i][j] setTextColor:PMColor2];
                    [labels[i][j] setBackgroundColor:[UIColor clearColor]];
                }else if (i*7+j+1 == now_day){
                    [labels[i][j] setTextColor:[UIColor whiteColor]];
                    [labels[i][j] setBackgroundColor:PMColor6];
                    
                }else{
                    [labels[i][j] setTextColor:PMColor6];
                    [labels[i][j] setBackgroundColor:[UIColor clearColor]];
                }
                
                
                
            }else{
                [labels[i][j] setTextColor: PMColor6];
                [labels[i][j] setBackgroundColor:[UIColor clearColor]];
            }
            
            NSDateComponents *comp_day = [[NSDateComponents alloc] init];
            [comp_day setDay:i*7+j];
            NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:date_firstDay options:0];
            if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day ] >= 0) {
                [labels[i][j] setTextColor:[UIColor whiteColor]];
                [labels[i][j] setBackgroundColor:PMColor6];
            }
            
        }
    }
    
}



@end
