//
//  DynamicView.h
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *titleLabel;
    UITableView  *diaryTable;
    NSArray *diaryArray;
}
@end
