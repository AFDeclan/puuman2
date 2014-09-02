//
//  LineChartView.h
//  puman
//
//  Created by 祁文龙 on 13-10-22.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoView.h"


@interface LineChart : UIView
{
    
    BOOL isHeight;
    UILabel *dateLabel;
    UIView *currentPosView;
    InfoView *infoView;
    NSMutableArray *points;
    UILabel *nodeLabel;
    NSArray *records;
    NSInteger recordIndex;
   
}
- (void)setViewType:(BOOL)height andData:(NSArray *)data;
@end

