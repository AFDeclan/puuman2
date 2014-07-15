//
//  AFColorButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFColorButton.h"
#import "UniverseConstant.h"

static NSString *backgroundColorImages[3][6] = {
    {@"btn_red1.png",@"btn_red2.png",@"btn_red3.png",@"btn_red4.png",@"btn_red5.png",@"btn_red6.png"},
    {@"btn_blue1.png",@"btn_blue2.png",@"btn_blue3.png",@"btn_blue4.png",@"btn_blue5.png",@"btn_blue6.png"},
    {@"btn_gray1.png",@"btn_gray2.png",@"btn_gray3.png",@"btn_gray4.png",@"btn_gray5.png",@"btn_gray6.png"}
};

@implementation AFColorButton
@synthesize colorType = _colorType;
@synthesize directionType = _directionType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _colorType = kColorButtonBlueColor;
        _directionType = kColorButtonLeft;
        [self.title setFont:PMFont2];

    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 112, 40)];
}

- (void)resetColorButton
{

    [self adjustLayout];
    [self setImage:[UIImage imageNamed:backgroundColorImages[_colorType][_directionType]] forState:UIControlStateNormal];
    if (_colorType == kColorButtonGrayColor) {
        [self.title setTextColor:PMColor2];

    }else{
        [self.title setTextColor:[UIColor whiteColor]];


    }
}

- (void)selected
{
    [super selected];
    [self setImage:[UIImage imageNamed:backgroundColorImages[_colorType][_directionType]] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)unSelected
{
    [super unSelected];
    [self setImage:nil forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
}
@end
