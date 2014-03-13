//
//  RulerView.m
//  puman
//
//  Created by 祁文龙 on 13-10-25.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "RulerScrollView.h"

@implementation RulerScrollView
@synthesize currentValue = _currentValue;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float contentWidth = self.bounds.size.width;
        overlayView = [[UIView alloc] initWithFrame:self.bounds];
        [overlayView setUserInteractionEnabled:NO];
        
        ruler = [[RulerView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, self.bounds.size.height)];
        
        // Don't let the container handle User Interaction
        [ruler setUserInteractionEnabled:NO];
        rulerscrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        // Disable scroll bars
        [rulerscrollView setShowsHorizontalScrollIndicator:NO];
        [rulerscrollView setClipsToBounds:YES];
        rulerscrollView.contentSize = CGSizeMake(contentWidth,ruler.frame.size.height);
        
        
        // Setup the ScrollView
        [rulerscrollView setBounces:NO];
        [rulerscrollView setBouncesZoom:NO];
         rulerscrollView.delegate = self;
        [rulerscrollView setShowsHorizontalScrollIndicator:NO];
        [rulerscrollView setShowsVerticalScrollIndicator:NO];
        [rulerscrollView addSubview:ruler];
        [self addSubview:rulerscrollView];
        [self addSubview:overlayView];
         self.clipsToBounds = YES;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [rulerscrollView addGestureRecognizer:recognizer];

        
    }
    return self;
}
-(void)tap
{
     [delegate beginScrollwithRuler:self];
     [delegate setCurrentValue:_currentValue andTheRuler:self];
}
- (void)setRulerBackgroundColor:(UIColor *)backgroundColor
{
    ruler.rulerBackgroundColor = backgroundColor;
}

- (void)setMinorTicksPerMajorTick:(NSInteger)minorTicksPerMajorTick
{
    ruler.minorTicksPerMajorTick = minorTicksPerMajorTick;
}
- (void)setMinorTickDistance:(NSInteger)minorTickDistance
{
    ruler.minorTickDistance =minorTickDistance;
}
- (void)setLabelStrokeColor:(UIColor *)labelStrokeColor
{
    ruler.labelStrokeColor = labelStrokeColor;
}
- (void)setLabelFillColor:(UIColor *)labelFillColor
{
    ruler.labelFillColor = labelFillColor;
}
- (void)setLabelStrokeWidth:(CGFloat)labelStrokeWidth
{
    ruler.labelStrokeWidth = labelStrokeWidth;
}
- (void)setLabelFont:(UIFont *)labelFont
{
    ruler.labelFont = labelFont;
}
- (void)setMinorTickColor:(UIColor *)minorTickColor
{
    ruler.minorTickColor = minorTickColor;
}
- (void)setMinorTickLength:(CGFloat)minorTickLength
{
    ruler.minorTickLength = minorTickLength;
}
- (void)setMinorTickWidth:(CGFloat)minorTickWidth
{
    ruler.minorTickWidth = minorTickWidth;
}
- (void)setMajorTickColor:(UIColor *)majorTickColor
{
    ruler.majorTickColor =majorTickColor;
}
- (void)setMajorTickLength:(CGFloat)majorTickLength
{
    ruler.majorTickLength = majorTickLength;
}
- (void)setMajorTickWidth:(CGFloat)majorTickWidth
{
    ruler.majorTickWidth = majorTickWidth;
}
- (void)setShadowColor:(UIColor *)shadowColor
{
    ruler.shadowColor =shadowColor;
}
- (void)setShadowOffset:(CGSize)shadowOffset
{
    ruler.shadowOffset = shadowOffset;
}
- (void)setShadowBlur:(CGFloat)shadowBlur
{
    ruler.shadowBlur = shadowBlur;
}
- (void)setOverlayColor:(UIColor *)overlayColor
{
    overlayView.backgroundColor = overlayColor;
}
- (void)setTheCurrentValue:(float)newValue
{
    
    self.currentValue = newValue;
    if ((newValue < min) || (newValue > max))
        _currentValue = min;
    else
        _currentValue = newValue;
    
    CGPoint offset = rulerscrollView.contentOffset;
    offset.y = (max- _currentValue) * ruler.minorTickDistance*ruler.minorTicksPerMajorTick;
    
    rulerscrollView.contentOffset = offset;
   
    [delegate setCurrentValue:_currentValue andTheRuler:self];
    
}
- (void)setleadingOfBottom:(float)leading;
{
    ruler.leadingBottom = leading;
}
- (void)setleadingOfTop:(float)leading
{
    ruler.leadingTop = leading;
}
- (void)setPerminorTickExpression:(float)perExpression
{
    ruler.perminorTickExpression = perExpression;
}
- (void)setDialRangeFrom:(float)from to:(float)to
{
    min = from;
    max = to;
    [ruler setDialRangeFrom:from to:to];
    rulerscrollView.contentSize = CGSizeMake(self.bounds.size.width, ruler.frame.size.height);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pos = [scrollView contentOffset];
    _currentValue = max-pos.y/(ruler.minorTickDistance*ruler.minorTicksPerMajorTick);
    [delegate setCurrentValue:_currentValue andTheRuler:self];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [delegate beginScrollwithRuler:self];
}



@end
