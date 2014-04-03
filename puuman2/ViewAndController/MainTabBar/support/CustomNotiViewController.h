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
    kNotiTypeStyleRight,
    kNotiTypeStyleNone
}NotiTypeStyle;
@interface CustomNotiViewController : PopViewController
{

    NSTimer *timer;
    AFTextImgButton *notiView;
    NotiTypeStyle notiType;
}

- (void)initWithTitle:(NSString *)title andStyle:(NotiTypeStyle)typeStyle;
+ (void)showNotiWithTitle:(NSString *)title withTypeStyle:(NotiTypeStyle)style;

@end
