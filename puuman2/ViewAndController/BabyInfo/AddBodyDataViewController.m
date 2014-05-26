//
//  AddBodyDataViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AddBodyDataViewController.h"
#import "BabyData.h"
#import "MainTabBarController.h"
#import "DiaryFileManager.h"
#import "StandardLine.h"

@interface AddBodyDataViewController ()

@end

@implementation AddBodyDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContent];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)initContent
{
    
    bg_ruler = [[UIImageView alloc] initWithFrame:CGRectMake(144, 240, 440, 144)];
    [bg_ruler setImage:[UIImage imageNamed:@"pic_ruler_baby.png"]];
    [_content addSubview:bg_ruler];
    
    dateTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 420,640, 48)];
    [dateTextField setBackground:[UIImage imageNamed:@"title2_baby_diary.png"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-M-d";
    [dateTextField setPlaceholder:[dateFormatter stringFromDate:[NSDate date]]];
    [dateTextField setEnabled:NO];
    [_content addSubview:dateTextField];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(32, 420,640, 48)];
    [button addTarget:self action:@selector(selectedDate) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:button];

    weight = 0;
    height = 0;
    heightScrolled = NO;
    weightScrolled = NO;

    [self addRulerOfHeight];
    [self addRulerOFWeight];
    heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(288, 300, 80, 24)];
    [heightLabel setFont:PMFont1];
    [heightLabel setTextColor:PMColor1];
    [heightLabel setText:@"无记录"];
    [heightLabel setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:heightLabel];
    weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(544, 300, 80, 24)];
    [_content addSubview:weightLabel];
    [weightLabel setTextColor:PMColor1];
    [weightLabel setFont:PMFont1];
    [weightLabel setBackgroundColor:[UIColor clearColor]];
    [weightLabel setText:@"无记录"];
}

- (void)addRulerOFWeight
{
    rulerOfWeight = [[RulerScrollView alloc] initWithFrame:CGRectMake(400, 240, 112, 144)];
    [rulerOfWeight setRulerBackgroundColor:PMColor4];
    [rulerOfWeight setOverlayColor:[UIColor clearColor]];
    [rulerOfWeight setMinorTickLength:8];
    [rulerOfWeight setMinorTickWidth:1];
    [rulerOfWeight setMinorTickColor:PMColor1];
    [rulerOfWeight setMinorTicksPerMajorTick:2];
    [rulerOfWeight setMinorTickDistance:24];
    [rulerOfWeight setMajorTickWidth:1];
    [rulerOfWeight setMajorTickLength:32];
    [rulerOfWeight setMajorTickColor:PMColor1];
    [rulerOfWeight setPerminorTickExpression:0.5];
    [rulerOfWeight setLabelFont:PMFont3];
    [rulerOfWeight setLabelFillColor:PMColor1];
    [rulerOfWeight setShadowBlur:0.9f];
    [rulerOfWeight setShadowOffset:CGSizeMake(0, 1)];
    [rulerOfWeight setShadowColor:[UIColor colorWithRed:0.593 green:0.619 blue:0.643 alpha:1.000]];
    [rulerOfWeight setLabelStrokeWidth:0.1f];
    [rulerOfWeight setleadingOfBottom:72];
    [rulerOfWeight setleadingOfTop:72];
    [rulerOfWeight setDelegate:self];
    [rulerOfWeight setDialRangeFrom:2 to:50];
    weight = [[BabyData sharedBabyData ] selectWeightWithDate:[NSDate date]];
    NSArray *weights = [[BabyData sharedBabyData] weightArray];
    if ([weights count] == 0) {
        [rulerOfWeight setTheCurrentValue:2];
    }else{
        [rulerOfWeight setTheCurrentValue:[[[weights objectAtIndex:[weights count]-1] valueForKey:kBabyData_Weight] floatValue]];
    }
    
    [_content addSubview:rulerOfWeight];
    
}
- (void)addRulerOfHeight
{
    rulerOfHeight = [[RulerScrollView alloc] initWithFrame:CGRectMake(144, 240, 112, 144)];
    [rulerOfHeight setRulerBackgroundColor:PMColor4];
    [rulerOfHeight setOverlayColor:[UIColor clearColor]];
    [rulerOfHeight setMinorTickLength:8];
    [rulerOfHeight setMinorTickWidth:1];
    [rulerOfHeight setMinorTickColor:PMColor1];
    [rulerOfHeight setMinorTicksPerMajorTick:2];
    [rulerOfHeight setMinorTickDistance:24];
    [rulerOfHeight setMajorTickWidth:1];
    [rulerOfHeight setMajorTickLength:32];
    [rulerOfHeight setMajorTickColor:PMColor1];
    [rulerOfHeight setPerminorTickExpression:0.5];
    [rulerOfHeight setLabelFont:PMFont3];
    [rulerOfHeight setLabelFillColor:PMColor1];
    [rulerOfHeight setShadowBlur:0.9f];
    [rulerOfHeight setShadowOffset:CGSizeMake(0, 1)];
    [rulerOfHeight setShadowColor:[UIColor colorWithRed:0.593 green:0.619 blue:0.643 alpha:1.000]];
    [rulerOfHeight setLabelStrokeWidth:0.1f];
    [rulerOfHeight setleadingOfBottom:72];
    [rulerOfHeight setleadingOfTop:72];
    [rulerOfHeight setDelegate:self];
    
    [rulerOfHeight setDialRangeFrom:40 to:160];
    height = [[BabyData sharedBabyData] selectHeightWithDate:[NSDate date]];
    NSArray *heights = [[BabyData sharedBabyData] heightArray];
    if ([heights count]==0) {
        [rulerOfHeight setTheCurrentValue:40];
    }else{
        [rulerOfHeight setTheCurrentValue:[[[heights objectAtIndex:[heights count]-1] valueForKey:kBabyData_Height] floatValue]];
    }
    
    
    [_content addSubview:rulerOfHeight];
    
}

- (void)setControlBtnType:(ControlBtnType)controlBtnType
{
    [super setControlBtnType:controlBtnType];
    [_finishBtn setAlpha:0.5];
    [_finishBtn setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCurrentValue:(float)currentNumber andTheRuler:(RulerScrollView *)rulerScroll
{
    
    if (rulerScroll == rulerOfHeight) {
        
        if (heightScrolled) {
            height =currentNumber;
            [_finishBtn setAlpha:1];
            [_finishBtn setEnabled:YES];
            [heightLabel setText:[NSString stringWithFormat:@"%0.1f",currentNumber]];
        }else{
            if (height == 0) {
                [_finishBtn setAlpha:0.5];
                [_finishBtn setEnabled:NO];
                [heightLabel setText:@"无记录"];
            }else
            {
                [_finishBtn setAlpha:1];
                [_finishBtn setEnabled:YES];
                [heightLabel setText:[NSString stringWithFormat:@"%0.1f",currentNumber]];
            }
            
        }
        
        
    }
    if (rulerScroll == rulerOfWeight) {
        
        if (weightScrolled) {
            weight = currentNumber;
            [_finishBtn setAlpha:1];
            [_finishBtn setEnabled:YES];
            [weightLabel setText:[NSString stringWithFormat:@"%0.1f",currentNumber]];
        }else
        {
            
            if (weight ==0) {
                [_finishBtn setAlpha:0.5];
                [_finishBtn setEnabled:NO];
                [weightLabel setText:@"无记录"];
            }else
            {
                [_finishBtn setAlpha:1];
                [_finishBtn setEnabled:YES];
                [weightLabel setText:[NSString stringWithFormat:@"%0.1f",currentNumber]];
            }
        }
        
    }
}

- (void)beginScrollwithRuler:(RulerScrollView *)rulerScroll
{
    if (rulerScroll == rulerOfHeight) {
        heightScrolled = YES;
    }
    if (rulerScroll == rulerOfWeight) {
        weightScrolled = YES;
    }
    
    //[calendarView setAlpha:0];
}

- (void)selectedDate
{
   
    [self initWithCanlendar];
}

- (void)initWithCanlendar
{
    if (!calendarView) {
        [calendarView removeFromSuperview];
        calendarView = [[UIView alloc] initWithFrame:CGRectMake(120, 0, 300, 325)];
        [calendarView setBackgroundColor:PMColor4];
        AddInfoCalendar *calendar = [[AddInfoCalendar alloc] initWithFrame:CGRectMake(0, 5, 320, 320)];
        
        calendar.frame = CGRectMake(0, 5, 300, 320);
        calendar.delegate = self;
        
        [calendarView addSubview:calendar];
//        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(138, 320, 24, 23)];
//        [img setImage:[UIImage imageNamed: @"tri_login_diary.png"]];
//        img.transform=CGAffineTransformMakeRotation(M_PI);
        
      //  [calendarView addSubview:img];
    }
    [calendarView setAlpha:1];
    [self.view addSubview:calendarView];
    if ([MainTabBarController sharedMainViewController].isVertical) {
            SetViewLeftUp(calendarView, 234, 528);
    }else{
        SetViewLeftUp(calendarView, 362, 112);
    }
    
}

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    if (calendarView) {
        SetViewLeftUp(calendarView, 234, 528);
    }
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    if (calendarView) {
          SetViewLeftUp(calendarView, 362, 112);
    }
}

- (void)calendar:(AddInfoCalendar *)calendar selectedButton:(DateButton *)sender
{
    
    if ([calendar dateIsAvailable:sender.date]||[calendar dateIsToday:sender.date]) {
        sender.backgroundColor = calendar.selectedDateBackgroundColor;
        calendar.selectedDate = sender.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-M-d";
        dateTextField.text = [dateFormatter stringFromDate:sender.date];
        date = sender.date;
        [calendarView setAlpha:0];
    }else
    {
        dateTextField.text = @"请输入正确日期";
        calendar.selectedDate = nil;
        date = nil;
    }
    
}

- (void)finishBtnPressed
{
    if (calendarView) {
        [calendarView removeFromSuperview];
    }else
    {
        date = [NSDate date];
    }
    
    [[BabyData sharedBabyData] insertRecordAtDate:date height:height weight:weight];
       //save the file
    NSString *content = @"";
    if (weight !=0 ||height !=0) {
        
        content =[[StandardLine alloc] getNodeStringStandardwithDate:date andHeightValue:height andWeightValue:weight];
        
    }
    [MyNotiCenter postNotificationName:Noti_BabyDataUpdated object:nil];
    [DiaryFileManager saveText:content withPhoto:nil withTitle:@"宝宝成长记录"  andIsTopic:NO andBabyData:YES andTaskInfo:nil];
    [super finishBtnPressed];

}


@end
