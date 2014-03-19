//
//  ColorButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ColorButton.h"
#import "ColorsAndFonts.h"

@implementation ColorButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 112, 40)];
}

- (void)initWithTitle:(NSString *)str  andButtonType:(ColorBtnType)type
{
    
    [self initWithTitle:str andIcon:nil andButtonType:type];
}


- (void)initWithTitle:(NSString *)str  andIcon:(UIImage *)img andButtonType:(ColorBtnType)type
{
    _type = type;
    icon = img;
    title = str;
    [self setTitle:str andImg:img andButtonType:kButtonTypeTwo];
    
    [self setBackgroundColor:[UIColor clearColor]];
    switch (type) {
        case kRedLeftUp:
            [self setTitleLabelColor:[UIColor whiteColor]];
            [backgroundImgView setImage:[UIImage imageNamed:@"btn_red2.png"]];
            break;
        case kRedLeftDown:
            [self setTitleLabelColor:[UIColor whiteColor]];
            [backgroundImgView setImage:[UIImage imageNamed:@"btn_red.png"]];
            break;
        case kBlueLeft:
            [self setTitleLabelColor:[UIColor whiteColor]];
            [backgroundImgView setImage:[UIImage imageNamed:@"btn_blue1.png"]];
            break;
        case kBlueLeftDown:
            [self setTitleLabelColor:[UIColor whiteColor]];
            [backgroundImgView setImage:[UIImage imageNamed:@"btn_blue3.png"]];

            break;
        case kBlueLeftUp:
            [self setTitleLabelColor:[UIColor whiteColor]];
            [backgroundImgView setImage:[UIImage imageNamed:@"btn_blue4.png"]];
            break;
        case kBlueRight:
            [self setTitleLabelColor:[UIColor whiteColor]];
            [backgroundImgView setImage:[UIImage imageNamed:@"btn_blue2.png"]];
            break;
        case kGrayLeft:
            [self setTitleLabelColor:PMColor2];
            [backgroundImgView setImage:[UIImage imageNamed:@"block1_btn.png"]];
            break;
        case kGrayRight:
            [self setTitleLabelColor:PMColor2];
            [backgroundImgView setImage:[UIImage imageNamed:@"block3_btn.png"]];
            break;
        case kGrayLeftUp:
            [self setTitleLabelColor:PMColor2];
            [backgroundImgView setImage:[UIImage imageNamed:@"block2_btn.png"]];
            break;
        case kGrayLeftDown:
            [self setTitleLabelColor:PMColor2];
            [backgroundImgView setImage:[UIImage imageNamed:@"block4_btn.png"]];
            break;

        default:
            break;
    }
}

- (void)selected
{
    [self initWithTitle:title andIcon:icon andButtonType:_type];
}

- (void)unSelected
{
    [self setTitleLabelColor:PMColor6];
    [backgroundImgView setImage:nil];
}
@end
