//
//  AFSelectedTextImgButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"

@interface AFSelectedTextImgButton : AFTextImgButton

@property(nonatomic,retain)UIImage *selectedImg;
@property(nonatomic,retain)UIImage *unSelectedImg;
@property(nonatomic,retain)UIColor *selectedColor;
@property(nonatomic,retain)UIColor *unSelectedColor;

- (void)selected;
- (void)unSelected;
@end
