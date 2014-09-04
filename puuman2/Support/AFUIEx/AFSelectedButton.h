//
//  AFSelectedButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFTextImgButton.h"

@interface AFSelectedButton : AFTextImgButton
{
    UIImageView *mark;

}

- (void)selectedButton;
- (void)unSelectedButton;
@end
