//
//  TopicCommentView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"
#import "AFTextImgButton.h"
#import "Reply.h"
#import "Forum.h"
#import "TopicCommentCell.h"
@interface TopicCommentView : UIView<ForumDelegate,PopViewDelegate,UITextFieldDelegate>
{
    UITextField *commentText;
    
    UITableView *commentsTable;
    AFColorButton *createBtn;
    AFTextImgButton *scanMoreReplay;
    TopicCommentCell*comments[5];
    Reply *_reply;
}
- (void)setCommentWithReply:(Reply *)reply;
@end
