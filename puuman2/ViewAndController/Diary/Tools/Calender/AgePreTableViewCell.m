//
//  AgePreTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-9.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AgePreTableViewCell.h"
#import "UniverseConstant.h"
#import "DiaryModel.h"
#import "DiaryViewController.h"
#import "Diary.h"

static const float dayCellWidth = 28;
static const float dayCellHeight = 32;
static const float startDayCellOfX = 18;
static const float startDayCellOfY = 0;
static const float subDistanceOfX = 2;

@implementation AgePreTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    CGFloat x = startDayCellOfX;
    CGFloat y = startDayCellOfY;
  
    for (int i=0; i<7; i++) {
        labels[i] = [[UILabel alloc] initWithFrame:CGRectMake(x+2, y-1, dayCellWidth, dayCellHeight)];
        [labels[i] setAlpha:1];
        x += dayCellWidth + subDistanceOfX;
        [labels[i] setFont:PMFont3 ];
        [labels[i] setTextAlignment:NSTextAlignmentCenter];
        [labels[i] setBackgroundColor:[UIColor clearColor]];
        [labels[i] setTextColor:PMColor6];
        [self addSubview:labels[i]];
        gestureRecognizer[i] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayClicked:)];
        [labels[i] setUserInteractionEnabled:YES];
        [labels[i] addGestureRecognizer:gestureRecognizer[i]];
    }
    
  

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

- (void)buildWeekWithCurrentIndex:(NSInteger)index
{
    weekNum = index;
    [self refresh];
}

- (void)dayClicked:(UIGestureRecognizer *)sender
{
    for (int i=0; i<7; i++)
    {
        if (gestureRecognizer[i] == sender)
        {
            NSDateComponents *comp_day = [[NSDateComponents alloc] init];
            [comp_day setDay:weekNum*7+i];
            NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:[[UserInfo sharedUserInfo] createTime] options:0];
            
            NSInteger index = [[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day];
            if (index >= 0)
            {
                [[DiaryViewController sharedDiaryViewController] showDiaryAtIndex:index];
            }
        }
    }
}

-(void)refresh
{
    NSArray *times = [[[UserInfo sharedUserInfo] createTime] ageFromDate:[[UserInfo sharedUserInfo] babyInfo].Birthday];
    NSInteger startDay = [[times objectAtIndex:0 ] intValue]*7 +[[times objectAtIndex:1] intValue];
    NSArray *ages = [[NSDate date] ageFromDate:[[UserInfo sharedUserInfo] babyInfo].Birthday];
    NSInteger endDay = [[ages objectAtIndex:0 ] intValue]*7 +[[ages objectAtIndex:1] intValue];

    for (int i = 0; i < 7; i ++) {
        
        [labels[i] setText:[NSString stringWithFormat:@"%d",i+1 ]];
        if ((weekNum*7 + i >= [[times objectAtIndex:1] integerValue])&&(weekNum* 7 + i + startDay<= endDay ))
        {
            [labels[i] setTextColor:PMColor6];
            [labels[i] setBackgroundColor:[UIColor clearColor]];
        }else{
            [labels[i] setTextColor:PMColor2];
            [labels[i] setBackgroundColor:[UIColor clearColor]];

        }
        
   
        
        if (weekNum* 7 + i + startDay == endDay) {
            [labels[i] setTextColor:[UIColor whiteColor]];
            [labels[i] setBackgroundColor:PMColor6];
        }
        
        if (weekNum*7 +i == 280) {
            [labels[i] setTextColor:[UIColor whiteColor]];
            [labels[i] setBackgroundColor:PMColor7];
        }
        
        
        NSDateComponents *comp_day = [[NSDateComponents alloc] init];
        [comp_day setDay:weekNum*7+i];
        NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:[[UserInfo sharedUserInfo] createTime] options:0];
        if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day ] >= 0) {
            [labels[i] setTextColor:[UIColor whiteColor]];
            [labels[i] setBackgroundColor:PMColor6];
        }
    }

    
}


@end
