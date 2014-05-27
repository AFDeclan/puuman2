//
//  ShareSelectedViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface ShareSelectedViewController : CustomAlertViewController
{
    UILabel *weiboLabel;
    UILabel *weiXinLabel;
    UIButton *weiboBtn;
    UIButton *weiXinBtn;
    NSString *shareText;
    NSString *shareTitle;
    UIImage *shareImg;
}

+ (void)shareText:(NSString *)sharetext_ title:(NSString *)title image:(UIImage *)img;

@end
