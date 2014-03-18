//
//  LineChartView.m
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-17.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "LineChartView.h"
#import "BabyData.h"
#import "ColorsAndFonts.h"

@implementation LineChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 544, 408)];
        [bgImgView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:bgImgView];
       
        [self setBackgroundColor:[UIColor whiteColor]];
        nodataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [nodataLabel setTextAlignment:NSTextAlignmentCenter];
        [nodataLabel setBackgroundColor:[UIColor clearColor]];
        [nodataLabel setNumberOfLines:2];
        [nodataLabel setFont:PMFont4];
        [nodataLabel setTextColor:PMColor3];
        [self addSubview:nodataLabel];
        
        
    }
    return self;
}
- (void)initWithHeightType:(BOOL)isHeight
{
    NSArray *data ;
    if (lineChart) {
        [lineChart removeFromSuperview];
    }
    lineChart = [[LineChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [lineChart setBackgroundColor:[UIColor clearColor]];
    [self addSubview:lineChart];
    if (isHeight) {
          data = [[BabyData sharedBabyData] heightArray];
    }else{
          data = [[BabyData sharedBabyData] weightArray];
    }
  
    if ([data count] == 0) {
        //[bgImgView setAlpha:0];
        [lineChart setAlpha:0];
        [nodataLabel setAlpha:1];
        [nodataLabel setText:@"想添加记录？\n点击右下方的按钮即可"];

    }else{
        //[bgImgView setAlpha:1];
        [lineChart setAlpha:1];
        [nodataLabel setAlpha:0];
        [lineChart setViewType:isHeight andData:data];
    }
    
    if (isHeight) {
        [bgImgView setImage:[UIImage imageNamed:@"chart_hei_baby_diary.png"]];
    }else{
        [bgImgView setImage:[UIImage imageNamed:@"chart_wei_baby_diary.png"]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
