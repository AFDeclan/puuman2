//
//  AFPageControl.m
//  PuumanForPhone
//
//  Created by Declan on 14-1-15.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "AFPageControl.h"
#import <QuartzCore/QuartzCore.h>

@implementation AFPageControl

@synthesize pointSize = _pointSize;
@synthesize pointDis = _pointDis;
@synthesize tintColor = _tintColor;
@synthesize curTintColor = _curTintColor;
@synthesize scrollView = _scrollView;
@synthesize verticalScroll = _verticalScroll;
@synthesize autoAdjustSize = _autoAdjustSize;
@synthesize numberOfPages = _numberOfPages;
@synthesize currentPage = _currentPage;
@synthesize hidesForSinglePage = _hidesForSinglePage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _verticalScroll = NO;
        _autoAdjustSize = YES;
        _hidesForSinglePage = YES;
        _pointDis = 16;
        _pointSize = CGSizeMake(6, 6);
        _tintColor = [UIColor colorWithWhite:177/255.0 alpha:1];
        _curTintColor = [UIColor colorWithWhite:74/255.0 alpha:1];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    NSArray *subviews = self.subviews;
    if (subviews.count < numberOfPages)
        for (int i=subviews.count; i<numberOfPages; i++)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _pointSize.width, _pointSize.height)];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = MIN(_pointSize.width, _pointSize.height)/2;
            [self addSubview:view];
        }
    else if (subviews.count > numberOfPages)
        for (int i=0; i<subviews.count-numberOfPages; i++)
            [[subviews objectAtIndex:i] removeFromSuperview];
    for (int i=0; i<numberOfPages; i++)
    {
        UIView *subview = [[self subviews] objectAtIndex:i];
        subview.backgroundColor = (i == _currentPage)? _curTintColor : _tintColor;
    }
    [self adjustFrame];
    self.hidden = (numberOfPages == 1);
}

- (void)adjustFrame
{
    if (_autoAdjustSize)
    {
        CGFloat width = _pointDis * (_numberOfPages-1) + 4 * _pointSize.width;
        [self setBounds:CGRectMake(0, 0, width, self.bounds.size.height)];
    }
    for (int i=0; i<_numberOfPages; i++)
    {
        UIView *pointView = [self.subviews objectAtIndex:i];
        CGFloat cx = self.bounds.size.width/2;
        CGFloat cy = self.bounds.size.height/2;
        pointView.center = CGPointMake(cx + (i-(CGFloat)(_numberOfPages-1)/2)*_pointDis, cy);
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (currentPage < 0 || currentPage >= _numberOfPages || currentPage == _currentPage) return;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.2;
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"imageFade"];
    UIView *oldPoint = [self.subviews objectAtIndex:_currentPage];
    oldPoint.backgroundColor = _tintColor;
    UIView *newPoint = [self.subviews objectAtIndex:currentPage];
    newPoint.backgroundColor = _curTintColor;
    _currentPage = currentPage;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    // 移除之前的监听器
    [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    // 监听contentOffset
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _scrollView = scrollView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.alpha <= 0.01 || self.hidden) return;
    
    CGFloat offsetY = _scrollView.contentOffset.y;
    CGFloat offsetX = _scrollView.contentOffset.x;
    NSInteger pageNum;
    CGFloat offsetToPage;
    if (_verticalScroll)
    {
        pageNum = offsetY / _scrollView.frame.size.height;
        offsetToPage = offsetY - pageNum * _scrollView.frame.size.height;
    }
    else
    {
        pageNum = offsetX / _scrollView.frame.size.width;
        offsetToPage = offsetX - pageNum * _scrollView.frame.size.width;
    }
    if (ABS(offsetToPage) < 2) [self setCurrentPage:pageNum];
}

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}


@end
