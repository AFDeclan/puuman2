//
//  CircleProgress.h
//  puman
//
//  Created by 祁文龙 on 13-10-15.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgress : UIView
@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic, assign) float progress;
@end
