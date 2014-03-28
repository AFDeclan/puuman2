//
//  ChildMenuButton.h
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubTypeButton : UIButton
{
    UILabel *title;
    UIImageView *selectedEffect;
}
@property (assign,nonatomic)NSInteger typeIndex;
@property (assign,nonatomic)NSInteger subIndex;
@property (assign,nonatomic)BOOL isSelected;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)str;
- (void)selected;
- (void)unSelected;
@end
