//
//  AFSelecedTextImgButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFSelecedTextImgButton.h"
#import "ColorsAndFonts.h"

@implementation AFSelecedTextImgButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization codes
        [self setAdjustsImageWhenDisabled:NO];
    }
    return self;
}

- (id)init
{

    return  [self initWithFrame:CGRectMake(0, 0, 64, 96)];
}

- (void)setSelectedImg:(UIImage *)imgOne andUnselectedImg:(UIImage *)imgTwo;
{
    selectedImg = imgOne;
    unSelectedImg = imgTwo;
    _selectType = kSelectedImage;
  
}

- (void)selected
{
    [self setEnabled:NO];
    switch (_selectType) {
        case kSelectedImage:
             [self setImage:selectedImg forState:UIControlStateNormal];
            break;
        case kBlueAndClear:
        {
            [self resetImage:selectedImg];
            [self setBackgroundColor:PMColor6];
            [_titleLabel setTextColor:[UIColor whiteColor]];
        }
            
            break;
        case kNoneClear:
        {
            [self resetImage:selectedImg];
        }
            break;
        default:
            break;
    }
   
}

- (void)unSelected
{
    [self setEnabled:YES];
    switch (_selectType) {
        case kSelectedImage:
            [self setImage:unSelectedImg forState:UIControlStateNormal];
            break;
        case kBlueAndClear:
        {
            [self resetImage:unSelectedImg];
            [self setBackgroundColor:[UIColor whiteColor]];
            [_titleLabel setTextColor:PMColor6];
        }
            break;
        case kNoneClear:
        {
            [self resetImage:unSelectedImg];
        }
            break;
        default:
            break;
    }
    

   

}

- (void)setSelectedImg:(UIImage *)imgOne andUnselectedImg:(UIImage *)imgTwo andTitle:(NSString *)title andButtonType:(TextImgBtnType)type andSelectedType:(SelectedTextImgButton)selectedType
{
   
    selectedImg = imgOne;
    unSelectedImg = imgTwo;
    _selectType = selectedType;
    btnType = type;
    _title = title;
    [self setTitle:_title andImg:selectedImg andButtonType:btnType];
}

- (void)resetTitle:(NSString *)title
{
    [_titleLabel setText:title];
    [self adjustLayout];
}

@end
