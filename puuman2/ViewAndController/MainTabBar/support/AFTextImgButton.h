//
//  AFTextImgButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    kButtonTypeOne,
    kButtonTypeTwo,
    kButtonTypeThree,
    kButtonTypeFour,
    kButtonTypeFive,
    kButtonTypeSix,
    kButtonTypeSeven,
    kButtonTypeEight,
    kButtonTypeNine,
    kButtonTypeTen
    
}TextImgBtnType;
@interface AFTextImgButton : UIButton
{
    UILabel *_titleLabel;
    UIImageView *_iconView;
    TextImgBtnType btnType;
    UIImageView *mark;
    UIImageView *backgroundImgView;
    NSString *_title;
}
- (void)selected;
- (void)unSelected;
@property (nonatomic, assign)  UIColor *titleLabelColor;

- (void)setTitle:(NSString *)title andImg:(UIImage *)image andButtonType:(TextImgBtnType)type;


@end
