//
//  BabyBodyView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "ColorButton.h"



@interface BabyBodyView : BabyInfoContentView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *dataTable;
    UIView *emptyView;
    UITableView *_lineChartView;
    ColorButton *addDataBtn;
    UILabel *noti_label;
    

}
- (void)refresh;
@end
