//
//  PopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopUpViewController.h"
typedef enum
{
    kCloseAndFinishButton,
    kOnlyCloseButton,
    kOnlyFinishButton,
    kNoneButton
}ControlBtnType;
@protocol PopViewDelegate;
@interface PopViewController : PopUpViewController
{
    UIView *bgView;
    UIView *_content;
}
@property(assign,nonatomic) id<PopViewDelegate> delegate;
- (void)initialization;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
- (void)dismiss;
@end
@protocol PopViewDelegate <NSObject>
@optional
- (void)popViewfinished;
- (void)popStartHidden;
@end