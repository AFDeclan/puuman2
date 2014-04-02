//
//  WarePumanScrollView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-2-15.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "WarePumanScrollView.h"

@implementation WarePumanScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [ruler setShowMinorLabel:YES];
    }
    return self;
}
- (void)setDialScrollRangeFrom:(float)from To:(float)to
{
    rangeFrom = from;
    rangeTo = to;
    CGRect frame = ruler.frame;
    frame.origin.y -= (max*ruler.minorTicksPerMajorTick - (int)rangeTo)*ruler.minorTickDistance;
    [ruler setFrame:frame];
    [rulerscrollView setContentSize:CGSizeMake(self.frame.size.width, (int)rangeTo*ruler.minorTickDistance+ruler.leadingBottom +ruler.leadingTop)];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGPoint pos = [scrollView contentOffset];
    self.currentValue = (int)rangeTo-pos.y/(ruler.minorTickDistance);
    [self.delegate setCurrentValue:(int)self.currentValue andTheRuler:self];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGPoint pos = [scrollView contentOffset];
        pos.y =  ((int)(pos.y /(ruler.minorTickDistance) + 0.5))*(ruler.minorTickDistance);
        [scrollView setContentOffset:pos animated:YES];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGPoint pos = [scrollView contentOffset];
    pos.y =  ((int)(pos.y /(ruler.minorTickDistance) + 0.5))*(ruler.minorTickDistance);
    [scrollView setContentOffset:pos animated:YES];
}

- (void)setTheCurrentValue:(float)newValue
{
    
    self.currentValue = newValue;
    CGPoint offset = rulerscrollView.contentOffset;
    offset.y = ((int)rangeTo -newValue)* ruler.minorTickDistance;
    rulerscrollView.contentOffset = offset;
    [self.delegate setCurrentValue:self.currentValue andTheRuler:self];
    
}


@end
