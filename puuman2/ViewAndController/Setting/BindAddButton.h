//
//  BindAddButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindAddButton : UIButton
{
    UIImageView *bg_black;
    UILabel *add;
}
@property(assign,nonatomic)BOOL empty;
- (void)showAdd;
- (void)hiddenAdd;
@end
