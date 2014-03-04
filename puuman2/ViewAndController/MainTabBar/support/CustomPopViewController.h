//
//  CustomPopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"



@interface CustomPopViewController : PopViewController
{
    UIImageView *bgImgView;
    UILabel *_titleLabel;
    UIImageView *icon;
    UIButton *_closeBtn;
    UIButton *_finishBtn;
}
@property(assign,nonatomic)ControlBtnType controlBtnType;
- (void)setTitle:(NSString *)title withIcon:(UIImage *)image;
- (void)show;
@end
