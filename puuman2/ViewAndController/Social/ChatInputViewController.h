//
//  ChatInputViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "ChatInputTextView.h"
#import "AFColorButton.h"
#import "Reply.h"
#import "ReplyForUpload.h"
#import "Forum.h"
#import "Friend.h"

@interface ChatInputViewController : PopViewController<UITextViewDelegate,ForumDelegate,FriendDelegate>

{
    ChatInputTextView *inputTextView;
    AFColorButton *createBtn;
    UIView *bg_inputView;
    BOOL input_now;
    float maxHeight;
    float minHeight;
    float preheight;
    int addHeightNum;
    float keyBoardHeigh;
}
@property(retain,nonatomic)id actionParent;
@property(assign,nonatomic)BOOL sendIsHidden;

- (void)show;
- (void)hidden;
- (void)reset;
@end

