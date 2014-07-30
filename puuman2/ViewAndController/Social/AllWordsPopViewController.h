//
//  AllWordsPopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "AFColorButton.h"
#import "Reply.h"
#import "Forum.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"


@interface AllWordsPopViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate,ForumDelegate,UITextFieldDelegate,MJRefreshBaseViewDelegate>
{
    CustomTextField *talkTextField;
    UITableView *talksTable;
    AFColorButton *createTalkBtn;
    MJRefreshFooterView *_refreshFooter;
    MJRefreshHeaderView *_refreshHeader;
   NSInteger commentNum;
}

@property(nonatomic,assign)NSInteger row;

@property(retain,nonatomic)Reply *replay;
@end
