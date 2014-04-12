//
//  CustomAlertViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "AFTextImgButton.h"

typedef void(^CustomAlertViewHandler)();
typedef enum  {
     Question, ConfirmRight,ConfirmError
}AlertStyle;
@interface CustomAlertViewController : PopViewController
{
    UIImageView *bgImgView;
    UILabel *_titleLabel;
    AFTextImgButton *_closeBtn;
    AFTextImgButton *_finishBtn;
   
}
@property (strong, nonatomic) CustomAlertViewHandler confirmHandler;
@property (strong, nonatomic) CustomAlertViewHandler cancelHandler;
@property(assign,nonatomic)AlertStyle style;


+ (void)showAlertWithTitle:(NSString *)title confirmHandler:(CustomAlertViewHandler)confirm cancelHandler:(CustomAlertViewHandler)cancel;
+ (void)showAlertWithTitle:(NSString *)title confirmErrorHandler:(CustomAlertViewHandler)confirm;
+ (void)showAlertWithTitle:(NSString *)title confirmRightHandler:(CustomAlertViewHandler)confirm;

+ (void)showAlertWithTitle:(NSString *)title confirmHandler:(CustomAlertViewHandler)confirm cancelHandler:(CustomAlertViewHandler)cancel fromViewController:(UIViewController *)viewController;
+ (void)showAlertWithTitle:(NSString *)title confirmErrorHandler:(CustomAlertViewHandler)confirm fromViewController:(UIViewController *)viewController;
+ (void)showAlertWithTitle:(NSString *)title confirmRightHandler:(CustomAlertViewHandler)confirm fromViewController:(UIViewController *)viewController;

- (void)showWithTitle:(NSString *)title;
- (void)show;
- (void)finishOut;
@end
