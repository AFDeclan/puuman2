//
//  SettingViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "AFTextImgButton.h"
#import "ColorButton.h"

@interface SettingViewController : PopViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *settingTable;
    BOOL canSelected;
    AFTextImgButton *backBtn;
    ColorButton *logOut;
    UILabel *versionLabel;
}
- (void)show;
- (void)back;
@end
