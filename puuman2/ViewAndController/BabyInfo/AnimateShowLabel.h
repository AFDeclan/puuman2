//
//  AnimateShowLabel.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-2-10.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimateShowLabel : UIView
{
        UILabel *title_First;
        UILabel *title_Second;
        NSString *title_Name;
        NSTimer *animationTimer;
        float _speed;
        BOOL canMove;
}
- (void)setTitleWithTitleText:(NSString *)title andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font andMoveSpeed:(float)speed andIsAutomatic:(BOOL)automatic;
- (void)animateStart;
- (void)animateStop;
- (void)animateRestart;
@end
