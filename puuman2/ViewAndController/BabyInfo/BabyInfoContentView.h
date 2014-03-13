//
//  BabyInfoContentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyInfoPageControlButton.h"
@interface BabyInfoContentView : UIScrollView
{
    UIView *leftView;
    UIView *rightView;
    BabyInfoPageControlButton *showAndHiddenBtn;
}
- (void)fold;
- (void)unfold;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;
@end
