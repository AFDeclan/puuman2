//
//  TopicCommentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "AFTextImgButton.h"
#import "Reply.h"
#import "Forum.h"

@interface TopicCommentView : UIView<ForumDelegate>
{
    UITextField *textField;
    
    UITableView *commentsTable;
    ColorButton *createBtn;
    AFTextImgButton *scanMoreReplay;

}
- (void)setCommentWithReply:(Reply *)reply;
@end
