//
//  SettingViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "AFTextImgButton.h"
#import "AFColorButton.h"

@interface SettingViewController : PopViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *settingTable;
    BOOL canSelected;
    AFTextImgButton *backBtn;
    AFColorButton *logOut;
    UILabel *versionLabel;
}

- (void)showSettingView;
- (void)show;
- (void)back;
@end
