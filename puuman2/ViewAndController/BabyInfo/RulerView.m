//
//  ScaleView.m
//  puman
//
//  Created by 祁文龙 on 13-10-25.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "RulerView.h"

const NSInteger kTRSDialViewDefautLabelFontSize = 30;

const CGFloat kTRSDialViewDefaultMinorTickDistance = 16.0f;
const CGFloat kTRSDialViewDefaultMinorTickLength   = 19.0f;
const CGFloat KTRSDialViewDefaultMinorTickWidth    =  1.0f;

const NSInteger kTRSDialViewDefaultMajorTickDivisions = 10;
const CGFloat kTRSDialViewDefaultMajorTickLength      = 31.0f;
const CGFloat kTRSDialViewDefaultMajorTickWidth       = 4.0f;

@implementation RulerView
@synthesize minimum = _minimum;
@synthesize labelFillColor = _labelFillColor;
@synthesize leadingTop = _leadingTop;
@synthesize leadingBottom =_leadingBottom;
@synthesize majorTickColor = _majorTickColor;
@synthesize majorTickLength = _majorTickLength;
@synthesize majorTickWidth = _majorTickWidth;
@synthesize maximum = _maximum;
@synthesize labelFont = _labelFont;
@synthesize labelStrokeColor = _labelStrokeColor;
@synthesize labelStrokeWidth = _labelStrokeWidth;
@synthesize rulerBackgroundColor =_rulerBackgroundColor;
@synthesize minorTickColor =_minorTickColor;
@synthesize minorTickDistance = _minorTickDistance;
@synthesize minorTickLength = _minorTickLength;
@synthesize minorTicksPerMajorTick = _minorTicksPerMajorTick;
@synthesize minorTickWidth = _minorTickWidth;
@synthesize shadowBlur = _shadowBlur;
@synthesize shadowColor =_shadowColor;
@synthesize shadowOffset = _shadowOffset;
@synthesize perminorTickExpression = _perminorTickExpression;
@synthesize currentValue = _currentValue;
@synthesize showMinorLabel =_showMinorLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _minimum = 0;
        _maximum = 0;
        _minorTicksPerMajorTick = kTRSDialViewDefaultMajorTickDivisions;
        _minorTickDistance = kTRSDialViewDefaultMinorTickDistance;
        
        _rulerBackgroundColor = [UIColor grayColor];
        _perminorTickExpression = 1;
        _labelStrokeColor = [UIColor colorWithRed:0.482 green:0.008 blue:0.027 alpha:1.000];
        _labelFillColor = [UIColor whiteColor];
        _labelStrokeWidth = 1.0;
        _labelFont = PMFont3;
        _showMinorLabel = NO;
        _minorTickColor = [UIColor colorWithWhite:0.158 alpha:1.000];
        _minorTickLength = kTRSDialViewDefaultMinorTickLength;
        _minorTickWidth = KTRSDialViewDefaultMinorTickWidth;
        
        _majorTickColor = [UIColor colorWithRed:0.482 green:0.008 blue:0.027 alpha:1.000];
        _majorTickLength = kTRSDialViewDefaultMajorTickLength;
        _majorTickWidth = kTRSDialViewDefaultMajorTickWidth;
        
        _shadowColor = [UIColor colorWithWhite:1.000 alpha:1.000];
        _shadowOffset = CGSizeMake(1, 1);
        _shadowBlur = 0.9f;

    }
    return self;
}
- (void)setDialRangeFrom:(float)from to:(float)to
{
    _minimum = from;
    _maximum = to;
    CGRect frame = self.frame;
    frame.size.height = (_maximum - _minimum)*_minorTicksPerMajorTick * _minorTickDistance + _leadingBottom +_leadingTop;
    self.frame = frame;
}
- (void)drawLabelWithContext:(CGContextRef)context
                     atPoint:(CGPoint)point
                        text:(NSString *)text
                   fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor {
    
    CGSize boundingBox = [text sizeWithFont:self.labelFont];
    
     CGFloat label_y_offset = (boundingBox.height / 2);

    NSInteger label_x = point.x - boundingBox.width-16;
    
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    
    CGContextSetLineWidth(context, self.labelStrokeWidth);
    
    // Set the drawing mode based on the presence of the file and stroke colors
    CGTextDrawingMode mode = kCGTextFillStroke;
    
    if ((fillColor == nil) && (strokeColor == nil))
        mode = kCGTextInvisible;
    
    else if (fillColor == nil)
        mode = kCGTextStroke;
    
    else if (strokeColor == nil)
        mode = kCGTextFill;
    
    CGContextSetTextDrawingMode(context, mode);
    
    [text drawInRect:CGRectMake(label_x , point.y-label_y_offset, boundingBox.width, boundingBox.height)
            withFont:self.labelFont
       lineBreakMode:NSLineBreakByTruncatingTail
           alignment:NSTextAlignmentCenter];
    
}
- (void)drawMinorTickWithContext:(CGContextRef)context
                         atPoint:(CGPoint)point
                       withColor:(UIColor *)color
                           width:(CGFloat)width
                          length:(CGFloat)length {
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x - length, point.y );
    
    CGContextStrokePath(context);
}
- (void)drawMajorTickWithContext:(CGContextRef)context
                         atPoint:(CGPoint)point
                       withColor:(UIColor *)color
                           width:(CGFloat)width
                          length:(CGFloat)length {
    
    // Draw the line
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x -length, point.y );
    CGContextStrokePath(context);
    
}
- (void)drawTicksWithContext:(CGContextRef)context atY:(int)y
{
    
    CGPoint point = CGPointMake(self.frame.size.width, y);
    
    CGContextSetShadowWithColor(
                                context,
                                self.shadowOffset,
                                self.shadowBlur,
                                self.shadowColor.CGColor);
    
    if ([self isMajorTick:y]) {
        
        [self drawMajorTickWithContext:context
                               atPoint:point
                             withColor:self.majorTickColor
                                 width:self.majorTickWidth
                                length:self.majorTickLength];
        
        int value = (self.frame.size.height-_leadingBottom-y)*self.perminorTickExpression/ self.minorTickDistance + _minimum;
        
         point.x -= _majorTickLength;
        
         NSString *text = [NSString stringWithFormat:@"%d", value];
        [self drawLabelWithContext:context
                           atPoint:point
                              text:text
                         fillColor:self.labelFillColor
                       strokeColor:self.labelStrokeColor];
        
    } else {
        
        // Save the current context so we revert some of the changes laster
        CGContextSaveGState(context);
        
        [self drawMinorTickWithContext:context
                               atPoint:point
                             withColor:self.minorTickColor
                                 width:self.minorTickWidth
                                length:self.minorTickLength];
        if (_showMinorLabel) {
            int value = (self.frame.size.height-_leadingBottom-y)*self.perminorTickExpression/ self.minorTickDistance + _minimum;
            
            point.x -= _minorTickLength;
            
            NSString *text = [NSString stringWithFormat:@"%d", value];
            [self drawLabelWithContext:context
                               atPoint:point
                                  text:text
                             fillColor:self.labelFillColor
                           strokeColor:self.labelStrokeColor];
        }

        // Restore the context
        CGContextRestoreGState(context);
    }
}
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, self.rulerBackgroundColor.CGColor);
    
    CGContextFillRect(context, rect);
    for (int i = rect.size.height-_leadingBottom; i> _leadingTop-_labelFont.xHeight; i -= self.minorTickDistance)
    {
        
            [self drawTicksWithContext:context atY:i];
    }
}
- (BOOL)isMajorTick:(int)y {
    
    if (y == (int)y) {
    int tick_number = (self.frame.size.height-y - _leadingBottom) / self.minorTickDistance;
    
    return (tick_number % (int)self.minorTicksPerMajorTick) == 0;
    }
    return NO;
}
@end
