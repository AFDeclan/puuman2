//
//  RankView.h
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankView : UIView <UITableViewDataSource, UITableViewDelegate>
{

    UITableView *sortTable;
    //bool YES for 展开
    NSMutableDictionary *_sectionState;
}

//筛选项已变动
-(void)sortTableReload;
//筛选项未变，筛选值可能有变动
-(void)sortTableUpdate;
-(void)setVerticalFrame;
-(void)setHorizontalFrame;

@end
