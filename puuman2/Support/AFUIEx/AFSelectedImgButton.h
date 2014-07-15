//
//  AFSelectedImgButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFButton.h"

@interface AFSelectedImgButton : AFButton

@property(nonatomic,retain)UIImage *selectedImg;
@property(nonatomic,retain)UIImage *unSelectedImg;
- (void)selected;
- (void)unSelected;
@end
