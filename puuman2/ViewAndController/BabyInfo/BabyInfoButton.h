//
//  BabyInfoButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFSelecedTextImgButton.h"
typedef enum
{
    kBodyButton,
    kVaccineButton,
    kPuumanButton,
    kPropButton,
    kBpreButton,
    kPreButton
}BabyInfoButtonType;
@interface BabyInfoButton : AFSelecedTextImgButton
@property(assign,nonatomic)BabyInfoButtonType type;

@end
