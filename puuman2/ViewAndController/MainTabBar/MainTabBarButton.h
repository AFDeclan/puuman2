//
//  MainTabBarButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFButton.h"

typedef enum{
    
    kTypeTabBarOfDiary = 1,
    kTypeTabBarOfSocial,
    kTypeTabBarOfShop,
    kTypeTabBarOfSetting,
    kTypeTabBarOfNone
}TypeTabBarButton;

#define MainTabBarButtonanimateTime 0.5
@interface MainTabBarButton : AFButton
{
    UIImageView *flagImageView;
}

@property(assign,nonatomic)BOOL animate;

@end
