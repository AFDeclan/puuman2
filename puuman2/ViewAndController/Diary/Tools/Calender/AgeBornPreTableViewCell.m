//
//  AgeBornPreTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AgeBornPreTableViewCell.h"
#import "UniverseConstant.h"
#import "DiaryModel.h"
#import "DiaryViewController.h"
#import "Diary.h"

static const float dayCellWidth = 28;
static const float dayCellHeight = 32;
static const float startDayCellOfX = 18;
static const float startDayCellOfY = 0;
static const float subDistanceOfX = 2;
@implementation AgeBornPreTableViewCell

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
    
    NSInteger days = [[[UserInfo sharedUserInfo] createTime] daysToDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
    NSInteger week = days/7;

    for (int i = 0; i < 7; i ++) {
       
        if ( (week - weekNum)*7+7-i < days) {
            [labels[i] setTextColor:PMColor6];
            [labels[i] setBackgroundColor:[UIColor clearColor]];
        }else{
            [labels[i] setTextColor:PMColor2];
            [labels[i] setBackgroundColor:[UIColor clearColor]];
        }
        [labels[i] setText:[NSString stringWithFormat:@"%d",i+1 ]];
        
        
        NSDateComponents *comp_day = [[NSDateComponents alloc] init];
        [comp_day setDay:-1*((week - weekNum)*7+7-i)];
        NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday] options:0];
        if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day ] >= 0) {
            [labels[i] setTextColor:[UIColor whiteColor]];
            [labels[i] setBackgroundColor:PMColor6];
        }
    }
    
    
}


@end
