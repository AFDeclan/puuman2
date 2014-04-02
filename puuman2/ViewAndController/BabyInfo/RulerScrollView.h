//
//  RulerView.h
//  puman
//
//  Created by 祁文龙 on 13-10-25.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RulerView.h"
@protocol RulerScrollDelegate;
@interface RulerScrollView : UIView  <UIScrollViewDelegate>
{
    RulerView *ruler;
    UIView *overlayView;
    UIScrollView *rulerscrollView;
    float min;
    float max;
    
    
}
@property (weak, nonatomic) id<RulerScrollDelegate> delegate;
@property (assign, nonatomic) float currentValue;

- (void)setRulerBackgroundColor:(UIColor *)backgroundColor;
- (void)setMinorTicksPerMajorTick:(NSInteger)minorTicksPerMajorTick;
- (void)setMinorTickDistance:(NSInteger)minorTickDistance;
- (void)setLabelStrokeColor:(UIColor *)labelStrokeColor;
- (void)setLabelFillColor:(UIColor *)labelFillColor;
- (void)setLabelStrokeWidth:(CGFloat)labelStrokeWidth;
- (void)setLabelFont:(UIFont *)labelFont;
- (void)setMinorTickColor:(UIColor *)minorTickColor;
- (void)setMinorTickLength:(CGFloat)minorTickLength;
- (void)setMinorTickWidth:(CGFloat)minorTickWidth;
- (void)setMajorTickColor:(UIColor *)majorTickColor;
- (void)setMajorTickLength:(CGFloat)majorTickLength;
- (void)setMajorTickWidth:(CGFloat)majorTickWidth;
- (void)setShadowColor:(UIColor *)shadowColor;
- (void)setShadowOffset:(CGSize)shadowOffset;
- (void)setShadowBlur:(CGFloat)shadowBlur;
- (void)setOverlayColor:(UIColor *)overlayColor;
- (void)setTheCurrentValue:(float)newValue;
- (void)setleadingOfBottom:(float)leading;
- (void)setleadingOfTop:(float)leading;
- (void)setPerminorTickExpression:(float)perExpression;
- (void)setDialRangeFrom:(float)from to:(float)to;
@end
@protocol RulerScrollDelegate <NSObject>
@optional
- (void)setCurrentValue:(float)currentNumber andTheRuler:(RulerScrollView *)rulerScroll;
- (void)beginScrollwithRuler:(RulerScrollView *)rulerScroll;
@end