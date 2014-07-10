//
//  BabyInfoBodyViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "BabyInfoIconViewDelegate.h"
#import "BabyInfoPageControlButton.h"
#import "ShareSelectedViewController.h"

@interface BabyInfoBodyViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,BabyInfoIconViewDelegate,ShareViewDelegate>

{
    UITableView *dataTable;
    UIView *emptyView;
    UITableView *_lineChartView;
    ColorButton *addDataBtn;
    ColorButton *shareBtn;
    UILabel *noti_label;
    UIView  *leftView;
    UIView  *rightView;
    BabyInfoPageControlButton *showAndHiddenBtn;
    UIButton *rightBtn;
    SocialType shareType;
    
}

@property (nonatomic,assign) id<BabyInfoIconViewDelegate>delegate;
@property (nonatomic,retain) NSString *filePath;

- (void)refresh;

@end
