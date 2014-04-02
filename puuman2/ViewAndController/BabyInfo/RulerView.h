//
//  ScaleView.h
//  puman
//
//  Created by 祁文龙 on 13-10-25.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsAndFonts.h"
@interface RulerView : UIView 
{

}
- (void)setDialRangeFrom:(float)from to:(float)to;
@property (assign, nonatomic) BOOL showMinorLabel;
@property (assign, nonatomic) float leadingTop;
@property (assign, nonatomic) float leadingBottom;
@property (assign, readonly, nonatomic) float minimum;
@property (assign, readonly, nonatomic) float maximum;
@property (assign, nonatomic) float currentValue;
@property (strong, nonatomic) UIColor *rulerBackgroundColor;
//主刻度
@property (strong, nonatomic) UIFont *labelFont;
@property (strong, nonatomic) UIColor *labelFillColor;
@property (strong, nonatomic) UIColor *labelStrokeColor;
@property (assign, nonatomic) CGFloat labelStrokeWidth;

@property (assign, nonatomic) CGFloat majorTickLength;
@property (assign, nonatomic) CGFloat majorTickWidth;
@property (strong, nonatomic) UIColor *majorTickColor;
//最小刻度
@property (assign, nonatomic) float perminorTickExpression;
@property (assign, nonatomic) float minorTicksPerMajorTick;
@property (assign, nonatomic) float minorTickDistance;
@property (strong, nonatomic) UIColor *minorTickColor;
@property (assign, nonatomic) CGFloat minorTickLength;
@property (assign, nonatomic) CGFloat minorTickWidth;
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) CGSize shadowOffset;
@property (assign, nonatomic) CGFloat shadowBlur;

@end
