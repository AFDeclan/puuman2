//
//  ColorButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"
typedef enum{

    kRedLeftUp,
    kRedLeftDown,
    kBlueLeft,
    kBlueRight,
    kBlueLeftUp,
    kBlueLeftDown,
    kGrayLeftUp,
    kGrayLeftDown,
    kGrayLeft,
    kGrayRight

} ColorBtnType;

@interface ColorButton : AFTextImgButton
{
    ColorBtnType _type;
    UIImage *icon;
    NSString *title;
}
- (void)initWithTitle:(NSString *)str  andButtonType:(ColorBtnType)type;
- (void)initWithTitle:(NSString *)str andIcon:(UIImage *)img andButtonType:(ColorBtnType)type;

@end
