//
//  CustomNotiViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "AFTextImgButton.h"
typedef   enum {
    kTypeStyleRight,
    kTypeStyleError,
    kTypeStyleNone
}TypeStyle;
@interface CustomNotiViewController : PopViewController
{

    NSTimer *timer;
    AFTextImgButton *notiView;
}

- (void)initWithTitle:(NSString *)title andStyle:(TypeStyle)typeStyle;
+ (void)showNotiWithTitle:(NSString *)title withTypeStyle:(TypeStyle)style;

@end
