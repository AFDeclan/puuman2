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
static const float subDistanceOfY = 4;

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

- (void)buildMonthWithCurrentIndex:(NSInteger)index
{
    week = index;
}

- (void)dayClicked:(UIGestureRecognizer *)sender
{
    for (int i=0; i<7; i++)
    {
        if (gestureRecognizer[i] == sender)
        {
            NSDate *clickedDate = [[[[UserInfo sharedUserInfo]babyInfo] Birthday] dateByAddingTimeInterval:(week*7+i)*24*60*60];
            NSInteger index = [[DiaryModel sharedDiaryModel] indexForDiaryInDay:clickedDate];
            if (index >= 0)
            {
                [[DiaryViewController sharedDiaryViewController] showDiaryAtIndex:index];
            }
        }
    }
}

-(void)refresh
{
    
    NSArray *ages = [[NSDate date] ageFromDate:[[UserInfo sharedUserInfo] babyInfo].Birthday];
    NSInteger days = [[ages objectAtIndex:0 ] intValue]*7 +[[ages objectAtIndex:1] intValue];
    
    
    
    
//    for (int i=0; i<7; i++) {
//            
//            if (week*7+i <= days) {
//                [labels[i] setTextColor:PMColor6];
//                [labels[i] setText:[NSString stringWithFormat:@"%d",i+1 ]];
//            }else{
//                [labels[i] setAlpha:0];
//            }
//        
//            if (month < now_month) {
//                [labels[i] setTextColor: PMColor2];
//                [labels[i] setBackgroundColor:[UIColor clearColor]];
//            }else if(month == now_month){
//                if (i*7+j+1 < now_day) {
//                    [labels[i][j] setTextColor:PMColor2];
//                    [labels[i][j] setBackgroundColor:[UIColor clearColor]];
//                }else if (i*7+j+1 == now_day){
//                    [labels[i][j] setTextColor:[UIColor whiteColor]];
//                    [labels[i][j] setBackgroundColor:PMColor6];
//                    
//                }else{
//                    [labels[i][j] setTextColor:PMColor6];
//                    [labels[i][j] setBackgroundColor:[UIColor clearColor]];
//                }
//                
//                
//                
//            }else{
//                [labels[i][j] setTextColor: PMColor6];
//                [labels[i][j] setBackgroundColor:[UIColor clearColor]];
//            }
//            
//            NSDateComponents *comp_day = [[NSDateComponents alloc] init];
//            [comp_day setDay:i*7+j];
//            NSDate *date_day = [[NSCalendar currentCalendar] dateByAddingComponents:comp_day toDate:date_firstDay options:0];
//            if ([[DiaryModel sharedDiaryModel] indexForDiaryInDay:date_day ] >= 0) {
//                [labels[i][j] setTextColor:[UIColor whiteColor]];
//                [labels[i][j] setBackgroundColor:PMColor6];
//            }
//            
//        }
//   
    
}


@end
