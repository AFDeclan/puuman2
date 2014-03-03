//
//  PopUpViewController.h
//  puuman2
//
//  Created by Declan on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AFAnimation.h"


@interface PopUpViewController : UIViewController
{
    UIView *_subview;
}

@property (nonatomic, assign) AFAnimationDirection animationType;
+ (void)showOnView:(UIView *)view animationType:(AFAnimationDirection)type;
@end
