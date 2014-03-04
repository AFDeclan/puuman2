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
    kButtonTypeTwo
    
}TextImgBtnType;
@interface AFTextImgButton : UIButton
{
    UILabel *_titleLabel;
    UIImageView *_iconView;
    TextImgBtnType btnType;
}
@property (nonatomic, assign)  UIColor *titleLabelColor;

- (void)setTitle:(NSString *)title andImg:(UIImage *)image andButtonType:(TextImgBtnType)type;

@end
