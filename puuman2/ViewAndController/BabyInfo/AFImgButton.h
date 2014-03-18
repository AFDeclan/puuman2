//
//  AFImgButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-12.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"

@interface AFImgButton : UIButton
{
    UIImage *selectedImg;
    UIImage *unSelectedImg;
}
- (void)setSelectedImg:(UIImage *)imgOne andUnselectedImg:(UIImage *)imgTwo;
- (void)selected;
- (void)unSelected;
@end
