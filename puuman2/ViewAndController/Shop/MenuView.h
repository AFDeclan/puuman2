//
//  MenuView.h
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeButton.h"
#import "SubTypeButton.h"

#define kParentBtnNum 14
#define kChildeBtnNUm 11
@interface MenuView : UIView
{
    UIView *parentMenu;
    TypeButton *_typeBtn[kParentBtnNum-1];
    SubTypeButton *_subTypeBtn[kParentBtnNum][kChildeBtnNUm];
    UIView *childMenu;
    TypeButton *selectedBtn;
    SubTypeButton *selectedSubBtn;
    TypeButton *backBtn;
}


- (void)showShopWithTypeIndex:(NSInteger)typeIndex andSubIndex:(NSInteger)subIndex;
- (void)selectedParentIndex:(NSInteger)parentIndex andChildIndex:(NSInteger)childIndex;
@end
