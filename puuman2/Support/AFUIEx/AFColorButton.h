//
//  AFColorButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFSelectedTextImgButton.h"
typedef enum{
    kColorButtonRedColor,
    kColorButtonBlueColor,
    kColorButtonGrayColor,
}ColorButtonColorType;

typedef enum{
    kColorButtonLeft,
    kColorButtonLeftUp,
    kColorButtonLeftDown,
    kColorButtonRight,
    kColorButtonRightUp,
    kColorButtonRightDown
}ColorButtonDirectionType;

@interface AFColorButton :AFSelectedTextImgButton
{
    
}

@property(nonatomic,assign)ColorButtonColorType colorType;
@property(nonatomic,assign)ColorButtonDirectionType directionType;

- (void)resetColorButton;
@end
