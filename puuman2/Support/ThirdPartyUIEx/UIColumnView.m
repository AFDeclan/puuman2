//
//  UIColumnView.m
//  iProduct
//
//  Created by Hager Hu on 5/23/11.
//  Copyright 2011 dreamblock.net. All rights reserved.
//

#import "UIColumnView.h"


@implementation UIColumnView


@synthesize itemDataList;


- (void)setViewDelegate:(id<UIColumnViewDelegate>)delegate
{
    viewDelegate = delegate;
}

- (void)setViewDataSource:(id<UIColumnViewDataSource>)dataSource
{
    viewDataSource = dataSource;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        onScreenViewDic = [[NSMutableDictionary alloc] init];
        offScreenViewDic = [[NSMutableDictionary alloc] init];
        
        originPointList = [[NSMutableArray alloc] init];
        
        numberOfColumns = 0;
        self.delegate=self;
        startIndex = 0;
        endIndex = 0;
    }
    
    return self;
}

- (void)initForXib {
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    onScreenViewDic = [[NSMutableDictionary alloc] init];
    offScreenViewDic = [[NSMutableDictionary alloc] init];
    
    originPointList = [[NSMutableArray alloc] init];
    
    numberOfColumns = 0;
    self.delegate=self;
    startIndex = 0;
    endIndex = 0;

    
}

#pragma mark -
#pragma mark Public method implementation

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    if ([[offScreenViewDic allKeys] containsObject:identifier]) {
    	NSMutableSet *cacheSet = (NSMutableSet *)[offScreenViewDic objectForKey:identifier];
        id reused = [cacheSet anyObject];
        if (reused != nil) {
//            [[reused retain] autorelease];
            [cacheSet removeObject:reused];
            
            return (UITableViewCell *)reused;
        }
    }
    
    return nil;
}
- (UITableViewCell *)cellForIndex:(NSInteger)index
{
    return    [onScreenViewDic objectForKey:[NSNumber numberWithInt:index]];
}

#pragma mark -

- (float)contentSizeWidth {
    float width = 0.0;
    numberOfColumns = viewDataSource == nil ? 0 : [viewDataSource numberOfColumnsInColumnView:self];
    for (int i = 0; i < numberOfColumns; i++) {
        float itemWidth = [viewDelegate columnView:self widthForColumnAtIndex:i];
        width += itemWidth;
    }
    //NSLog(@"content size: %f", width);
    
    return width;
}


- (void)calculateAllItemsOrigin {
    [originPointList removeAllObjects];
    float viewOrigin = 0;
    for (int i = 0; i < numberOfColumns; i++) {
        [originPointList addObject:[NSNumber numberWithFloat:viewOrigin]];
        viewOrigin += [viewDelegate columnView:self widthForColumnAtIndex:i];
    }
}


- (void)reloadData {
    
    /*for (NSNumber *key in [onScreenViewDic allKeys]) {
        if (1) {
            UITableViewCell *cell = [onScreenViewDic objectForKey:key];
            [onScreenViewDic removeObjectForKey:key];
            [cell removeFromSuperview];
        }
    }*/
    onScreenViewDic = [[NSMutableDictionary alloc] init];
    offScreenViewDic = [[NSMutableDictionary alloc] init];
    
    originPointList = [[NSMutableArray alloc] init];
    
    numberOfColumns = 0;
    self.delegate=self;
    startIndex = 0;
    endIndex = 0;
    self.contentSize = CGSizeMake(0, 0);

//    numberOfColumns = viewDataSource == nil ? 0: [viewDataSource numberOfColumnsInColumnView:self];
//    
//    self.contentSize = CGSizeMake([self contentSizeWidth], self.bounds.size.height);
//    
//    [self calculateAllItemsOrigin];
    
    [self layoutSubviews];
}


- (void)calculateItemIndexRange {
    float lowerBound = MAX(self.contentOffset.x, 0);
    float upperBound = MIN(self.contentOffset.x + self.bounds.size.width, self.contentSize.width);
    //NSLog(@"lowerBound:%f upperBound:%f", lowerBound, upperBound);
    endIndex = -1;
    for (int i = 0; i < numberOfColumns; i++) {
        if ([[originPointList objectAtIndex:i] floatValue] <= lowerBound) {
            startIndex = i;
        }
        
        if ([[originPointList objectAtIndex:i] floatValue] < upperBound) {
            endIndex = i;
        }
    }
    
}


- (void)addSubviewsOnScreen {
    [self calculateAllItemsOrigin];
    [self calculateItemIndexRange];
	
    for (NSNumber *key in [onScreenViewDic allKeys]) {
        if ([key intValue] < startIndex || [key intValue] > endIndex) {
            UITableViewCell *cell = [onScreenViewDic objectForKey:key];
            
            if ([[offScreenViewDic allKeys] containsObject:cell.reuseIdentifier]) {
                NSMutableSet *viewSet = [offScreenViewDic objectForKey:cell.reuseIdentifier];
                [viewSet addObject:cell];
            }else {
                NSMutableSet *newSet = [NSMutableSet setWithObject:cell];
                [offScreenViewDic setObject:newSet forKey:cell.reuseIdentifier];
            }
            
            [onScreenViewDic removeObjectForKey:key];
            [cell removeFromSuperview];
        }
    }
    
    if (numberOfColumns == 0) {
        return;
    }
    
    for (int i = startIndex; i < endIndex + 1; i++) {
        if (![[onScreenViewDic allKeys] containsObject:[NSNumber numberWithInt:i]]) {
            UITableViewCell *viewCell = [viewDataSource columnView:self viewForColumnAtIndex:i];
            [onScreenViewDic setObject:viewCell forKey:[NSNumber numberWithInt:i]];
            
            float viewWidth = [viewDelegate columnView:self widthForColumnAtIndex:i];
            float viewOrigin = [[originPointList objectAtIndex:i] floatValue];
            viewCell.frame = CGRectMake(viewOrigin, 0, viewWidth, self.bounds.size.height);
            [self addSubview:viewCell];
        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //NSLog(@"%s", __FUNCTION__);
    
    if (numberOfColumns == 0) {
    	numberOfColumns = viewDataSource == nil ? 0: [viewDataSource numberOfColumnsInColumnView:self];
    }
    //NSLog(@"column count:%d", numberOfColumns);
    
    if (self.contentSize.width == 0) {
        self.contentSize = CGSizeMake([self contentSizeWidth], self.bounds.size.height);
    }
    
    if ([originPointList count] == 0 && numberOfColumns != 0) {
        [self calculateAllItemsOrigin];
    }
    
    [self addSubviewsOnScreen];
}


#pragma mark -
#pragma mark UIScrollViewDelegate method implementation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    
    self.contentOffset = scrollView.contentOffset;
    if ([viewDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [viewDelegate scrollViewDidScroll:self];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([viewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
            [viewDelegate scrollViewDidEndDecelerating:self];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([viewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [viewDelegate scrollViewDidEndDragging:self willDecelerate:decelerate];
}


#pragma mark -
#pragma mark UIEvent Handle method

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    if (event.type == UIEventTypeTouches) {
        UITouch *touch = (UITouch *)[touches anyObject];
        
       	CGPoint point = [touch locationInView:self];
//        NSLog(@"point in self:%@", NSStringFromCGPoint(point));
        
        float viewWidth = 0;
        for (int i = 0; i < [viewDataSource numberOfColumnsInColumnView:self]; i++) {
            if (viewWidth < point.x &&
                (viewWidth + [viewDelegate columnView:self widthForColumnAtIndex:i]) > point.x) {
                [viewDelegate columnView:self didSelectColumnAtIndex:i];
                break;
            }else {
                viewWidth += [viewDelegate columnView:self widthForColumnAtIndex:i];
            }
            
        }
    }
    
    return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [onScreenViewDic removeAllObjects];
    [offScreenViewDic removeAllObjects];
    
//    [onScreenViewDic release];
    onScreenViewDic = nil;
//    [offScreenViewDic release];
    offScreenViewDic = nil;
    
//    [itemDataList release];
    itemDataList = nil;
//    [originPointList release];
    originPointList = nil;
    
//    [super dealloc];
}


@end
