//
//  AllWordsPopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "ColorButton.h"
#import "Reply.h"
#import "Forum.h"

@interface AllWordsPopViewController : CustomPopViewController<UITableViewDataSource,UITableViewDelegate,ForumDelegate,UITextFieldDelegate>
{
    CustomTextField *talkTextField;
    UITableView *talksTable;
    ColorButton *createTalkBtn;
}
@property(retain,nonatomic)Reply *replay;
@end
