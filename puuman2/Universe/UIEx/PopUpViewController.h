//
//  PopUpViewController.h
//  puuman2
//
//  Created by Declan on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum PopUpAnimationType {
    PopUpAnimationType_slide,
    PopUpAnimationType_fade
} PopUpAnimationType;

@interface PopUpViewController : UIViewController
{
    UIView *_subview;
}

@property (nonatomic, assign) PopUpAnimationType animationType;
@property (nonatomic, assign) CGPoint toPos;

+ (void)showOnView:(UIView *)view animationType:(PopUpAnimationType)type;
+ (void)showOnView:(UIView *)view toPos:(CGPoint)pos animationType:(PopUpAnimationType)type;

@end
