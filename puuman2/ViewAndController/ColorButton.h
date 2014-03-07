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
    kBlueLeftDown,
    kGrayLeftUp,
    kGrayLeftDown,
    kGrayLeft,
    kGrayRight

} ColorBtnType;

@interface ColorButton : AFTextImgButton
{

}
- (void)initWithTitle:(NSString *)str andButtonType:(ColorBtnType)type;
@end
