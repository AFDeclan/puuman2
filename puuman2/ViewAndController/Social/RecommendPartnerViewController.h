//
//  RecommendPartnerViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"

@interface RecommendPartnerViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *recommentTable;
    ColorButton *changeBtn;
    ColorButton *inviteBtn;
}
@end
