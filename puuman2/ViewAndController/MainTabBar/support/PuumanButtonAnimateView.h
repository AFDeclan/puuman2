//
//  PuumanButtonAnimateView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-26.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PuumanAnimateDelegate;
@interface PuumanButtonAnimateView : UIView
{
}
@property(nonatomic, strong)UIColor *strokeColor;
@property(nonatomic, strong)UIColor *fillColor;
@property(nonatomic, assign)CGFloat radiusPercent;
@property(nonatomic, assign)CGFloat animationDuration;
@property(nonatomic, assign)id<PuumanAnimateDelegate> delegate;
- (void)loadIndicator;
- (void)updateWithTotalBytes:(CGFloat)bytes downloadedBytes:(CGFloat)downloadedBytes;

@end
@protocol PuumanAnimateDelegate <NSObject>

- (void)animateFinished;

@end