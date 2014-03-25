//
//  AFSelecedTextImgButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"

typedef enum {
    kBlueAndClear,
    kNoneClear,
    kSelectedImage
}SelectedTextImgButton;


@interface AFSelecedTextImgButton : AFTextImgButton
{
    UIImage *selectedImg;
    UIImage *unSelectedImg;
    SelectedTextImgButton _selectType;
}

- (void)resetTitle:(NSString *)title;

- (void)setSelectedImg:(UIImage *)imgOne andUnselectedImg:(UIImage *)imgTwo;
- (void)setSelectedImg:(UIImage *)imgOne andUnselectedImg:(UIImage *)imgTwo andTitle:(NSString *)title andButtonType:(TextImgBtnType)type andSelectedType:(SelectedTextImgButton)selectedType;
- (void)selected;
- (void)unSelected;
@end
