//
//  BabyInfoBodyViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"
#import "BabyInfoIconViewDelegate.h"
#import "ChangePageControlButton.h"
#import "ShareSelectedViewController.h"

@interface BabyInfoBodyViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,BabyInfoIconViewDelegate,ShareViewDelegate>

{
    UITableView *dataTable;
    UIView *emptyView;
    UITableView *_lineChartView;
    AFColorButton *addDataBtn;
    AFColorButton *shareBtn;
    UILabel *noti_label;
    UIView  *leftView;
    UIView  *rightView;
    ChangePageControlButton *showAndHiddenBtn;
    UIButton *rightBtn;
    SocialType shareType;
    UIView *lineView;
    
}

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
@property (nonatomic,retain) NSString *filePath;

- (void)refresh;

@end
