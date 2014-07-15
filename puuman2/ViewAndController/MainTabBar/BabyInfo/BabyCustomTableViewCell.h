//
//  BabyCustomTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePageControlButton.h"

@interface BabyCustomTableViewCell : UITableViewCell
{
    
    UIView *leftView;
    UIView *rightView;
    ChangePageControlButton *showAndHiddenBtn;
}

- (void)fold;
- (void)unfold;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;

@end
