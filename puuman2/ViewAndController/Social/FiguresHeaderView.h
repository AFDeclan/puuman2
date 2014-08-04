//
//  FiguresHeaderView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "AnimateShowLabel.h"
#import "Group.h"
#import "Friend.h"
#import "FigureHeaderCell.h"

@interface FiguresHeaderView : UIView<UIColumnViewDataSource, UIColumnViewDelegate,FriendDelegate,UITextFieldDelegate,FigureHeaderDelegate>
{
    
    BOOL managing;

    UIView *headerView;
    UIView *contentView;
    
    UIView *header_bg;
    UIButton *manageBtn;
    UIButton *backBtn;
    UITextField *nameTextField;
    
    Group *myGroup;
    
    NSString *oldName;
    BOOL changed;
    UIColumnView *figuresColumnView;

}

- (void)reloadGroupInfo;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
