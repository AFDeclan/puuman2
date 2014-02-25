//
//  AFPageControl.h
//  AFUIEx
//
//  Created by Declan on 14-1-15.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFPageControl : UIView
{
}

//自定义颜色
@property (retain, nonatomic) UIColor *tintColor;
@property (retain, nonatomic) UIColor *curTintColor;

//自定义大小及间距
@property (assign, nonatomic) CGSize pointSize;
@property (assign, nonatomic) CGFloat pointDis;

@property (assign, nonatomic) BOOL autoAdjustSize;

@property (retain, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) BOOL verticalScroll;

@property (assign, nonatomic) NSInteger numberOfPages;
@property (assign, nonatomic) NSInteger currentPage;

@property (assign, nonatomic) BOOL hidesForSinglePage;

@end
