//
//  LocationSelectedView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationSelectedView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *locationTable;
    NSInteger selectedNum;
}
@end