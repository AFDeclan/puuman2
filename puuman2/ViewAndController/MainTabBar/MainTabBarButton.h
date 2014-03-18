//
//  MainTabBarButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFButton.h"
#define animateTime 0.5
@interface MainTabBarButton : AFButton
{
    UIImageView *flag;
}
@property(assign,nonatomic)UIImage *normalImage;
@property(assign,nonatomic)UIImage *selectedImage;
@property(assign,nonatomic)BOOL selected;
- (void)setSelected:(BOOL)selected withAnimate:(BOOL)animate;
@end
