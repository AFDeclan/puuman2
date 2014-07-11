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
#import "ColorButton.h"
#import "BabyInfoPageControlButton.h"

@interface BabyInfoPropViewCell : UITableViewCell<BabyInfoIconViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PropView *babyPropView;
    UIView *rightView;
    UIView *leftView;
    UITextField *estiTextField;
    UITableView *estiTableView;
    ColorButton *estiBtn;
    NSMutableArray *estiArrayData;
    UIButton *leftBtn;
    UIView *estiView;
    BabyInfoPageControlButton *showAndHiddenBtn;
    UIView *lineView;
    BOOL evaShowed;
}

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
- (void)refresh;

@end
