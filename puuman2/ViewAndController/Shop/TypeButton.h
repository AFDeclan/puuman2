//
//  ParentMenuButton.h
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    SingleShopBtn,
    SubShopBtn
}ButtonType;

@interface TypeButton : UIButton
{
    UIImageView *icon;
    UILabel *title;
    UIImageView *selectedEffect;

    
}
@property (assign,nonatomic)ButtonType state;
@property (assign,nonatomic)NSInteger typeIndex;
@property (assign,nonatomic)BOOL isSelected;
- (void)initWithIconImg:(UIImage *)img andTitle:(NSString *)str andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font;
- (void)selected;
- (void)unSelected;
@end
