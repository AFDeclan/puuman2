//
//  CustomAlertViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "AFTextImgButton.h"

@interface CustomAlertViewController : PopViewController
{
    UIImageView *bgImgView;
    UILabel *_titleLabel;
    AFTextImgButton *_closeBtn;
    AFTextImgButton *_finishBtn;
}
@property(assign,nonatomic)ControlBtnType controlBtnType;

- (void)showWithTitle:(NSString *)title;
- (void)show;
- (void)finishOut;
@end
