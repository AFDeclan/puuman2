//
//  BabyInfoPropViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropView.h"
#import "BabyInfoIconViewDelegate.h"
#import "AFColorButton.h"
#import "ChangePageControlButton.h"

@interface BabyInfoPropViewCell : UITableViewCell<BabyInfoIconViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PropView *babyPropView;
   // UIView *rightView;
    UIView *contentView;
    UIView *leftView;
    UITextField *estiTextField;
    UITableView *estiTableView;
    AFColorButton *estiBtn;
    NSMutableArray *estiArrayData;
    UIButton *leftBtn;
    UIView *estiView;
    ChangePageControlButton *showAndHiddenBtn;
    UIView *lineView;
    BOOL evaShowed;
    UIButton *backBtn;
}

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
- (void)refresh;

@end
