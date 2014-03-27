//
//  RewardViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"

@interface RewardViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate>
{
    ColorButton *instructionBtn;
    ColorButton *createBtn;
    UITableView *rewardTable;
    UITableView *rankTable;
    
    UILabel *noti_label;
}
@end