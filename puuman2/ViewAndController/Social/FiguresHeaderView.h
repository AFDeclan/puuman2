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
@interface FiguresHeaderView : UIView<UIColumnViewDataSource, UIColumnViewDelegate,FriendDelegate,UITextFieldDelegate>
{
    UIView *bgHeadView;
    UIView *icon_headUp;
    UIView *icon_headDown;
    UITextField *info_title;
    UIColumnView *figuresColumnView;
    Group *myGroup;
    BOOL canDeleteMember;
    NSString *oldName;
    NSString *notiStr;
    BOOL changed;

}

- (void)reloadWithGroupInfo:(Group *)group;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
